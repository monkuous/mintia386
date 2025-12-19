package object;

import java.io.IOException;

public record ElfSection(int name, int type, int flags, int address, int offset, int size, int link, int info,
                         int addressAlignment, int entrySize) {
    public static final int SHN_UNDEF = 0;
    public static final int SHN_ABS = 0xfff1;
    public static final int SHT_PROGBITS = 1;
    public static final int SHT_SYMTAB = 2;
    public static final int SHT_RELA = 4;
    public static final int SHT_NOBITS = 8;
    public static final int SHT_REL = 9;
    public static final int SHF_WRITE = 1;
    public static final int SHF_ALLOC = 2;
    public static final int SHF_EXECINSTR = 4;

    public ElfSection(LittleEndian.Input input) throws IOException {
        this(input.read32(), input.read32(), input.read32(), input.read32(), input.read32(), input.read32(),
                input.read32(), input.read32(), input.read32(), input.read32());
    }
}
