import java.io.PrintStream;
import java.util.List;
import java.util.Objects;

public interface AstSymbol {
    String name();

    void print(PrintStream stream);

    interface Location extends AstSymbol {
        boolean externallyVisible();

        default String getVisibilityName() {
            return externallyVisible() ? "extern" : "static";
        }

        record Function(String name, boolean externallyVisible, FunctionType type) implements Location {
            @Override
            public void print(PrintStream stream) {
                type.print(stream);
                stream.printf("%s %s %s(%s);%n", getVisibilityName(), type.getReturnType(), name, type.getArgumentString());
            }
        }

        record Variable(String name, boolean externallyVisible) implements Location {
            @Override
            public void print(PrintStream stream) {
                stream.printf("%s unsigned long %s;%n", getVisibilityName(), name);
            }
        }

        record Buffer(String name, boolean externallyVisible) implements Location {
            @Override
            public void print(PrintStream stream) {
                stream.printf("%s unsigned char %s[];%n", getVisibilityName(), name);
            }
        }

        record Table(String name, boolean externallyVisible) implements Location {
            @Override
            public void print(PrintStream stream) {
                stream.printf("%s unsigned long %s[];%n", getVisibilityName(), name);
            }
        }
    }

    final class FunctionType implements AstSymbol {
        private final String name;
        private final int arguments;
        private final List<String> returns;
        private final boolean implicit;
        private boolean printed = false;

        public FunctionType(String name, int arguments, List<String> returns, boolean implicit) {
            this.name = name;
            this.arguments = arguments;
            this.returns = returns;
            this.implicit = implicit;
        }

        public String getReturnType() {
            return switch (returns.size()) {
                case 0 -> "void";
                case 1 -> "unsigned long";
                default -> "struct %s".formatted(name);
            };
        }

        public String getArgumentString() {
            var text = new StringBuilder();

            for (int i = 0; i < arguments; i++) {
                if (i != 0) text.append(", ");
                text.append("unsigned long");
            }

            return text.toString();
        }

        @Override
        public void print(PrintStream stream) {
            if (printed) return;

            if (returns.size() >= 2) {
                stream.printf("struct %s {%n", name);

                for (var ret : returns) {
                    stream.printf("    unsigned long %s;%n", ret);
                }

                stream.println("};");
            }

            if (!implicit) {
                stream.printf("typedef %s(*%s)(%s);%n", getReturnType(), name, getArgumentString());
            }

            printed = true;
        }

        @Override
        public String name() {
            return name;
        }

        public List<String> returns() {
            return returns;
        }

        public boolean implicit() {
            return implicit;
        }

        @Override
        public boolean equals(Object obj) {
            if (obj == this) return true;
            if (obj == null || obj.getClass() != this.getClass()) return false;
            var that = (FunctionType) obj;
            return Objects.equals(this.name, that.name) &&
                    this.arguments == that.arguments &&
                    Objects.equals(this.returns, that.returns) &&
                    this.implicit == that.implicit;
        }

        @Override
        public int hashCode() {
            return Objects.hash(name, arguments, returns, implicit);
        }

        @Override
        public String toString() {
            return "FunctionType[" +
                    "name=" + name + ", " +
                    "arguments=" + arguments + ", " +
                    "returns=" + returns + ", " +
                    "implicit=" + implicit + ']';
        }
    }
}
