package object;

public class I386Machine implements Machine {
    private static final int ELF_RELOC_386_16 = 20;
    private static final int ELF_RELOC_386_PC16 = 21;
    private static final int ELF_RELOC_386_8 = 22;
    private static final int ELF_RELOC_386_PC8 = 23;

    @Override
    public int getXloffCode() {
        return XloffHeader.I386;
    }

    @Override
    public int getElfRelocSize(int type) {
        if (type == ELF_RELOC_386_16 || type == ELF_RELOC_386_PC16) return 2;
        if (type == ELF_RELOC_386_8 || type == ELF_RELOC_386_PC8) return 1;
        return 4;
    }

    @Override
    public int translateElfRelocType(int type) {
        return type;
    }
}
