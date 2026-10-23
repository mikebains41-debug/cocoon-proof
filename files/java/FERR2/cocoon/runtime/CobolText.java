package cocoon.runtime;

/**
 * A COBOL alphanumeric field: a view onto size bytes of a record.
 * A store pads with spaces or truncates on the right, as MOVE does.
 */
public final class CobolText {

    private final CobolRecord rec;
    private final int off;
    private final int size;

    public CobolText(CobolRecord rec, int off, int size) {
        this.rec = rec;
        this.off = off;
        this.size = size;
    }

    /** A field of its own, not part of any record. */
    public CobolText(int size) {
        this(new CobolRecord("", size), 0, size);
    }

    /** A table: n elements, each a view stride bytes after the last. */
    public static CobolText[] table(CobolRecord rec, int off, int stride,
                                    int n, int size) {
        CobolText[] t = new CobolText[n];
        for (int i = 0; i < n; i++) {
            t[i] = new CobolText(rec, off + i * stride, size);
        }
        return t;
    }

    /** A table of two dimensions, laid out as CobolDecimal.table2 lays one. */
    public static CobolText[][] table2(CobolRecord rec, int off, int stride1,
                                       int n1, int stride2, int n2, int size) {
        CobolText[][] t = new CobolText[n1][];
        for (int i = 0; i < n1; i++) {
            t[i] = table(rec, off + i * stride1, stride2, n2, size);
        }
        return t;
    }

    public String value() {
        char[] c = new char[size];
        for (int i = 0; i < size; i++) {
            c[i] = (char) (rec.bytes[off + i] & 0xff);
        }
        return new String(c);
    }

    public CobolText store(String s) {
        if (s == null) {
            s = "";
        }
        for (int i = 0; i < size; i++) {
            rec.bytes[off + i] = i < s.length() ? (byte) s.charAt(i) : (byte) ' ';
        }
        return this;
    }

    public CobolText store(CobolText t) {
        return store(t.value());
    }

    public String trimmed() {
        return value().trim();
    }

    public int size() {
        return size;
    }

    /** NUMERIC for text, a group or an edited picture: every character a digit. */
    public boolean isNumeric() {
        for (int i = 0; i < size; i++) {
            int b = rec.bytes[off + i] & 0xff;
            if (b < '0' || b > '9') {
                return false;
            }
        }
        return true;
    }

    /** ALPHABETIC: every character a letter or a space; -UPPER and -LOWER likewise. */
    public boolean isAlphabetic() {
        return letters(true, true);
    }

    public boolean isAlphabeticUpper() {
        return letters(true, false);
    }

    public boolean isAlphabeticLower() {
        return letters(false, true);
    }

    private boolean letters(boolean upper, boolean lower) {
        for (int i = 0; i < size; i++) {
            int b = rec.bytes[off + i] & 0xff;
            boolean ok = b == ' ' || (upper && b >= 'A' && b <= 'Z') || (lower && b >= 'a' && b <= 'z');
            if (!ok) {
                return false;
            }
        }
        return true;
    }

    public String toString() {
        return value();
    }

    /**
     * COBOL's alphanumeric comparison: the shorter operand is padded with
     * spaces before comparing. Ordering follows Java's character order,
     * not EBCDIC; equality, which is what pricing logic tests, is the
     * same in both.
     */
    public static int compareAlnum(String a, String b) {
        int n = Math.max(a.length(), b.length());
        StringBuilder x = new StringBuilder(a);
        StringBuilder y = new StringBuilder(b);
        while (x.length() < n) {
            x.append(' ');
        }
        while (y.length() < n) {
            y.append(' ');
        }
        return x.toString().compareTo(y.toString());
    }

