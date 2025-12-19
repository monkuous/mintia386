import java.util.ArrayList;
import java.util.List;

public class ProtoFile extends Scope {
    public ProtoFile(String path) {
        super(null);
        var builtinLocation = new Location(path, 1, 1);
        addOrReplace(new ProtoDefinition.Constant(
                new Token(TokenType.IDENTIFIER, "WORD", builtinLocation),
                new ProtoOperation.Int(new Token(TokenType.INTEGER, Integer.toUnsignedString(Main.WORD_SIZE), builtinLocation), Main.WORD_SIZE))
        );
        addOrReplace(new ProtoDefinition.Constant(
                new Token(TokenType.IDENTIFIER, "PTR", builtinLocation),
                new ProtoOperation.Int(new Token(TokenType.INTEGER, Integer.toUnsignedString(Main.PTR_SIZE), builtinLocation), Main.PTR_SIZE))
        );
    }

    public AstFile convertToAst() {
        List<AstSymbol> symbols = new ArrayList<>();
        List<AstDefinition> definitions = new ArrayList<>();

        for (var def : this.definitions.values()) {
            def.resolve(this);

            if (def instanceof ProtoDefinition.Sym<?> sym) {
                symbols.add(sym.getSymbol(this));

                var astDef = sym.createDefinition(this);
                if (astDef != null) definitions.add(astDef);
            }
        }

        return new AstFile(symbols, definitions);
    }
}
