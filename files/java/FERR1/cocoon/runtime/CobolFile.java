package cocoon.runtime;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.RandomAccessFile;

/**
 * A COBOL file, as GnuCOBOL's file handler keeps it: LINE SEQUENTIAL
 * (records as lines, trailing spaces dropped on write, padded with spaces
 * on read) or record sequential (fixed-length records, the bytes as they
 * are). Every operation returns its two-character FILE STATUS.
 */
public final class CobolFile {

    public static final int LINE_SEQUENTIAL = 1;
    public static final int SEQUENTIAL = 2;
    public static final int INDEXED = 3;
    public static final int ACCESS_SEQUENTIAL = 1;
    public static final int ACCESS_RANDOM = 2;
    public static final int ACCESS_DYNAMIC = 3;
    public static final int INPUT = 1;
    public static final int OUTPUT = 2;
    public static final int IO = 3;
    public static final int EXTEND = 4;

    public final String name;
    private final String assign;
    private final boolean literal;
    private final int org;
    private final int size;
    private int mode;
    private boolean atEnd;
    private InputStream in;
    private OutputStream out;
    private RandomAccessFile raf;
    private long lastPos = -1;
    private int lastLen;
    // INDEXED: the records by their prime key, in key order (bytes compared unsigned,
    // as GnuCOBOL's indexed handler compares them), and where READ NEXT goes on from
    private int keyOff;
    private int keyLen;
    private int access = ACCESS_SEQUENTIAL;
    private java.util.TreeMap<byte[], byte[]> index;
    private byte[] position;            // the key READ NEXT starts after, or before (exclusive/inclusive)
    private boolean positionInclusive;
    private byte[] lastKey;             // the key of the record last read (for sequential REWRITE/DELETE)
    private boolean dirty;

    public CobolFile(String name, String assign, boolean literal, int org, int size) {
        this.name = name;
        this.assign = assign;
        this.literal = literal;
        this.org = org;
        this.size = size;
    }

    public CobolFile(String name, String assign, boolean literal, int size, int keyOff, int keyLen, int access) {
        this(name, assign, literal, INDEXED, size);
        this.keyOff = keyOff;
        this.keyLen = keyLen;
        this.access = access;
    }

    // keys in byte order; an anonymous class, as ecj compiles at a level before method references
    private static final java.util.Comparator<byte[]> KEY_ORDER = new java.util.Comparator<byte[]>() {
        public int compare(byte[] a, byte[] b) {
            return cmp(a, b);
        }
    };

    private static int cmp(byte[] a, byte[] b) {
        int n = Math.min(a.length, b.length);
        for (int i = 0; i < n; i++) {
            int x = a[i] & 0xff, y = b[i] & 0xff;
            if (x != y) {
                return x - y;
            }
        }
        return a.length - b.length;
    }

    private byte[] keyOf(byte[] rec) {
        return java.util.Arrays.copyOfRange(rec, keyOff, keyOff + keyLen);
    }

    private void load(File f) throws IOException {
        index = new java.util.TreeMap<byte[], byte[]>(KEY_ORDER);
        if (!f.exists()) {
            return;
        }
        try (java.io.DataInputStream d = new java.io.DataInputStream(new BufferedInputStream(new FileInputStream(f)))) {
            while (true) {
                int n;
                try {
                    n = d.readInt();
                } catch (java.io.EOFException e) {
                    break;
                }
                byte[] r = new byte[n];
                d.readFully(r);
                index.put(keyOf(r), r);
            }
        }
    }

    private void save() throws IOException {
        try (java.io.DataOutputStream d = new java.io.DataOutputStream(new BufferedOutputStream(new FileOutputStream(path(), false)))) {
            for (byte[] r : index.values()) {
                d.writeInt(r.length);
                d.write(r);
            }
        }
    }

    /** The file's path: as GnuCOBOL maps an external name, DD_name, dd_name, name, then the name itself. */
    String path() {
        if (!literal) {
            for (String k : new String[] {"DD_" + assign, "dd_" + assign, assign}) {
                String v = System.getenv(k);
                if (v != null && !v.isEmpty()) {
                    return v;
                }
            }
        }
        return assign;
    }

