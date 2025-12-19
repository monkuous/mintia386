import java.io.PrintStream;
import java.util.List;

public interface AstExpression {
    void print(PrintStream stream);

    interface Literal extends AstExpression {
        String getValueString();

        default void print(PrintStream stream) {
            stream.print(getValueString());
        }

        record Int(int value) implements Literal {
            @Override
            public String getValueString() {
                return Integer.toUnsignedString(value, 10) + "UL";
            }
        }

        record Str(String value) implements Literal {
            @Override
            public String getValueString() {
                return "((unsigned long)%s)".formatted(Utils.escapeString(value));
            }
        }

        record Sym(AstSymbol.Location value) implements Literal {
            @Override
            public String getValueString() {
                if (value.name().equals("_dfs_argv")) {
                    return value.name();
                } else if (value instanceof AstSymbol.Location.Variable) {
                    return "((unsigned long)&%s)".formatted(value.name());
                } else {
                    return "((unsigned long)%s)".formatted(value.name());
                }
            }
        }
    }

    record InitializerList(List<AstExpression> values) implements AstExpression {
        @Override
        public void print(PrintStream stream) {
            stream.print("{");
            boolean haveValue = false;

            for (var value : values) {
                if (haveValue) stream.print(", ");
                value.print(stream);
                haveValue = true;
            }

            stream.print("}");
        }
    }

    record Call(AstExpression function, AstSymbol.FunctionType type,
                List<AstExpression> arguments) implements AstExpression {
        @Override
        public void print(PrintStream stream) {
            if (function instanceof Literal.Sym(AstSymbol.Location.Function value)) {
                stream.printf("%s(", value.name());
            } else {
                if (type.implicit()) throw new IllegalStateException();
                stream.printf("((%s)", type.name());
                function.print(stream);
                stream.print(")(");
            }

            boolean haveArg = false;

            for (var arg : arguments) {
                if (haveArg) stream.print(", ");
                arg.print(stream);
                haveArg = true;
            }

            stream.print(")");
        }
    }

    record Dereference(AstExpression pointer, String prefix) implements AstExpression {
        @Override
        public void print(PrintStream stream) {
            switch (pointer) {
                case Literal.Sym(AstSymbol.Location.Variable value) when !value.name().equals("_dfs_argv") ->
                        stream.print(value.name());
                case Literal.Sym(AstSymbol.Location.Table value) -> stream.printf("(*%s)", value.name());
                default -> {
                    stream.printf("(*(%sunsigned long *)", prefix);
                    pointer.print(stream);
                    stream.print(")");
                }
            }
        }
    }

    record DereferenceShort(AstExpression pointer, String prefix) implements AstExpression {
        @Override
        public void print(PrintStream stream) {
            stream.print("((unsigned long)");
            printBase(stream);
            stream.print(")");
        }

        public void printBase(PrintStream stream) {
            stream.printf("*(%sunsigned short *)", prefix);
            pointer.print(stream);
        }
    }

    record DereferenceByte(AstExpression pointer, String prefix) implements AstExpression {
        @Override
        public void print(PrintStream stream) {
            stream.print("((unsigned long)");
            printBase(stream);
            stream.print(")");
        }

        public void printBase(PrintStream stream) {
            stream.printf("*(%sunsigned char *)", prefix);
            pointer.print(stream);
        }
    }

    record Write(AstExpression location, String operator, AstExpression value) implements AstExpression {
        @Override
        public void print(PrintStream stream) {
            switch (location) {
                case Dereference ignored -> location.print(stream);
                case DereferenceShort ds -> ds.printBase(stream);
                case DereferenceByte db -> db.printBase(stream);
                default -> throw new IllegalStateException();
            }

            stream.printf(" %s ", operator);
            value.print(stream);
        }
    }

    record UnaryOperator(String operator, AstExpression value) implements AstExpression {
        @Override
        public void print(PrintStream stream) {
            stream.printf("(%s", operator);
            value.print(stream);
            stream.print(")");
        }
    }

    record BinaryOperator(AstExpression left, String operator, AstExpression right) implements AstExpression {
        @Override
        public void print(PrintStream stream) {
            stream.print("(");
            left.print(stream);
            stream.printf(" %s ", operator);
            right.print(stream);
            stream.print(")");
        }
    }

    record SignedBinaryOperator(AstExpression left, String operator, AstExpression right) implements AstExpression {
        @Override
        public void print(PrintStream stream) {
            stream.print("((signed long)");
            left.print(stream);
            stream.printf(" %s (signed long)", operator);
            right.print(stream);
            stream.print(")");
        }
    }
}
