import cocoon.runtime.CobolDecimal;
import cocoon.runtime.CobolText;
import cocoon.runtime.CobolRecord;
import java.math.BigDecimal;

/**
 * Translated from COBOL program FSEQ.
 *
 * The arithmetic is deliberately not Java arithmetic. A
 * COBOL field holds what its PICTURE allows, and a value
 * too large loses its high-order digits without raising
 * anything. Every place this translation reproduces that
 * is marked TRUNCATES, because a faithful migration has
 * to compute the same numbers as the program it
 * replaces, defects included.
 */
public class Fseq {

    // Records: the bytes, laid out as the mainframe lays them out.
    private final CobolRecord r_REC = new CobolRecord("REC", 8,
        "0000000000000000");
    private final CobolRecord r_WS_FS = new CobolRecord("WS-FS", 2,
        "2020");
    private final CobolRecord r_WS_I = new CobolRecord("WS-I", 3,
        "303030");
    private final java.util.Map<String, CobolRecord> cocoonRecordMap = new java.util.LinkedHashMap<>();
    {
        cocoonRecordMap.put("REC", r_REC);
        cocoonRecordMap.put("WS-FS", r_WS_FS);
        cocoonRecordMap.put("WS-I", r_WS_I);
    }
    /** A record by its COBOL name; a caller binds a LINKAGE record's bytes here. */
    public CobolRecord record(String name) { return cocoonRecordMap.get(name); }
    public java.util.Map<String, CobolRecord> records() { return cocoonRecordMap; }

    // REC-KEY PIC 9(3)
    private CobolDecimal recKey;
    // REC-NAME PIC X(5)
    private CobolText recName;
    // WS-FS PIC XX
    private CobolText wsFs;
    // WS-I PIC 9(3)
    private CobolDecimal wsI;
    // REC (group, 8 bytes)
    private CobolText rec;

    private void cocoonInit0() {
        recKey = new CobolDecimal(r_REC, 0, 3, 3, 0, false, 0, 0);
        recName = new CobolText(r_REC, 3, 5);
        wsFs = new CobolText(r_WS_FS, 0, 2);
        wsI = new CobolDecimal(r_WS_I, 0, 3, 3, 0, false, 0, 0);
        rec = new CobolText(r_REC, 0, 8);
    }

    public Fseq() {
        cocoonInit0();
    }

    // Files: each SELECT, as GnuCOBOL's file handler keeps it.
    private final cocoon.runtime.CobolFile f_REC_FILE = new cocoon.runtime.CobolFile("REC-FILE", "RECFILE", false, cocoon.runtime.CobolFile.SEQUENTIAL, 8);

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
        f_REC_FILE.closeAtEnd();
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
                String cocoonSt1 = f_REC_FILE.open(cocoon.runtime.CobolFile.OUTPUT);   // OPEN OUTPUT REC-FILE
                wsFs.store(cocoonSt1);
            }
            for (int cocoonI1 = 0, cocoonN1 = 3; cocoonI1 < cocoonN1; cocoonI1++) {
                wsI.store(wsI.value().add(new BigDecimal("1")));
                recKey.store(wsI.value());
                recName.store("NAME");
                {
                    String cocoonSt2 = f_REC_FILE.write(r_REC.bytes, 8);   // WRITE REC
                    wsFs.store(cocoonSt2);
                }
            }
            {
                String cocoonSt3 = f_REC_FILE.close();   // CLOSE REC-FILE
                wsFs.store(cocoonSt3);
            }
            {
                String cocoonSt4 = f_REC_FILE.open(cocoon.runtime.CobolFile.EXTEND);   // OPEN EXTEND REC-FILE
                wsFs.store(cocoonSt4);
            }
            recKey.store(new BigDecimal("9"));
            recName.store("LAST");
            {
                String cocoonSt5 = f_REC_FILE.write(r_REC.bytes, 8);   // WRITE REC
                wsFs.store(cocoonSt5);
            }
            {
                String cocoonSt6 = f_REC_FILE.close();   // CLOSE REC-FILE
                wsFs.store(cocoonSt6);
            }
            {
                String cocoonSt7 = f_REC_FILE.open(cocoon.runtime.CobolFile.IO);   // OPEN I-O REC-FILE
                wsFs.store(cocoonSt7);
            }
            {
                String cocoonSt8 = f_REC_FILE.read(r_REC.bytes);   // READ REC-FILE
                wsFs.store(cocoonSt8);
                if (cocoonSt8.charAt(0) == '1') {
                } else if (cocoonSt8.charAt(0) == '0') {
                }
            }
            {
                String cocoonSt9 = f_REC_FILE.read(r_REC.bytes);   // READ REC-FILE
                wsFs.store(cocoonSt9);
                if (cocoonSt9.charAt(0) == '1') {
                } else if (cocoonSt9.charAt(0) == '0') {
                }
            }
            recName.store("TWO");
            {
                String cocoonSt10 = f_REC_FILE.rewrite(r_REC.bytes, 8);   // REWRITE REC
                wsFs.store(cocoonSt10);
            }
            System.out.println("REWRITE " + wsFs.value());
            {
                String cocoonSt11 = f_REC_FILE.close();   // CLOSE REC-FILE
                wsFs.store(cocoonSt11);
            }
            {
                String cocoonSt12 = f_REC_FILE.open(cocoon.runtime.CobolFile.INPUT);   // OPEN INPUT REC-FILE
                wsFs.store(cocoonSt12);
            }
            for (int cocoonI2 = 0, cocoonN2 = 5; cocoonI2 < cocoonN2; cocoonI2++) {
                {
                    String cocoonSt13 = f_REC_FILE.read(r_REC.bytes);   // READ REC-FILE
                    wsFs.store(cocoonSt13);
                    if (cocoonSt13.charAt(0) == '1') {
                        System.out.println("END " + wsFs.value());
                    } else if (cocoonSt13.charAt(0) == '0') {
                        System.out.println(cocoonDisplay(recKey.value(), 3, 0, false) + " " + recName.value() + " " + wsFs.value());
                    }
                }
            }
            {
                String cocoonSt14 = f_REC_FILE.read(r_REC.bytes);   // READ REC-FILE
                wsFs.store(cocoonSt14);
                if (cocoonSt14.charAt(0) == '1') {
                } else if (cocoonSt14.charAt(0) == '0') {
                }
            }
            System.out.println("AFTER END " + wsFs.value());
            {
                String cocoonSt15 = f_REC_FILE.close();   // CLOSE REC-FILE
                wsFs.store(cocoonSt15);
            }
            {
                String cocoonSt16 = f_REC_FILE.close();   // CLOSE REC-FILE
                wsFs.store(cocoonSt16);
            }
            System.out.println("CLOSED TWICE " + wsFs.value());
            cocoonStop();   // STOP RUN
        } catch (CocoonStop s) {
            // GOBACK or STOP RUN: the program ends
        }
    }

    public static void main(String[] args) {
        Fseq p = new Fseq();
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
