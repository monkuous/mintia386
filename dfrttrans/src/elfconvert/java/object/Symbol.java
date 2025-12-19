package object;

public record Symbol(String name, int value, Section section, Type type, int index) {
    public static final int SPECIALVALUE_START = 1;
    public static final int SPECIALVALUE_SIZE = 2;
    public static final int SPECIALVALUE_END = 3;

    public enum Type {
        GLOBAL,
        LOCAL,
        EXTERN,
        SPECIAL,
    }
}
