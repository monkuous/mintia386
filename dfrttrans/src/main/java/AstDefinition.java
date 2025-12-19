import java.io.PrintStream;
import java.util.List;

public interface AstDefinition {
    AstSymbol.Location symbol();

    String section();

    void print(PrintStream stream);

    default String getVisibilityPrefix() {
        return symbol().externallyVisible() ? "" : "static ";
    }

    record Function(AstSymbol.Location.Function symbol, String section, List<AstSymbol.Location> arguments,
                    List<AstSymbol.Location> returns, AstStatement.Block body) implements AstDefinition {
        @Override
        public void print(PrintStream stream) {
            stream.printf("__attribute__((noinline)) %s%s %s(", getVisibilityPrefix(), symbol.type().getReturnType(), symbol.name());
            boolean haveArg = false;

            for (var arg : arguments) {
                if (haveArg) stream.print(", ");
                stream.printf("unsigned long %s", arg.name());
                haveArg = true;
            }

            stream.println(") {");

            for (var ret : returns) {
                stream.print(Utils.INDENT);
                stream.printf("unsigned long %s;%n", ret.name());
            }

            body.printBody(stream, 1);

            stream.println("ret:");
            stream.print(Utils.INDENT);

            switch (returns.size()) {
                case 0 -> stream.println("return;");
                case 1 -> stream.printf("return %s;%n", returns.getFirst().name());
                default -> {
                    stream.printf("return (%s){", symbol.type().getReturnType());
                    boolean haveRet = false;

                    for (var ret : returns) {
                        if (haveRet) stream.print(", ");
                        stream.print(ret.name());
                        haveRet = true;
                    }

                    stream.println("};");
                }
            }

            stream.println("}");
        }
    }

    record Variable(AstSymbol.Location.Variable symbol, String section,
                    AstExpression.Literal value) implements AstDefinition {
        @Override
        public void print(PrintStream stream) {
            stream.printf("%sunsigned long %s = %s;%n", getVisibilityPrefix(), symbol.name(), value.getValueString());
        }
    }

    record Buffer(AstSymbol.Location.Buffer symbol, String section,
                  AstExpression.Literal size) implements AstDefinition {
        @Override
        public void print(PrintStream stream) {
            stream.printf("__attribute__((__aligned__(4))) %sunsigned char %s[%s];%n", getVisibilityPrefix(), symbol.name(), size.getValueString());
        }
    }

    record EmptyTable(AstSymbol.Location.Table symbol, String section,
                      AstExpression.Literal count) implements AstDefinition {
        @Override
        public void print(PrintStream stream) {
            stream.printf("%sunsigned long %s[%s];%n", getVisibilityPrefix(), symbol.name(), count.getValueString());
        }
    }

    record DataTable(AstSymbol.Location.Table symbol, String section,
                     List<AstExpression.Literal> values) implements AstDefinition {
        @Override
        public void print(PrintStream stream) {
            stream.printf("%sunsigned long %s[] = {%n", getVisibilityPrefix(), symbol.name());

            for (var value : values) {
                stream.printf("    %s,%n", value.getValueString());
            }

            stream.println("};");
        }
    }
}
