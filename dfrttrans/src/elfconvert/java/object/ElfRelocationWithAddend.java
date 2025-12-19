package object;

import java.io.IOException;

public record ElfRelocationWithAddend(int offset, int info, int addend) implements ElfRelocationBase {
    public ElfRelocationWithAddend(LittleEndian.Input input) throws IOException {
        this(input.read32(), input.read32(), input.read32());
    }

    @Override
    public int addend(byte[] sectionData, int sectionOffset, Machine machine) {
        return addend;
    }
}
