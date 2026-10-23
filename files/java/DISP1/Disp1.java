import cocoon.runtime.CobolDecimal;
import cocoon.runtime.CobolText;
import cocoon.runtime.CobolRecord;
import java.math.BigDecimal;

/**
 * Translated from COBOL program DISP1.
 *
 * The arithmetic is deliberately not Java arithmetic. A
 * COBOL field holds what its PICTURE allows, and a value
 * too large loses its high-order digits without raising
 * anything. Every place this translation reproduces that
 * is marked TRUNCATES, because a faithful migration has
 * to compute the same numbers as the program it
 * replaces, defects included.
 */
public class Disp1 {

    // Records: the bytes, laid out as the mainframe lays them out.
    private final CobolRecord r_A = new CobolRecord("A", 4,
        "30303033");
    private final CobolRecord r_B = new CobolRecord("B", 4,
        "30303073");
    private final CobolRecord r_C = new CobolRecord("C", 5,
        "3030313530");
    private final CobolRecord r_D = new CobolRecord("D", 5,
        "3031323235");
    private final CobolRecord r_E = new CobolRecord("E", 2,
        "002a");
    private final CobolRecord r_F = new CobolRecord("F", 4,
        "0001234d");
    private final CobolRecord r_G = new CobolRecord("G", 4,
        "30303030");
    private final CobolRecord r_H = new CobolRecord("H", 6,
        "414220202020");
    private final java.util.Map<String, CobolRecord> cocoonRecordMap = new java.util.LinkedHashMap<>();
    {
        cocoonRecordMap.put("A", r_A);
        cocoonRecordMap.put("B", r_B);
        cocoonRecordMap.put("C", r_C);
        cocoonRecordMap.put("D", r_D);
        cocoonRecordMap.put("E", r_E);
        cocoonRecordMap.put("F", r_F);
        cocoonRecordMap.put("G", r_G);
        cocoonRecordMap.put("H", r_H);
    }
    /** A record by its COBOL name; a caller binds a LINKAGE record's bytes here. */
    public CobolRecord record(String name) { return cocoonRecordMap.get(name); }
    public java.util.Map<String, CobolRecord> records() { return cocoonRecordMap; }

    // A PIC 9(4)
    private CobolDecimal a;
    // B PIC S9(4)
    private CobolDecimal b;
    // C PIC S9(3)V99
    private CobolDecimal c;
    // D PIC 9(3)V99
    private CobolDecimal d;
    // E PIC S9(4)
    private CobolDecimal e;
    // F PIC S9(5)V9
    private CobolDecimal f;
    // G PIC S9(4)
    private CobolDecimal g;
    // H PIC X(6)
    private CobolText h;

    private void cocoonInit0() {
        a = new CobolDecimal(r_A, 0, 4, 4, 0, false, 0, 0);
        b = new CobolDecimal(r_B, 0, 4, 4, 0, true, 0, 0);
        c = new CobolDecimal(r_C, 0, 5, 3, 2, true, 0, 0);
        d = new CobolDecimal(r_D, 0, 5, 3, 2, false, 0, 0);
        e = new CobolDecimal(r_E, 0, 2, 4, 0, true, 2, 0);
        f = new CobolDecimal(r_F, 0, 4, 5, 1, true, 1, 0);
        g = new CobolDecimal(r_G, 0, 4, 4, 0, true, 0, 0);
        h = new CobolText(r_H, 0, 6);
    }

    public Disp1() {
        cocoonInit0();
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
            System.out.println(cocoonDisplay(a.value(), 4, 0, false));
            System.out.println(cocoonDisplay(b.value(), 4, 0, true));
            System.out.println(cocoonDisplay(c.value(), 3, 2, true));
            System.out.println(cocoonDisplay(d.value(), 3, 2, false));
            System.out.println(cocoonDisplay(e.value(), 4, 0, true));
            System.out.println(cocoonDisplay(f.value(), 5, 1, true));
            System.out.println(cocoonDisplay(g.value(), 4, 0, true));
            System.out.println("H=" + h.value() + "|" + cocoonDisplay(a.value(), 4, 0, false) + " " + "X");
            System.out.print("NO ");
            System.out.println("NEWLINE");
            cocoonStop();   // STOP RUN
        } catch (CocoonStop s) {
            // GOBACK or STOP RUN: the program ends
        }
    }

    public static void main(String[] args) {
        new Disp1().run();
    }
}
