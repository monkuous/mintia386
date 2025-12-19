import java.io.PrintStream;
import java.util.List;

public interface AstStatement {
    void print(PrintStream stream, int indentLevel);

    record Block(List<AstStatement> body) implements AstStatement {
        @Override
        public void print(PrintStream stream, int indentLevel) {
            Utils.writeIndent(stream, indentLevel);
            stream.println("{");
            printBody(stream, indentLevel + 1);
            Utils.writeIndent(stream, indentLevel);
            stream.println("}");
        }

        public void printBody(PrintStream stream, int indentLevel) {
            for (var stmt : body) {
                stmt.print(stream, indentLevel);
            }
        }
    }

    record DeclareVariable(AstSymbol symbol, AstExpression initializer) implements AstStatement {
        @Override
        public void print(PrintStream stream, int indentLevel) {
            Utils.writeIndent(stream, indentLevel);

            if (initializer instanceof AstExpression.Call(var ignored0, var type, var ignored1)) {
                stream.printf("%s %s", type.getReturnType(), symbol.name());
            } else if (initializer instanceof AstExpression.InitializerList) {
                stream.printf("unsigned long %s[]", symbol.name());
            } else {
                stream.printf("unsigned long %s", symbol.name());
            }

            if (initializer != null) {
                stream.print(" = ");
                initializer.print(stream);
            }

            stream.println(";");
        }
    }

    record Expression(AstExpression expression) implements AstStatement {
        @Override
        public void print(PrintStream stream, int indentLevel) {
            Utils.writeIndent(stream, indentLevel);
            expression.print(stream);
            stream.println(";");
        }
    }

    record While(AstExpression condition, AstStatement.Block body) implements AstStatement {
        @Override
        public void print(PrintStream stream, int indentLevel) {
            Utils.writeIndent(stream, indentLevel);
            stream.print("while (");
            condition.print(stream);
            stream.println(") {");
            body.printBody(stream, indentLevel + 1);
            Utils.writeIndent(stream, indentLevel);
            stream.println("}");
        }
    }

    record If(AstExpression condition, AstStatement.Block trueBody, AstStatement falseBody) implements AstStatement {
        @Override
        public void print(PrintStream stream, int indentLevel) {
            Utils.writeIndent(stream, indentLevel);
            printBase(stream, indentLevel);
        }

        private void printBase(PrintStream stream, int indentLevel) {
            If current = this;

            label:
            while (true) {
                stream.print("if (");
                current.condition.print(stream);
                stream.println(") {");
                current.trueBody.printBody(stream, indentLevel + 1);
                Utils.writeIndent(stream, indentLevel);

                switch (current.falseBody) {
                    case If elseIf -> {
                        stream.print("} else ");
                        current = elseIf;
                    }
                    case Block block -> {
                        stream.println("} else {");
                        block.printBody(stream, indentLevel + 1);
                        Utils.writeIndent(stream, indentLevel);
                        stream.println("}");
                        break label;
                    }
                    case null -> {
                        stream.println("}");
                        break label;
                    }
                    default -> throw new IllegalStateException();
                }
            }
        }
    }

    record Basic(String text) implements AstStatement {
        @Override
        public void print(PrintStream stream, int indentLevel) {
            Utils.writeIndent(stream, indentLevel);
            stream.println(text);
        }
    }

    record DeclareBuffer(AstSymbol.Location.Buffer symbol, int size) implements AstStatement {
        @Override
        public void print(PrintStream stream, int indentLevel) {
            Utils.writeIndent(stream, indentLevel);
            stream.printf("__attribute__((aligned(4))) unsigned char %s[%d];%n", symbol.name(), size);
        }
    }
}
