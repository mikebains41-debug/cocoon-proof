package cocoon.runtime;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

/**
 * CALL. One instance of each program called, for the whole run: made on the
 * first call and kept, so its WORKING-STORAGE stands as the last call left
 * it - as a COBOL run unit keeps a called program in its last-used state.
 * Each record is passed BY REFERENCE: the called program's LINKAGE record is
 * given the caller's bytes - the very array - so its stores land in the
 * caller's record, and two names for one record stay one record.
 */
public final class CobolCall {

    private static final Map<String, Object> RUN_UNIT = new HashMap<>();
    private static final Map<String, Integer> DECLARED = new HashMap<>();

    private CobolCall() {
    }

    /** CALL program USING records: the program's class, its USING names in order, and the caller's records. */
    public static void call(String cls, String[] using, CobolRecord... args) {
        if (args.length > using.length) {
            throw new IllegalStateException("CALL " + cls + ": " + args.length + " records passed, "
                                            + using.length + " in its USING");
        }
        try {
            Object p = RUN_UNIT.get(cls);
            if (p == null) {
                p = Class.forName(cls).getDeclaredConstructor().newInstance();
                RUN_UNIT.put(cls, p);
            }
            Method record = p.getClass().getMethod("record", String.class);
            for (int i = 0; i < args.length; i++) {
                CobolRecord r = (CobolRecord) record.invoke(p, using[i]);
                if (r == null) {
                    throw new IllegalStateException("CALL " + cls + ": it has no record " + using[i]);
                }
                String key = cls + "/" + using[i];
                Integer size = DECLARED.get(key);
                if (size == null) {
                    size = r.bytes.length;
                    DECLARED.put(key, size);
                }
                if (args[i].bytes.length < size) {
                    throw new IllegalStateException("CALL " + cls + ": " + using[i] + " is " + size
                                                    + " bytes there, " + args[i].bytes.length + " passed");
                }
                r.bytes = args[i].bytes;
            }
            // Records the caller did not pass: not there - touching one fails,
            // as it does in COBOL.
            for (int i = args.length; i < using.length; i++) {
                CobolRecord r = (CobolRecord) record.invoke(p, using[i]);
                if (r != null) {
                    String key = cls + "/" + using[i];
                    if (!DECLARED.containsKey(key)) {
                        DECLARED.put(key, r.bytes.length);
                    }
                    r.bytes = null;
                }
            }
            p.getClass().getMethod("run").invoke(p);
        } catch (InvocationTargetException e) {
            Throwable c = e.getCause();
            if (c instanceof RuntimeException) {
                throw (RuntimeException) c;
            }
            if (c instanceof Error) {
                throw (Error) c;
            }
            throw new RuntimeException(c);
        } catch (ReflectiveOperationException e) {
            throw new RuntimeException("CALL " + cls + ": " + e, e);
        }
    }
}
