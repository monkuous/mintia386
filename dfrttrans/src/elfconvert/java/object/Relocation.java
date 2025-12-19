package object;

public record Relocation(int offset, Symbol symbol, int addend, int type) {
}
