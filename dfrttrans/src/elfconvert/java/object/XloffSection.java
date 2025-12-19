package object;

import java.io.IOException;

public record XloffSection(int nameOffset, int dataOffset, int dataSize, int virtualAddress, int relocTableOffset,
                           int relocCount, int flags) {
    public static final int BSS = 1;
    public static final int TEXT = 4;
    public static final int MAP = 8;
    public static final int READONLY = 16;
    public static final int SIZE = 28;

    public void write(LittleEndian.Output output) throws IOException {
        output.write32(nameOffset);
        output.write32(dataOffset);
        output.write32(dataSize);
        output.write32(virtualAddress);
        output.write32(relocTableOffset);
        output.write32(relocCount);
        output.write32(flags);
    }
}
