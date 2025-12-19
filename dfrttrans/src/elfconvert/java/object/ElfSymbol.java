package object;

import java.io.IOException;

public record ElfSymbol(int name, int value, int size, int info, int other, int section) {
    public static final int STB_LOCAL = 0;
    public static final int STB_GLOBAL = 1;

    public ElfSymbol(LittleEndian.Input input) throws IOException {
        this(input.read32(), input.read32(), input.read32(), input.read8(), input.read8(), input.read16());
    }

    public int bind() {
        return info >> 4;
    }

    public int type() {
        return info & 0xf;
    }

    public int visibility() {
        return other & 0x3;
    }
}