    public String open(int m) {
        if (mode != 0) {
            return "41";
        }
        String p = path();
        File f = new File(p);
        if (org == INDEXED) {
            try {
                if ((m == INPUT || m == IO) && !f.exists()) {
                    return "35";
                }
                if (m == OUTPUT) {
                    index = new java.util.TreeMap<byte[], byte[]>(KEY_ORDER);
                    dirty = true;
                } else {
                    load(f);
                    dirty = m == EXTEND;
                }
            } catch (IOException e) {
                return "30";
            }
            mode = m;
            atEnd = false;
            position = null;
            positionInclusive = true;
            lastKey = null;
            return "00";
        }
        try {
            switch (m) {
                case INPUT:
                    if (!f.exists()) {
                        return "35";
                    }
                    in = new BufferedInputStream(new FileInputStream(f));
                    break;
                case OUTPUT:
                    out = new BufferedOutputStream(new FileOutputStream(f, false));
                    break;
                case EXTEND:
                    out = new BufferedOutputStream(new FileOutputStream(f, true));
                    break;
                case IO:
                    if (!f.exists()) {
                        return "35";
                    }
                    raf = new RandomAccessFile(f, "rw");
                    break;
                default:
                    return "30";
            }
        } catch (IOException e) {
            return f.exists() ? "37" : "30";
        }
        mode = m;
        atEnd = false;
        lastPos = -1;
        return "00";
    }

    public String close() {
        if (mode == 0) {
            return "42";
        }
        if (org == INDEXED) {
            try {
                if (mode != INPUT && (dirty || mode == OUTPUT)) {
                    save();
                }
            } catch (IOException e) {
                return "30";
            } finally {
                index = null;
                mode = 0;
            }
            return "00";
        }
        try {
            if (in != null) {
                in.close();
            }
            if (out != null) {
                out.close();
            }
            if (raf != null) {
                raf.close();
            }
        } catch (IOException e) {
            return "30";
        } finally {
            in = null;
            out = null;
            raf = null;
            mode = 0;
        }
        return "00";
    }

    /** Close quietly at the end of the run, as STOP RUN closes what is open. */
    public void closeAtEnd() {
        if (mode != 0) {
            close();
        }
    }

    private int next() throws IOException {
        return raf != null ? raf.read() : in.read();
    }

    /** Read the next record into area: for an indexed file, the next by key. */
    public String read(byte[] area) {
        if (mode != INPUT && mode != IO) {
            return "47";
        }
        if (atEnd) {
            return "46";
        }
        if (org == INDEXED) {
            java.util.Map.Entry<byte[], byte[]> e = position == null ? index.firstEntry()
                : (positionInclusive ? index.ceilingEntry(position) : index.higherEntry(position));
            if (e == null) {
                atEnd = true;
                return "10";
            }
            byte[] r = e.getValue();
            java.util.Arrays.fill(area, (byte) ' ');
            System.arraycopy(r, 0, area, 0, Math.min(r.length, area.length));
            position = e.getKey();
            positionInclusive = false;
            lastKey = e.getKey();
            return "00";
        }
        try {
            if (raf != null) {
                lastPos = raf.getFilePointer();
            }
            if (org == LINE_SEQUENTIAL) {
                java.io.ByteArrayOutputStream line = new java.io.ByteArrayOutputStream();
                int c = next();
                if (c < 0) {
                    atEnd = true;
                    return "10";
                }
                while (c >= 0 && c != '\n') {
                    line.write(c);
                    c = next();
                }
                byte[] b = line.toByteArray();
                int n = b.length;
                if (n > 0 && b[n - 1] == '\r') {
                    n--;
                }
                java.util.Arrays.fill(area, (byte) ' ');
                System.arraycopy(b, 0, area, 0, Math.min(n, area.length));
                lastLen = n;
                return "00";
            }
            int got = 0;
            byte[] rec = new byte[size];
            while (got < size) {
                int c = next();
                if (c < 0) {
                    break;
                }
                rec[got++] = (byte) c;
            }
            if (got == 0) {
                atEnd = true;
                return "10";
            }
            System.arraycopy(rec, 0, area, 0, Math.min(got, area.length));
            lastLen = got;
            return got == size ? "00" : "04";
        } catch (IOException e) {
            return "30";
        }
    }

