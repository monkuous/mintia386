package object;

public interface ElfRelocationBase {
    int offset();

    int info();

    int addend(byte[] sectionData, int sectionOffset, Machine machine);

    default int symbol() {
        return info() >> 8;
    }

    default int type() {
        return info() & 0xff;
    }
}
