import java.io.BufferedReader;
import java.io.FileReader;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import cocoon.runtime.CobolRecord;

/** Feeds captured COBOL records to the generated program, call by call. */
public class CocoonEquiv {

    static byte[] unhex(String h) {
        byte[] b = new byte[h.length() / 2];
        for (int i = 0; i < b.length; i++) {
            b[i] = (byte) Integer.parseInt(h.substring(2 * i, 2 * i + 2), 16);
        }
        return b;
    }

    public static void main(String[] a) throws Exception {
        Object p = Class.forName(a[0]).getDeclaredConstructor().newInstance();
        Method record = p.getClass().getMethod("record", String.class);
        Method run = p.getClass().getMethod("run");
        BufferedReader r = new BufferedReader(new FileReader(a[1]));
        List<String[]> before = new ArrayList<>();
        String line;
        int call = 0;
        boolean inAfter = false;
        while ((line = r.readLine()) != null) {
            if (line.startsWith("COCOON B ")) {
                if (inAfter) {
                    before.clear();
                    inAfter = false;
                }
                String[] w = line.split(" ", 4);
                before.add(new String[]{w[2], w.length > 3 ? w[3].trim() : ""});
            } else if (line.startsWith("COCOON A ")) {
                // Java's bytes for each record COBOL shows after the call, in
                // COBOL's order: a record given once, before the first call,
                // is shown again only after the last, and only then compared.
                String shown = line.split(" ", 4)[2];
                if (inAfter) {
                    CobolRecord cr = (CobolRecord) record.invoke(p, shown);
                    System.out.println("COCOON A " + shown + " " + (cr == null ? "" : cr.hex()));
                    continue;
                }
                inAfter = true;
                call++;
                for (String[] b : before) {
                    CobolRecord cr = (CobolRecord) record.invoke(p, b[0]);
                    if (cr == null) {
                        System.out.println("COCOON X " + call + " no record named " + b[0]);
                        continue;
                    }
                    byte[] bytes = unhex(b[1]);
                    if (cr.bytes.length != bytes.length) {
                        System.out.println("COCOON X " + call + " size " + b[0]
                                           + " java " + cr.bytes.length + " cobol " + bytes.length);
                    }
                    cr.bytes = bytes;
                }
                try {
                    run.invoke(p);
                } catch (InvocationTargetException e) {
                    Throwable c = e.getCause();
                    StackTraceElement[] st = c.getStackTrace();
                    System.out.println("COCOON X " + call + " run " + c
                                       + (st.length > 0 ? " at " + st[0] : ""));
                }
                CobolRecord shownRec = (CobolRecord) record.invoke(p, shown);
                System.out.println("COCOON A " + shown + " " + (shownRec == null ? "" : shownRec.hex()));
            }
        }
    }
}
