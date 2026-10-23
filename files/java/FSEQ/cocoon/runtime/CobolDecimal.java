package cocoon.runtime;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;

/**
 * A COBOL numeric field: a view onto a record's bytes, in the encoding
 * GnuCOBOL uses on this device, measured with FUNCTION HEX-OF.
 *
 *   DISPLAY  one character per digit, no decimal point. A negative number
 *            has 0x40 added to its last digit (-123 is 31 32 73), or to
 *            its first with SIGN LEADING; SIGN SEPARATE writes '+' or '-'.
 *   PACKED   two digits a byte, the sign in the last half-byte: C plus,
 *            D minus, F unsigned.
 *   BINARY   big-endian two's complement; NATIVE little-endian.
 *
 * A store goes through the picture: the fraction truncated to the
 * picture's decimal places, high-order digits lost, as COBOL does and
 * raises nothing. storeRounded rounds half away from zero first.
 */
public final class CobolDecimal {

    public static final int DISPLAY = 0, PACKED = 1, BINARY = 2, NATIVE = 3;
    public static final int SIGN_TRAILING = 0, SIGN_LEADING = 1,
            SIGN_LEADING_SEPARATE = 2, SIGN_TRAILING_SEPARATE = 3;

    private final CobolRecord rec;
    private final int off;
    private final int size;
    private final int intDigits;
    private final int decDigits;
    private final boolean signed;
    private final int usage;
    private final int sign;

    public CobolDecimal(CobolRecord rec, int off, int size, int intDigits,
                        int decDigits, boolean signed, int usage, int sign) {
        this.rec = rec;
        this.off = off;
        this.size = size;
        this.intDigits = intDigits;
        this.decDigits = decDigits;
        this.signed = signed;
        this.usage = usage;
        this.sign = sign;
    }

    /** A DISPLAY field of its own, not part of any record. */
    public CobolDecimal(int intDigits, int decDigits, boolean signed) {
        this(new CobolRecord("", intDigits + decDigits), 0,
             intDigits + decDigits, intDigits, decDigits, signed, DISPLAY,
             SIGN_TRAILING);
        store(BigDecimal.ZERO);
    }

    /** A table: n elements, each a view stride bytes after the last. */
    public static CobolDecimal[] table(CobolRecord rec, int off, int stride,
                                       int n, int size, int intDigits,
                                       int decDigits, boolean signed,
                                       int usage, int sign) {
        CobolDecimal[] t = new CobolDecimal[n];
        for (int i = 0; i < n; i++) {
            t[i] = new CobolDecimal(rec, off + i * stride, size, intDigits,
                                    decDigits, signed, usage, sign);
        }
        return t;
    }

    /**
     * A table of two dimensions: n1 rows, each stride1 bytes after the
     * last, of n2 elements, each stride2 bytes after the last. RATE (I J)
     * is t[I - 1][J - 1].
     */
    public static CobolDecimal[][] table2(CobolRecord rec, int off, int stride1,
                                          int n1, int stride2, int n2, int size,
                                          int intDigits, int decDigits,
                                          boolean signed, int usage, int sign) {
        CobolDecimal[][] t = new CobolDecimal[n1][];
        for (int i = 0; i < n1; i++) {
            t[i] = table(rec, off + i * stride1, stride2, n2, size, intDigits,
                         decDigits, signed, usage, sign);
        }
        return t;
    }

    // ---- reading --------------------------------------------------------

    public BigDecimal value() {
        switch (usage) {
            case PACKED:
                return readPacked();
            case BINARY:
                return readBinary(true);
            case NATIVE:
                return readBinary(false);
            default:
                return readDisplay();
        }
    }

    private BigDecimal scaled(BigInteger unscaled, boolean negative) {
        BigDecimal d = new BigDecimal(unscaled, decDigits);
        return negative ? d.negate() : d;
    }

    private BigDecimal readDisplay() {
        int digits = intDigits + decDigits;
        boolean separate = sign == SIGN_LEADING_SEPARATE || sign == SIGN_TRAILING_SEPARATE;
        int first = off + (sign == SIGN_LEADING_SEPARATE ? 1 : 0);
        boolean negative = false;
        if (separate) {
            int at = sign == SIGN_LEADING_SEPARATE ? off : off + size - 1;
            negative = rec.bytes[at] == '-';
        }
        BigInteger n = BigInteger.ZERO;
        for (int i = 0; i < digits; i++) {
            int b = rec.bytes[first + i] & 0xff;
            if (!separate && signed) {
                boolean signPos = sign == SIGN_LEADING ? i == 0 : i == digits - 1;
                if (signPos && (b & 0xf0) == 0x70) {
                    negative = true;
                }
            }
            n = n.multiply(BigInteger.TEN).add(BigInteger.valueOf(b & 0x0f));
        }
        return scaled(n, negative);
    }

