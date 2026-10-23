import cocoon.runtime.CobolDecimal;
import cocoon.runtime.CobolText;
import cocoon.runtime.CobolRecord;
import java.math.BigDecimal;

/**
 * Translated from COBOL program FIDX.
 *
 * The arithmetic is deliberately not Java arithmetic. A
 * COBOL field holds what its PICTURE allows, and a value
 * too large loses its high-order digits without raising
 * anything. Every place this translation reproduces that
 * is marked TRUNCATES, because a faithful migration has
 * to compute the same numbers as the program it
 * replaces, defects included.
 */
public class Fidx {

    // Records: the bytes, laid out as the mainframe lays them out.
    private final CobolRecord r_IDX_REC = new CobolRecord("IDX-REC", 9,
        "000000000000000000");
    private final CobolRecord r_WS_FS = new CobolRecord("WS-FS", 2,
        "2020");
    private final CobolRecord r_WS_EOF = new CobolRecord("WS-EOF", 1,
        "4e");
    private final java.util.Map<String, CobolRecord> cocoonRecordMap = new java.util.LinkedHashMap<>();
    {
        cocoonRecordMap.put("IDX-REC", r_IDX_REC);
        cocoonRecordMap.put("WS-FS", r_WS_FS);
        cocoonRecordMap.put("WS-EOF", r_WS_EOF);
    }
    /** A record by its COBOL name; a caller binds a LINKAGE record's bytes here. */
    public CobolRecord record(String name) { return cocoonRecordMap.get(name); }
    public java.util.Map<String, CobolRecord> records() { return cocoonRecordMap; }

    // IDX-KEY PIC 9(3)
    private CobolDecimal idxKey;
    // IDX-NAME PIC X(6)
    private CobolText idxName;
    // WS-FS PIC XX
    private CobolText wsFs;
    // WS-EOF PIC X
    private CobolText wsEof;
    // IDX-REC (group, 9 bytes)
    private CobolText idxRec;

    private void cocoonInit0() {
        idxKey = new CobolDecimal(r_IDX_REC, 0, 3, 3, 0, false, 0, 0);
        idxName = new CobolText(r_IDX_REC, 3, 6);
        wsFs = new CobolText(r_WS_FS, 0, 2);
        wsEof = new CobolText(r_WS_EOF, 0, 1);
        idxRec = new CobolText(r_IDX_REC, 0, 9);
    }

    public Fidx() {
        cocoonInit0();
    }

    // Files: each SELECT, as GnuCOBOL's file handler keeps it.
    private final cocoon.runtime.CobolFile f_IDX_FILE = new cocoon.runtime.CobolFile("IDX-FILE", "IDXFILE", false, 9, 0, 3, cocoon.runtime.CobolFile.ACCESS_DYNAMIC);

    /** An I/O error no FILE STATUS item or phrase handles: GnuCOBOL's run time stops, status 1. */
    public static final class CocoonFileError extends RuntimeException {
        public final String file;
        public final String status;

        CocoonFileError(String file, String status) {
            super("libcob: error: file " + file + " (status = " + status + ")", null, false, false);
            this.file = file;
            this.status = status;
        }
    }

    private static void cocoonIoFail(cocoon.runtime.CobolFile f, String st) {
        throw new CocoonFileError(f.name, st);
    }

    /** STOP RUN closes every file still open. */
    public void cocoonCloseFiles() {
        f_IDX_FILE.closeAtEnd();
    }

    /** A number as GnuCOBOL's DISPLAY shows it: every digit of the picture, its point, its sign. */
    private static String cocoonDisplay(BigDecimal v, int ints, int decs, boolean signed) {
        BigDecimal a = v.abs().setScale(decs, java.math.RoundingMode.DOWN);
        String d = a.unscaledValue().toString();
        int want = ints + decs;
        if (d.length() < want) {
            StringBuilder z = new StringBuilder();
            for (int i = d.length(); i < want; i++) {
                z.append('0');
            }
            d = z + d;
        } else if (d.length() > want) {
            d = d.substring(d.length() - want);
        }
        String s = decs > 0 ? d.substring(0, ints) + "." + d.substring(ints) : d;
        return signed ? (v.signum() < 0 ? "-" : "+") + s : s;
    }

    /** GOBACK, STOP RUN or EXIT PROGRAM: the program ends, from however deep. */
    private static final class CocoonStop extends RuntimeException {
        CocoonStop() {
            super(null, null, false, false);
        }
    }

    /** GO TO: the paragraph control goes to next; the runner continues there. */
    private static final class CocoonGoTo extends RuntimeException {
        final int to;

        CocoonGoTo(int to) {
            super(null, null, false, false);
            this.to = to;
        }
    }

    private static final CocoonStop COCOON_STOP = new CocoonStop();

    private static void cocoonStop() {
        throw COCOON_STOP;
    }

    private static void cocoonGoTo(int to) {
        throw new CocoonGoTo(to);
    }

