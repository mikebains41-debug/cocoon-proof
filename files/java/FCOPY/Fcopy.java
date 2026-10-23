import cocoon.runtime.CobolDecimal;
import cocoon.runtime.CobolText;
import cocoon.runtime.CobolRecord;
import java.math.BigDecimal;

/**
 * Translated from COBOL program FCOPY.
 *
 * The arithmetic is deliberately not Java arithmetic. A
 * COBOL field holds what its PICTURE allows, and a value
 * too large loses its high-order digits without raising
 * anything. Every place this translation reproduces that
 * is marked TRUNCATES, because a faithful migration has
 * to compute the same numbers as the program it
 * replaces, defects included.
 */
public class Fcopy {

    // Records: the bytes, laid out as the mainframe lays them out.
    private final CobolRecord r_IN_REC = new CobolRecord("IN-REC", 9,
        "000000000000000000");
    private final CobolRecord r_IN_ALT = r_IN_REC;   // REDEFINES IN-REC
    private final CobolRecord r_OUT_REC = new CobolRecord("OUT-REC", 12,
        "000000000000000000000000");
    private final CobolRecord r_WS_IN_FS = new CobolRecord("WS-IN-FS", 2,
        "2020");
    private final CobolRecord r_WS_EOF = new CobolRecord("WS-EOF", 1,
        "4e");
    private final CobolRecord r_WS_COUNT = new CobolRecord("WS-COUNT", 4,
        "30303030");
    private final CobolRecord r_WS_COPY = new CobolRecord("WS-COPY", 9,
        "202020202020202020");
    private final java.util.Map<String, CobolRecord> cocoonRecordMap = new java.util.LinkedHashMap<>();
    {
        cocoonRecordMap.put("IN-REC", r_IN_REC);
        cocoonRecordMap.put("IN-ALT", r_IN_ALT);
        cocoonRecordMap.put("OUT-REC", r_OUT_REC);
        cocoonRecordMap.put("WS-IN-FS", r_WS_IN_FS);
        cocoonRecordMap.put("WS-EOF", r_WS_EOF);
        cocoonRecordMap.put("WS-COUNT", r_WS_COUNT);
        cocoonRecordMap.put("WS-COPY", r_WS_COPY);
    }
    /** A record by its COBOL name; a caller binds a LINKAGE record's bytes here. */
    public CobolRecord record(String name) { return cocoonRecordMap.get(name); }
    public java.util.Map<String, CobolRecord> records() { return cocoonRecordMap; }

    // IN-ID PIC X(4)
    private CobolText inId;
    // IN-AMT PIC 9(5)
    private CobolDecimal inAmt;
    // IN-ALT PIC X(9)
    private CobolText inAlt;
    // OUT-ID PIC X(4)
    private CobolText outId;
    // FILLER PIC X
    private CobolText filler;
    // OUT-AMT PIC 9(7)
    private CobolDecimal outAmt;
    // WS-IN-FS PIC XX
    private CobolText wsInFs;
    // WS-EOF PIC X
    private CobolText wsEof;
    // WS-COUNT PIC 9(4)
    private CobolDecimal wsCount;
    // WS-COPY PIC X(9)
    private CobolText wsCopy;
    // IN-REC (group, 9 bytes)
    private CobolText inRec;
    // OUT-REC (group, 12 bytes)
    private CobolText outRec;

    private void cocoonInit0() {
        inId = new CobolText(r_IN_REC, 0, 4);
        inAmt = new CobolDecimal(r_IN_REC, 4, 5, 5, 0, false, 0, 0);
        inAlt = new CobolText(r_IN_ALT, 0, 9);
        outId = new CobolText(r_OUT_REC, 0, 4);
        filler = new CobolText(1);
        outAmt = new CobolDecimal(r_OUT_REC, 5, 7, 7, 0, false, 0, 0);
        wsInFs = new CobolText(r_WS_IN_FS, 0, 2);
        wsEof = new CobolText(r_WS_EOF, 0, 1);
        wsCount = new CobolDecimal(r_WS_COUNT, 0, 4, 4, 0, false, 0, 0);
        wsCopy = new CobolText(r_WS_COPY, 0, 9);
        inRec = new CobolText(r_IN_REC, 0, 9);
        outRec = new CobolText(r_OUT_REC, 0, 12);
    }

    public Fcopy() {
        cocoonInit0();
    }

    // Files: each SELECT, as GnuCOBOL's file handler keeps it.
    private final cocoon.runtime.CobolFile f_IN_FILE = new cocoon.runtime.CobolFile("IN-FILE", "INFILE", false, cocoon.runtime.CobolFile.LINE_SEQUENTIAL, 9);
    private final cocoon.runtime.CobolFile f_OUT_FILE = new cocoon.runtime.CobolFile("OUT-FILE", "OUTFILE", false, cocoon.runtime.CobolFile.LINE_SEQUENTIAL, 12);

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
        f_IN_FILE.closeAtEnd();
        f_OUT_FILE.closeAtEnd();
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
                String cocoonSt1 = f_IN_FILE.open(cocoon.runtime.CobolFile.INPUT);   // OPEN INPUT IN-FILE
                wsInFs.store(cocoonSt1);
            }
            {
                String cocoonSt2 = f_OUT_FILE.open(cocoon.runtime.CobolFile.OUTPUT);   // OPEN OUTPUT OUT-FILE
                if (cocoonSt2.charAt(0) != '0') cocoonIoFail(f_OUT_FILE, cocoonSt2);
            }
            while (!(wsEof.value().compareTo("Y") == 0)) {
                {
                    String cocoonSt3 = f_IN_FILE.read(r_IN_REC.bytes);   // READ IN-FILE
                    wsInFs.store(cocoonSt3);
                    if (cocoonSt3.charAt(0) == '1') {
                        wsEof.store("Y");
                    } else if (cocoonSt3.charAt(0) == '0') {
                        wsCopy.store(inRec.value());
                        wsCount.store(wsCount.value().add(new BigDecimal("1")));
                        outId.store(inId.value());
                        outAmt.store(inAmt.value());
                        {
                            String cocoonSt4 = f_OUT_FILE.write(r_OUT_REC.bytes, 12);   // WRITE OUT-REC
                            if (cocoonSt4.charAt(0) != '0') cocoonIoFail(f_OUT_FILE, cocoonSt4);
                        }
                    }
                }
            }
            {
                String cocoonSt5 = f_IN_FILE.close();   // CLOSE IN-FILE
                wsInFs.store(cocoonSt5);
            }
            {
                String cocoonSt5 = f_OUT_FILE.close();   // CLOSE OUT-FILE
                if (cocoonSt5.charAt(0) != '0') cocoonIoFail(f_OUT_FILE, cocoonSt5);
            }
            System.out.println(cocoonDisplay(wsCount.value(), 4, 0, false));
            System.out.println(wsInFs.value());
            System.out.println(wsCopy.value());
            cocoonStop();   // STOP RUN
        } catch (CocoonStop s) {
            // GOBACK or STOP RUN: the program ends
        }
    }

    public static void main(String[] args) {
        Fcopy p = new Fcopy();
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