    private BigDecimal readPacked() {
        BigInteger n = BigInteger.ZERO;
        for (int i = 0; i < size; i++) {
            int b = rec.bytes[off + i] & 0xff;
            n = n.multiply(BigInteger.TEN).add(BigInteger.valueOf(b >> 4));
            if (i < size - 1) {
                n = n.multiply(BigInteger.TEN).add(BigInteger.valueOf(b & 0x0f));
            }
        }
        int s = rec.bytes[off + size - 1] & 0x0f;
        return scaled(n, s == 0x0d);
    }

    private BigDecimal readBinary(boolean big) {
        byte[] b = new byte[size];
        for (int i = 0; i < size; i++) {
            b[i] = rec.bytes[off + (big ? i : size - 1 - i)];
        }
        BigInteger n = signed ? new BigInteger(b) : new BigInteger(1, b);
        return new BigDecimal(n, decDigits);
    }

    // ---- writing --------------------------------------------------------

    /** Store through the picture, truncating as COBOL does. */
    public CobolDecimal store(BigDecimal v) {
        BigDecimal d = v.setScale(decDigits, RoundingMode.DOWN);
        boolean negative = signed && d.signum() < 0;
        BigInteger unscaled = d.unscaledValue().abs();
        int digits = intDigits + decDigits;
        unscaled = unscaled.mod(BigInteger.TEN.pow(Math.max(digits, 1)));
        switch (usage) {
            case PACKED:
                writePacked(unscaled, negative);
                break;
            case BINARY:
                writeBinary(unscaled, negative, true);
                break;
            case NATIVE:
                writeBinary(unscaled, negative, false);
                break;
            default:
                writeDisplay(unscaled, negative);
        }
        return this;
    }

    public CobolDecimal store(long v) {
        return store(BigDecimal.valueOf(v));
    }

    public CobolDecimal store(String v) {
        return store(new BigDecimal(v.trim().isEmpty() ? "0" : v.trim()));
    }

    /**
     * Store rounding to the picture's decimal places, as COMPUTE ...
     * ROUNDED does: half away from zero, then the integer part truncated
     * like any other store.
     */
    public CobolDecimal storeRounded(BigDecimal v) {
        return store(v.setScale(decDigits, RoundingMode.HALF_UP));
    }

    /**
     * The NUMERIC class test, as GnuCOBOL makes it (libcob cob_is_numeric,
     * cob_check_numdisp). DISPLAY: every position a digit, but a signed
     * field's sign position may also hold the negative overpunch 'p' to
     * 'y' - or, with SIGN SEPARATE, must hold '+' or '-'. PACKED: every
     * half-byte a digit but the last, which must be C or D when the field
     * is signed and F when it is not. BINARY: always numeric.
     */
    public boolean isNumeric() {
        if (usage == BINARY || usage == NATIVE) {
            return true;
        }
        if (usage == PACKED) {
            int last = rec.bytes[off + size - 1] & 0xff;
            int s = last & 0x0f;
            if (signed ? (s != 0x0c && s != 0x0d) : s != 0x0f) {
                return false;
            }
            if ((last & 0xf0) > 0x90) {
                return false;
            }
            for (int i = 0; i < size - 1; i++) {
                int b = rec.bytes[off + i] & 0xff;
                if ((b & 0x0f) > 0x09 || (b & 0xf0) > 0x90) {
                    return false;
                }
            }
            return true;
        }
        int from = off, to = off + size;
        if (signed) {
            boolean leading = sign == SIGN_LEADING || sign == SIGN_LEADING_SEPARATE;
            int c = leading ? rec.bytes[from++] & 0xff : rec.bytes[--to] & 0xff;
            if (sign == SIGN_LEADING_SEPARATE || sign == SIGN_TRAILING_SEPARATE) {
                if (c != '+' && c != '-') {
                    return false;
                }
            } else if ((c < '0' || c > '9') && (c < 'p' || c > 'y')) {
                return false;
            }
        }
        for (int i = from; i < to; i++) {
            int b = rec.bytes[i] & 0xff;
            if (b < '0' || b > '9') {
                return false;
            }
        }
        return true;
    }

    private void writeDisplay(BigInteger unscaled, boolean negative) {
        int digits = intDigits + decDigits;
        String s = unscaled.toString();
        while (s.length() < digits) {
            s = "0" + s;
        }
        boolean separate = sign == SIGN_LEADING_SEPARATE || sign == SIGN_TRAILING_SEPARATE;
        int first = off + (sign == SIGN_LEADING_SEPARATE ? 1 : 0);
        for (int i = 0; i < digits; i++) {
            rec.bytes[first + i] = (byte) s.charAt(i);
        }
        if (separate) {
            int at = sign == SIGN_LEADING_SEPARATE ? off : off + size - 1;
            rec.bytes[at] = (byte) (negative ? '-' : '+');
        } else if (negative && digits > 0) {
            int at = sign == SIGN_LEADING ? first : first + digits - 1;
            rec.bytes[at] = (byte) (rec.bytes[at] + 0x40);
        }
    }

