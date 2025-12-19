package object;

import java.io.IOException;

public record XloffHeader(int magic, int symbolTableOffset, int symbolCount, int stringTableOffset, int stringTableSize,
                          int targetArchitecture, int entrySymbol, int flags, int timestamp, int sectionTableOffset,
                          int sectionCount, int importTableOffset, int importCount, int headLength) {
    public static final int MAGIC = 0xaa584f46;
    public static final int XR17032 = 1;
    public static final int I386 = 0x36383369;
    public static final int SIZE = 56;

    public XloffHeader {
        if (magic != MAGIC) throw new IllegalArgumentException("incorrect magic number");
    }

    public void write(LittleEndian.Output output) throws IOException {
        output.write32(magic);
        output.write32(symbolTableOffset);
        output.write32(symbolCount);
        output.write32(stringTableOffset);
        output.write32(stringTableSize);
        output.write32(targetArchitecture);
        output.write32(entrySymbol);
        output.write32(flags);
        output.write32(timestamp);
        output.write32(sectionTableOffset);
        output.write32(sectionCount);
        output.write32(importTableOffset);
        output.write32(importCount);
        output.write32(headLength);
    }
}
