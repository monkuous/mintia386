package object;

import java.util.Arrays;
import java.util.List;
import java.util.Objects;

public final class Section {
    private final String name;
    private final int address;
    private int size;
    private byte[] data;
    private final boolean writable;
    private final boolean executable;
    private final List<Relocation> relocations;
    private final int index;
    public final Symbol startSym, sizeSym, endSym;

    public Section(String name, int address, int size, byte[] data, boolean writable, boolean executable, List<Relocation> relocations, int index, ObjectFile object) {
        this.name = name;
        this.address = address;
        setData(size, data);
        this.writable = writable;
        this.executable = executable;
        this.relocations = relocations;
        this.index = index;
        startSym = new Symbol("_" + name, Symbol.SPECIALVALUE_START, this, Symbol.Type.SPECIAL, object.symbols().size());
        object.symbols().add(startSym);
        sizeSym = new Symbol("_" + name + "_size", Symbol.SPECIALVALUE_SIZE, this, Symbol.Type.SPECIAL, object.symbols().size());
        object.symbols().add(sizeSym);
        endSym = new Symbol("_" + name + "_end", Symbol.SPECIALVALUE_END, this, Symbol.Type.SPECIAL, object.symbols().size());
        object.symbols().add(endSym);
    }

    public void setData(int size, byte[] data) {
        if (data != null && data.length != size) {
            throw new IllegalArgumentException("data length does not match section size");
        }

        this.size = size;
        this.data = data;
    }

    public String name() {
        return name;
    }

    public int address() {
        return address;
    }

    public int size() {
        return size;
    }

    public byte[] data() {
        return data;
    }

    public boolean writable() {
        return writable;
    }

    public boolean executable() {
        return executable;
    }

    public List<Relocation> relocations() {
        return relocations;
    }

    public int index() {
        return index;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == this) return true;
        if (obj == null || obj.getClass() != this.getClass()) return false;
        var that = (Section) obj;
        return Objects.equals(this.name, that.name) &&
                this.address == that.address &&
                this.size == that.size &&
                Arrays.equals(this.data, that.data) &&
                this.writable == that.writable &&
                this.executable == that.executable &&
                Objects.equals(this.relocations, that.relocations) &&
                this.index == that.index;
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, address, size, Arrays.hashCode(data), writable, executable, relocations, index);
    }

    @Override
    public String toString() {
        return "Section[" +
                "name=" + name + ", " +
                "address=" + address + ", " +
                "size=" + size + ", " +
                "data=" + Arrays.toString(data) + ", " +
                "writable=" + writable + ", " +
                "executable=" + executable + ", " +
                "relocations=" + relocations + ", " +
                "index=" + index + ']';
    }

}
