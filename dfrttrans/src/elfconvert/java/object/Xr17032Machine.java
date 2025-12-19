package object;

public class Xr17032Machine implements Machine {
    private static final int ELF_RELOC_XR17032_32 = 1;
    private static final int ELF_RELOC_XR17032_JUMP = 14;
    private static final int ELF_RELOC_XR17032_LO16 = 21;
    private static final int ELF_RELOC_XR17032_LO16_1 = 22;
    private static final int ELF_RELOC_XR17032_LO16_2 = 23;
    private static final int ELF_RELOC_XR17032_HI16 = 24;

    private static final int RELOC_XR17032_LONG = 1;
    private static final int RELOC_XR17032_ABSJ = 2;
    private static final int RELOC_XR17032_HI16 = 6;
    private static final int RELOC_XR17032_LO16 = 7;
    private static final int RELOC_XR17032_LO16_1 = 8;
    private static final int RELOC_XR17032_LO16_2 = 9;

    @Override
    public int getXloffCode() {
        return XloffHeader.XR17032;
    }

    @Override
    public int getElfRelocSize(int type) {
        return 4;
    }

    @Override
    public int translateElfRelocType(int type) {
        return switch (type) {
            case ELF_RELOC_XR17032_32 -> RELOC_XR17032_LONG;
            case ELF_RELOC_XR17032_JUMP -> RELOC_XR17032_ABSJ;
            case ELF_RELOC_XR17032_LO16 -> RELOC_XR17032_LO16;
            case ELF_RELOC_XR17032_LO16_1 -> RELOC_XR17032_LO16_1;
            case ELF_RELOC_XR17032_LO16_2 -> RELOC_XR17032_LO16_2;
            case ELF_RELOC_XR17032_HI16 -> RELOC_XR17032_HI16;
            default -> throw new IllegalArgumentException("unknown relocation type %d".formatted(type));
        };
    }
}
