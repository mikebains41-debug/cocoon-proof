package cocoon.runtime;

/**
 * A record: a block of bytes, as the mainframe lays it out. Every field
 * is a view onto part of some record's bytes, several names may view
 * the same bytes (REDEFINES), and a table is one entry laid down again
 * and again (OCCURS). A caller passes a linkage record by handing this
 * object its bytes; the program's stores land in them.
 */
public final class CobolRecord {

    public final String name;
    public byte[] bytes;

    /** A record starting as the given bytes, written as hex chunks. */
    public CobolRecord(String name, int size, String... hex) {
        this.name = name;
        this.bytes = new byte[size];
        int at = 0;
        for (String chunk : hex) {
            for (int i = 0; i + 1 < chunk.length() && at < size; i += 2) {
                bytes[at++] = (byte) Integer.parseInt(chunk.substring(i, i + 2), 16);
            }
        }
        for (; at < size; at++) {
            bytes[at] = ' ';
        }
    }

    /** A record whose bytes a caller supplies; spaces until then. */
    public CobolRecord(String name, int size) {
        this(name, size, new String[0]);
    }

    public int size() {
        return bytes.length;
    }

    public String hex() {
        StringBuilder sb = new StringBuilder(bytes.length * 2);
        for (byte b : bytes) {
            sb.append(String.format("%02x", b & 0xff));
        }
        return sb.toString();
    }
}
