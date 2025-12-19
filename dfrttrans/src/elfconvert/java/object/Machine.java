package object;

public interface Machine {
    int getXloffCode();

    int getElfRelocSize(int type);

    int translateElfRelocType(int type);

    static Machine getFromElfCode(int code) {
        return switch (code) {
            case ElfHeader.EM_386 -> new I386Machine();
            case ElfHeader.EM_XR17032 -> new Xr17032Machine();
            default -> throw new IllegalArgumentException("unknown machine code 0x%x".formatted(code));
        };
    }
}