    /** Write len bytes of data as one record. */
    public String write(byte[] data, int len) {
        if (org == INDEXED) {
            if (mode != OUTPUT && mode != EXTEND && !(mode == IO && access != ACCESS_SEQUENTIAL)) {
                return "48";
            }
            byte[] r = java.util.Arrays.copyOf(data, len);
            byte[] k = keyOf(r);
            if (index.containsKey(k)) {
                return "22";
            }
            if (access == ACCESS_SEQUENTIAL && !index.isEmpty() && cmp(k, index.lastKey()) <= 0) {
                return "21";
            }
            index.put(k, r);
            dirty = true;
            return "00";
        }
        if (mode != OUTPUT && mode != EXTEND) {
            return "48";
        }
        try {
            if (org == LINE_SEQUENTIAL) {
                int n = Math.min(len, data.length);
                // GnuCOBOL checks a LINE SEQUENTIAL record before writing it: a byte
                // below space is invalid data, status 71, and nothing is written
                for (int i = 0; i < n; i++) {
                    if ((data[i] & 0xff) < 0x20) {
                        return "71";
                    }
                }
                while (n > 0 && data[n - 1] == ' ') {
                    n--;
                }
                out.write(data, 0, n);
                out.write('\n');
            } else {
                out.write(data, 0, Math.min(len, data.length));
                for (int i = data.length; i < len; i++) {
                    out.write(' ');
                }
            }
            return "00";
        } catch (IOException e) {
            return "30";
        }
    }

    /** Rewrite the record last read, in I-O mode: the same length, in place. */
    public String rewrite(byte[] data, int len) {
        if (mode != IO) {
            return "49";
        }
        if (org == INDEXED) {
            byte[] r = java.util.Arrays.copyOf(data, len);
            byte[] k = keyOf(r);
            if (access == ACCESS_SEQUENTIAL && (lastKey == null || cmp(k, lastKey) != 0)) {
                return "21";
            }
            if (!index.containsKey(k)) {
                return "23";
            }
            index.put(k, r);
            dirty = true;
            return "00";
        }
        if (lastPos < 0) {
            return "43";
        }
        if (org != SEQUENTIAL) {
            return "49";
        }
        if (len != lastLen) {
            return "44";
        }
        try {
            long here = raf.getFilePointer();
            raf.seek(lastPos);
            raf.write(data, 0, len);
            raf.seek(here);
            lastPos = -1;
            return "00";
        } catch (IOException e) {
            return "30";
        }
    }

    /** READ by key: the record whose prime key is the key now in the record area. */
    public String readKey(byte[] area) {
        if (mode != INPUT && mode != IO) {
            return "47";
        }
        byte[] k = keyOf(area);
        byte[] r = index.get(k);
        if (r == null) {
            return "23";
        }
        java.util.Arrays.fill(area, (byte) ' ');
        System.arraycopy(r, 0, area, 0, Math.min(r.length, area.length));
        position = k;
        positionInclusive = false;
        atEnd = false;
        lastKey = k;
        return "00";
    }

    /** START: position READ NEXT at the first key meeting the relation to the key now in the area. */
    public String start(byte[] area, String rel) {
        if (mode != INPUT && mode != IO) {
            return "47";
        }
        byte[] k = keyOf(area);
        byte[] at;
        switch (rel) {
            case "=":
                at = index.containsKey(k) ? k : null;
                break;
            case ">":
                at = index.higherKey(k);
                break;
            case ">=":
                at = index.ceilingKey(k);
                break;
            default:
                return "30";
        }
        if (at == null) {
            return "23";
        }
        position = at;
        positionInclusive = true;
        atEnd = false;
        return "00";
    }

    /** DELETE: the record whose key is in the area (random, dynamic) or the record last read (sequential). */
    public String delete(byte[] area) {
        if (mode != IO) {
            return "49";
        }
        byte[] k = access == ACCESS_SEQUENTIAL ? lastKey : keyOf(area);
        if (k == null) {
            return "43";
        }
        if (index.remove(k) == null) {
            return "23";
        }
        dirty = true;
        return "00";
    }
}