    private void writePacked(BigInteger unscaled, boolean negative) {
        String s = unscaled.toString();
        int nibbles = size * 2 - 1;
        while (s.length() < nibbles) {
            s = "0" + s;
        }
        int signNibble = negative ? 0x0d : (signed ? 0x0c : 0x0f);
        for (int i = 0; i < size; i++) {
            int hi = s.charAt(2 * i) - '0';
            int lo = i < size - 1 ? s.charAt(2 * i + 1) - '0' : signNibble;
            rec.bytes[off + i] = (byte) ((hi << 4) | lo);
        }
    }

    private void writeBinary(BigInteger unscaled, boolean negative, boolean big) {
        BigInteger n = negative ? unscaled.negate() : unscaled;
        byte[] b = n.toByteArray();
        for (int i = 0; i < size; i++) {
            int from = b.length - size + i;
            byte v = from >= 0 ? b[from] : (byte) (n.signum() < 0 ? 0xff : 0);
            rec.bytes[off + (big ? i : size - 1 - i)] = v;
        }
    }

    // ---- as text --------------------------------------------------------

    /**
     * The digits as the picture holds them: unsigned, zero-filled to the
     * picture's width, no decimal point. PIC 99 holding 6 is "06".
     */
    public String display() {
        BigInteger u = value().abs().movePointRight(decDigits).toBigInteger();
        String s = u.toString();
        while (s.length() < intDigits + decDigits) {
            s = "0" + s;
        }
        return s;
    }

    public String toString() {
        return value().toPlainString();
    }

    public boolean wouldTruncate(BigDecimal v) {
        return v.abs().setScale(decDigits, RoundingMode.DOWN)
                .compareTo(BigDecimal.TEN.pow(intDigits)) >= 0;
    }

    /**
     * COBOL's ** : exact for a whole-number exponent, floating point for
     * any other, which is how both GnuCOBOL and the IBM compiler compute
     * it.
     */
    public static BigDecimal pow(BigDecimal base, BigDecimal exp) {
        BigDecimal e = exp.stripTrailingZeros();
        if (e.scale() <= 0 && e.signum() >= 0
                && e.compareTo(BigDecimal.valueOf(999)) <= 0) {
            return base.pow(e.intValueExact());
        }
        return BigDecimal.valueOf(Math.pow(base.doubleValue(), exp.doubleValue()));
    }

    /**
     * FUNCTION INTEGER-OF-DATE: the days since 31 December 1600 of a
     * YYYYMMDD date in the Gregorian calendar, 1 January 1601 being day
     * 1. A value that is not such a date - year outside 1601 to 9999,
     * month or day out of range - gives 0.
     */
    public static BigDecimal integerOfDate(BigDecimal yyyymmdd) {
        long v = yyyymmdd.setScale(0, RoundingMode.DOWN).longValue();
        int y = (int) (v / 10000);
        int m = (int) (v / 100 % 100);
        int d = (int) (v % 100);
        if (v < 0 || y < 1601 || y > 9999 || m < 1 || m > 12 || d < 1
                || d > java.time.YearMonth.of(y, m).lengthOfMonth()) {
            return BigDecimal.ZERO;
        }
        return BigDecimal.valueOf(java.time.LocalDate.of(y, m, d).toEpochDay()
                - java.time.LocalDate.of(1600, 12, 31).toEpochDay());
    }

    /**
     * FUNCTION DATE-OF-INTEGER: the YYYYMMDD date of a day number, day 1
     * being 1 January 1601. A number outside 1 to 3067671 gives 0.
     */
    public static BigDecimal dateOfInteger(BigDecimal days) {
        long n = days.setScale(0, RoundingMode.DOWN).longValue();
        if (n < 1 || n > 3067671) {
            return BigDecimal.ZERO;
        }
        java.time.LocalDate d = java.time.LocalDate.of(1600, 12, 31).plusDays(n);
        return BigDecimal.valueOf(d.getYear() * 10000L + d.getMonthValue() * 100L
                + d.getDayOfMonth());
    }

    /**
     * COBOL's division, as GnuCOBOL computes it (libcob numeric.c,
     * cob_decimal_div): the quotient keeps 38 decimal places more than the
     * dividend's excess scale over the divisor's, and is truncated toward
     * zero; a zero dividend gives zero. The fixed six places this replaces
     * lost digits: 1 / 7 * 7000000 came out 999999.00 where COBOL has
     * 999999.99.
     */
    public static BigDecimal divide(BigDecimal a, BigDecimal b) {
        if (b.signum() == 0) {
            throw ZERO_DIVIDE;
        }
        if (a.signum() == 0) {
            return BigDecimal.ZERO;
        }
        return a.divide(b, 38 + Math.max(0, a.scale() - b.scale()), RoundingMode.DOWN);
    }

    /**
     * A zero divisor, 0 / 0 included. GnuCOBOL marks the quotient as not a
     * number (cob_decimal_div), stores it in no receiver
     * (cob_decimal_get_field) and goes on; every statement holding a
     * division catches this and leaves its receivers as they were.
     */
    public static final class ZeroDivide extends RuntimeException {
        ZeroDivide() {
            super(null, null, false, false);
        }
    }

    private static final ZeroDivide ZERO_DIVIDE = new ZeroDivide();
}
