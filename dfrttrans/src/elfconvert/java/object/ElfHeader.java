package object;

import java.io.IOException;

public record ElfHeader(byte[] identification, int type, int machine, int version, int entry, int segmentsOffset,
                        int sectionsOffset, int flags, int headerSize, int segmentSize, int segmentCount,
                        int sectionSize, int sectionCount, int sectionNamesSection) {
    public static final int ET_REL = 1;
    public static final int EM_386 = 3;
    public static final int EM_XR17032 = 0xb5f0;
    public static final int EV_CURRENT = 1;
    public static final int ELFMAG0 = 0x7f;
    public static final int ELFMAG1 = 'E';
    public static final int ELFMAG2 = 'L';
    public static final int ELFMAG3 = 'F';
    public static final int ELFCLASS32 = 1;
    public static final int ELFDATA2LSB = 1;

    public ElfHeader {
        if (identification[0] != ELFMAG0 || identification[1] != ELFMAG1 || identification[2] != ELFMAG2
                || identification[3] != ELFMAG3) {
            throw new IllegalArgumentException("incorrect magic number");
        }

        if (identification[4] != ELFCLASS32 || identification[5] != ELFDATA2LSB || identification[6] != EV_CURRENT) {
            throw new IllegalArgumentException("incompatible object");
        }

        if (version != identification[6]) {
            throw new IllegalArgumentException("version mismatch");
        }
    }

    public ElfHeader(LittleEndian.Input input) throws IOException {
        this(input.readBytes(16), input.read16(), input.read16(), input.read32(), input.read32(), input.read32(),
                input.read32(), input.read32(), input.read16(), input.read16(), input.read16(), input.read16(),
                input.read16(), input.read16());
    }
}
