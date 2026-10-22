import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.ArrayList;
import java.util.List;

/**
 * Feeds captured COBOL records to the generated program, call by call, as
 * CocoonEquiv does, with two more lines it understands:
 *
 *   COCOON S n   call n, whose COBOL stopped under GnuCOBOL's run-time
 *                checks: run it on its before-records and print only
 *                whether the Java threw, and where;
 *   COCOON R     start again from a fresh load: every class - the program,
 *                the programs it calls and the runtime - loaded anew, as a
 *                fresh run of the COBOL starts.
 *
 * Usage: java CocoonEquivR CLASS CAPTURE CLASSPATH
 * CLASSPATH (':'-separated) holds the generated classes and the runtime;
 * nothing of theirs is on this class's own class path.
 */
public class CocoonEquivR {

    static String cname;
    static URL[] urls;
    static Object p;
    static Method record, run;

    static byte[] unhex(String h) {
        byte[] b = new byte[h.length() / 2];
        for (int i = 0; i < b.length; i++) {
            b[i] = (byte) Integer.parseInt(h.substring(2 * i, 2 * i + 2), 16);
        }
        return b;
    }

    static void load() throws Exception {
        ClassLoader l = new URLClassLoader(urls, null);
        p = Class.forName(cname, true, l).getDeclaredConstructor().newInstance();
        record = p.getClass().getMethod("record", String.class);
        run = p.getClass().getMethod("run");
    }

    static void put(List<String[]> before, int call) throws Exception {
        for (String[] b : before) {
            Object cr = record.invoke(p, b[0]);
            if (cr == null) {
                System.out.println("COCOON X " + call + " no record named " + b[0]);
                continue;
            }
            Field f = cr.getClass().getField("bytes");
            byte[] bytes = unhex(b[1]);
            byte[] old = (byte[]) f.get(cr);
            if (old.length != bytes.length) {
                System.out.println("COCOON X " + call + " size " + b[0] + " java " + old.length + " cobol " + bytes.length);
            }
            f.set(cr, bytes);
        }
    }

    static void go(int call) throws Exception {
        try {
            run.invoke(p);
        } catch (InvocationTargetException e) {
            Throwable c = e.getCause();
            StackTraceElement[] st = c.getStackTrace();
            System.out.println("COCOON X " + call + " run " + c + (st.length > 0 ? " at " + st[0] : ""));
        }
    }

    static void show(String name) throws Exception {
        Object cr = record.invoke(p, name);
        String hex = cr == null ? "" : (String) cr.getClass().getMethod("hex").invoke(cr);
        System.out.println("COCOON A " + name + " " + hex);
    }

    public static void main(String[] a) throws Exception {
        cname = a[0];
        String[] cp = a[2].split(":");
        urls = new URL[cp.length];
        for (int i = 0; i < cp.length; i++) {
            urls[i] = new File(cp[i]).toURI().toURL();
        }
        load();
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
                String shown = line.split(" ", 4)[2];
                if (inAfter) {
                    show(shown);
                    continue;
                }
                inAfter = true;
                call++;
                put(before, call);
                go(call);
                show(shown);
            } else if (line.startsWith("COCOON S ")) {
                call++;
                put(before, call);
                go(call);
                System.out.println("COCOON S " + call);
                before.clear();
                inAfter = false;
            } else if (line.equals("COCOON R")) {
                load();
                before.clear();
                inAfter = false;
            }
        }
        System.out.flush();
    }
}
