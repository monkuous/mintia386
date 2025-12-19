package object;

import java.io.IOException;

public record ElfRelocation(int offset, int info) implements ElfRelocationBase {
    public ElfRelocation(LittleEndian.Input input) throws IOException {
        this(input.read32(), input.read32());
    }

    @Override
    public int addend(byte[] sectionData, int sectionOffset, Machine machine) {
        if (sectionData == null) return 0;
        int size = machine.getElfRelocSize(type());
        int b1 = sectionData[offset + sectionOffset] & 0xff;
        int b2 = size >= 2 ? (sectionData[offset + sectionOffset + 1] & 0xff) : ((b1 & 0x80) != 0 ? 0xff : 0x00);
        int b3 = size >= 3 ? (sectionData[offset + sectionOffset + 2] & 0xff) : ((b2 & 0x80) != 0 ? 0xff : 0x00);
        int b4 = size >= 4 ? (sectionData[offset + sectionOffset + 3] & 0xff) : ((b3 & 0x80) != 0 ? 0xff : 0x00);
        return b1 | (b2 << 8) | (b3 << 16) | (b4 << 24);
    }
}