    public void run() {
        try {
            {
                String cocoonSt1 = f_IDX_FILE.open(cocoon.runtime.CobolFile.OUTPUT);   // OPEN OUTPUT IDX-FILE
                wsFs.store(cocoonSt1);
            }
            System.out.println("OPEN OUTPUT " + wsFs.value());
            idxKey.store(new BigDecimal("5"));
            idxName.store("FIVE");
            {
                String cocoonSt2 = f_IDX_FILE.write(r_IDX_REC.bytes, 9);   // WRITE IDX-REC
                wsFs.store(cocoonSt2);
                if (cocoonSt2.charAt(0) == '2') {
                } else if (cocoonSt2.charAt(0) == '0') {
                }
            }
            idxKey.store(new BigDecimal("1"));
            idxName.store("ONE");
            {
                String cocoonSt3 = f_IDX_FILE.write(r_IDX_REC.bytes, 9);   // WRITE IDX-REC
                wsFs.store(cocoonSt3);
                if (cocoonSt3.charAt(0) == '2') {
                } else if (cocoonSt3.charAt(0) == '0') {
                }
            }
            idxKey.store(new BigDecimal("3"));
            idxName.store("THREE");
            {
                String cocoonSt4 = f_IDX_FILE.write(r_IDX_REC.bytes, 9);   // WRITE IDX-REC
                wsFs.store(cocoonSt4);
                if (cocoonSt4.charAt(0) == '2') {
                } else if (cocoonSt4.charAt(0) == '0') {
                }
            }
            idxKey.store(new BigDecimal("3"));
            idxName.store("AGAIN");
            {
                String cocoonSt5 = f_IDX_FILE.write(r_IDX_REC.bytes, 9);   // WRITE IDX-REC
                wsFs.store(cocoonSt5);
                if (cocoonSt5.charAt(0) == '2') {
                    System.out.println("DUP " + wsFs.value());
                } else if (cocoonSt5.charAt(0) == '0') {
                    System.out.println("WROTE " + wsFs.value());
                }
            }
            {
                String cocoonSt6 = f_IDX_FILE.close();   // CLOSE IDX-FILE
                wsFs.store(cocoonSt6);
            }
            {
                String cocoonSt7 = f_IDX_FILE.open(cocoon.runtime.CobolFile.IO);   // OPEN I-O IDX-FILE
                wsFs.store(cocoonSt7);
            }
            idxKey.store(new BigDecimal("3"));
            {
                String cocoonSt8 = f_IDX_FILE.readKey(r_IDX_REC.bytes);   // READ IDX-FILE by key
                wsFs.store(cocoonSt8);
                if (cocoonSt8.charAt(0) == '2') {
                    System.out.println("NO 3 " + wsFs.value());
                } else if (cocoonSt8.charAt(0) == '0') {
                    System.out.println("GOT " + cocoonDisplay(idxKey.value(), 3, 0, false) + " " + idxName.value());
                }
            }
            idxName.store("TRES");
            {
                String cocoonSt9 = f_IDX_FILE.rewrite(r_IDX_REC.bytes, 9);   // REWRITE IDX-REC
                wsFs.store(cocoonSt9);
                if (cocoonSt9.charAt(0) == '2') {
                    System.out.println("REWRITE FAILED " + wsFs.value());
                } else if (cocoonSt9.charAt(0) == '0') {
                }
            }
            idxKey.store(new BigDecimal("1"));
            {
                String cocoonSt10 = f_IDX_FILE.delete(r_IDX_REC.bytes);   // DELETE IDX-FILE
                wsFs.store(cocoonSt10);
                if (cocoonSt10.charAt(0) == '2') {
                    System.out.println("DELETE FAILED " + wsFs.value());
                } else if (cocoonSt10.charAt(0) == '0') {
                }
            }
            idxKey.store(new BigDecimal("1"));
            {
                String cocoonSt11 = f_IDX_FILE.readKey(r_IDX_REC.bytes);   // READ IDX-FILE by key
                wsFs.store(cocoonSt11);
                if (cocoonSt11.charAt(0) == '2') {
                    System.out.println("NO 1 NOW " + wsFs.value());
                } else if (cocoonSt11.charAt(0) == '0') {
                }
            }
            idxKey.store(new BigDecimal("2"));
            {
                String cocoonSt12 = f_IDX_FILE.start(r_IDX_REC.bytes, ">=");   // START IDX-FILE
                wsFs.store(cocoonSt12);
                if (cocoonSt12.charAt(0) == '2') {
                    System.out.println("START FAILED " + wsFs.value());
                } else if (cocoonSt12.charAt(0) == '0') {
                }
            }
            for (int cocoonI1 = 0, cocoonN1 = 4; cocoonI1 < cocoonN1; cocoonI1++) {
                {
                    String cocoonSt13 = f_IDX_FILE.read(r_IDX_REC.bytes);   // READ IDX-FILE
                    wsFs.store(cocoonSt13);
                    if (cocoonSt13.charAt(0) == '1') {
                        System.out.println("END " + wsFs.value());
                    } else if (cocoonSt13.charAt(0) == '0') {
                        System.out.println("NEXT " + cocoonDisplay(idxKey.value(), 3, 0, false) + " " + idxName.value());
                    }
                }
            }
            idxKey.store(new BigDecimal("9"));
            {
                String cocoonSt14 = f_IDX_FILE.start(r_IDX_REC.bytes, ">");   // START IDX-FILE
                wsFs.store(cocoonSt14);
                if (cocoonSt14.charAt(0) == '2') {
                    System.out.println("NOTHING AFTER 9 " + wsFs.value());
                } else if (cocoonSt14.charAt(0) == '0') {
                }
            }
            {
                String cocoonSt15 = f_IDX_FILE.close();   // CLOSE IDX-FILE
                wsFs.store(cocoonSt15);
            }
            cocoonStop();   // STOP RUN
        } catch (CocoonStop s) {
            // GOBACK or STOP RUN: the program ends
        }
    }

    public static void main(String[] args) {
        Fidx p = new Fidx();
        try {
            p.run();
        } catch (CocoonFileError e) {
            // the run ends with status 1, as GnuCOBOL's does: by the exception leaving
            // main, not System.exit, which aborts the JVM on some Android builds
            p.cocoonCloseFiles();
            System.out.flush();
            throw e;
        }
        p.cocoonCloseFiles();
    }
}