    /**
     * A number written into a numeric-edited picture, as COBOL edits it.
     * pic is the picture with its repeat counts written out (Z(4) as ZZZZ).
     * The value is aligned on the decimal point, its fraction cut to the
     * picture's places and its high-order digits lost, without rounding.
     * Z and * suppress leading zeros, replacing them with spaces or
     * asterisks, until the first digit that is not zero, a 9, or the
     * decimal point; an insertion character (, B 0 /) in the suppressed
     * part is replaced the same way. A floating string ($$$, ---, +++)
     * suppresses too, and its symbol lands just left of the first digit
     * kept. A fixed + or - shows the sign, + as + and - as a space when the
     * value is not negative; CR and DB show only when it is. A value of
     * zero is never negative. With no 9 in the picture, zero is all spaces,
     * or for * all asterisks but the decimal point; BLANK WHEN ZERO makes
     * zero all spaces in any picture.
     */
    public static String edit(java.math.BigDecimal v, String pic, boolean blankWhenZero) {
        int n = pic.length();
        boolean crdb = n >= 2 && (pic.endsWith("CR") || pic.endsWith("DB"));
        int end = crdb ? n - 2 : n;
        int firstDigit = end;
        for (int i = 0; i < end; i++) {
            char c = pic.charAt(i);
            if (c == '9' || c == 'Z' || c == '*' || c == '.' || c == 'V') {
                firstDigit = i;
                break;
            }
        }
        char fl = 0;
        for (char s : new char[] {'$', '+', '-'}) {
            int k = 0;
            for (int i = 0; i < firstDigit; i++) {
                if (pic.charAt(i) == s) {
                    k++;
                }
            }
            if (k >= 2) {
                fl = s;
                break;
            }
        }
        int flFirst = -1, flLast = -1;
        if (fl != 0) {
            flFirst = pic.indexOf(fl);
            for (int i = 0; i < firstDigit; i++) {
                if (pic.charAt(i) == fl) {
                    flLast = i;
                }
            }
        }
        int leadSign = (end > 0 && (pic.charAt(0) == '+' || pic.charAt(0) == '-')
                && pic.charAt(0) != fl) ? 0 : -1;
        int trailSign = (end > 1 && (pic.charAt(end - 1) == '+' || pic.charAt(end - 1) == '-')
                && end - 1 > flLast && end - 1 != leadSign) ? end - 1 : -1;
        boolean[] digit = new boolean[end];
        int ints = 0, decs = 0;
        boolean afterPoint = false, any9 = false;
        for (int i = 0; i < end; i++) {
            char c = pic.charAt(i);
            boolean d = c == '9' || c == 'Z' || c == '*'
                    || (fl != 0 && c == fl && i > flFirst && i <= flLast);
            if (i == leadSign || i == trailSign) {
                d = false;
            }
            digit[i] = d;
            if (c == '9') {
                any9 = true;
            }
            if (c == '.' || c == 'V') {
                afterPoint = true;
            } else if (d) {
                if (afterPoint) {
                    decs++;
                } else {
                    ints++;
                }
            }
        }
        boolean neg = v.signum() < 0;
        java.math.BigDecimal a = v.abs().setScale(decs, java.math.RoundingMode.DOWN);
        String ds = a.unscaledValue().toString();
        int width = ints + decs;
        while (ds.length() < width) {
            ds = "0" + ds;
        }
        ds = ds.substring(ds.length() - width);
        boolean zero = true;
        for (int i = 0; i < ds.length(); i++) {
            if (ds.charAt(i) != '0') {
                zero = false;
                break;
            }
        }
        if (zero) {
            neg = false;
        }
        char fill = pic.indexOf('*') >= 0 ? '*' : ' ';
        int outLen = n - (pic.indexOf('V') >= 0 ? 1 : 0);
        StringBuilder out = new StringBuilder(outLen);
        if (zero && (blankWhenZero || !any9)) {
            for (int i = 0; i < n; i++) {
                char c = pic.charAt(i);
                if (c == 'V') {
                    continue;
                }
                out.append(!blankWhenZero && fill == '*' && c == '.' ? '.' : (blankWhenZero ? ' ' : fill));
            }
            return out.toString();
        }
        int di = 0;
        boolean sig = false;
        int flOut = -1, sigOut = -1;
        for (int i = 0; i < end; i++) {
            char c = pic.charAt(i);
            if (c == 'V') {
                sig = true;
                continue;
            }
            if (i == leadSign || i == trailSign) {
                out.append(c == '+' ? (neg ? '-' : '+') : (neg ? '-' : ' '));
            } else if (digit[i]) {
                char d = ds.charAt(di++);
                if (!sig && (c == '9' || d != '0')) {
                    sig = true;
                }
                if (sig && sigOut < 0) {
                    sigOut = out.length();
                }
                out.append(sig ? d : (c == '*' ? '*' : ' '));
            } else if (i == flFirst) {
                flOut = out.length();
                out.append(' ');
            } else if (c == '.') {
                sig = true;
                if (sigOut < 0) {
                    sigOut = out.length();
                }
                out.append('.');
            } else if (c == ',' || c == 'B' || c == '0' || c == '/') {
                out.append(sig ? (c == 'B' ? ' ' : c) : fill);
            } else if (c == '$') {
                out.append('$');
            } else {
                out.append(c);
            }
        }
        if (crdb) {
            out.append(neg ? pic.substring(end) : "  ");
        }
        if (fl != 0) {
            char sym = fl == '$' ? '$' : (fl == '+' ? (neg ? '-' : '+') : (neg ? '-' : ' '));
            int at = sigOut < 0 ? out.length() : sigOut;
            int k = at - 1;
            while (k > flOut && out.charAt(k) != ' ') {
                k--;
            }
            out.setCharAt(Math.max(k, flOut), sym);
        }
        return out.toString();
    }
}
