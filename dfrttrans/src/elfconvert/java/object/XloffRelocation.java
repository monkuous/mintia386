package object;

import java.io.IOException;

public record XloffRelocation(int offset, int symbol, int addend, int type, int section) {
    public static final int SIZE = 16;

    public void write(LittleEndian.Output output) throws IOException {
        output.write32(offset);
        output.write32(symbol);
        output.write32(addend);
        output.write16(type);
        output.write16(section);
    }
}
