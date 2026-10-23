import cocoon.runtime.CobolDecimal;
import cocoon.runtime.CobolText;
import cocoon.runtime.CobolRecord;
import java.math.BigDecimal;

/**
 * Translated from COBOL program FERR1.
 *
 * The arithmetic is deliberately not Java arithmetic. A
 * COBOL field holds what its PICTURE allows, and a value
 * too large loses its high-order digits without raising
 * anything. Every place this translation reproduces that
 * is marked TRUNCATES, because a faithful migration has
 * to compute the same numbers as the program it
 * replaces, defects included.
 */
public class Ferr1 {

    // Records: the bytes, laid out as the mainframe lays them out.
    private final CobolRecord r_IN_REC = new CobolRecord("IN-REC", 10,
        "00000000000000000000");
    private final java.util.Map<String, CobolRecord> cocoonRecordMap = new java.util.LinkedHashMap<>();
    {
        cocoonRecordMap.put("IN-REC", r_IN_REC);
    }
    /** A record by its COBOL name; a caller binds a LINKAGE record's bytes here. */
    public CobolRecord record(String name) { return cocoonRecordMap.get(name); }
    public java.util.Map<String, CobolRecord> records() { return cocoonRecordMap; }

    // IN-REC PIC X(10)
    private CobolText inRec;

    private void cocoonInit0() {
        inRec = new CobolText(r_IN_REC, 0, 10);
    }

    public Ferr1() {
        cocoonInit0();
    }

    // Files: each SELECT, as GnuCOBOL's file handler keeps it.
    private final cocoon.runtime.CobolFile f_IN_FILE = new cocoon.runtime.CobolFile("IN-FILE", "NOSUCH", false, cocoon.runtime.CobolFile.LINE_SEQUENTIAL, 10);

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
            System.out.println("BEFORE");
            {
                String cocoonSt1 = f_IN_FILE.open(cocoon.runtime.CobolFile.INPUT);   // OPEN INPUT IN-FILE
                if (cocoonSt1.charAt(0) != '0') cocoonIoFail(f_IN_FILE, cocoonSt1);
            }
            System.out.println("AFTER");
            cocoonStop();   // STOP RUN
        } catch (CocoonStop s) {
            // GOBACK or STOP RUN: the program ends
        }
    }

    public static void main(String[] args) {
        Ferr1 p = new Ferr1();
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
