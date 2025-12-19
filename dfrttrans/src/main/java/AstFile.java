import java.util.List;

public record AstFile(List<AstSymbol> symbols, List<AstDefinition> definitions) {
}
