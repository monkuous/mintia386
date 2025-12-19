package object;

import java.io.IOException;

public record XloffSymbol(int nameOffset, int value, int section, int type, int flags) {
    public static final int GLOBAL = 1;
    public static final int LOCAL = 2;
    public static final int EXTERN = 3;
    public static final int SPECIAL = 4;
    public static final int SIZE = 12;

    public void write(LittleEndian.Output output) throws IOException {
        output.write32(nameOffset);
        output.write32(value);
        output.write16(section);
        output.write8(type);
        output.write8(flags);
    }
}
