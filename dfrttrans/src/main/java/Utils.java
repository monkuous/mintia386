import java.io.PrintStream;
import java.nio.charset.StandardCharsets;
import java.util.Set;

public class Utils {
    public static final String INDENT = "    ";

    private static final Set<String> RESERVED_NAMES = Set.of("auto", "break", "case", "char", "const", "continue",
            "default", "do", "double", "else", "enum", "extern", "float", "for", "goto", "if", "inline", "int", "long",
            "register", "restrict", "return", "short", "signed", "sizeof", "static", "struct", "switch", "typedef",
            "union", "unsigned", "void", "volatile", "while", "_Bool", "_Complex", "_Imaginary", "memcmp", "memcpy",
            "memmove", "memset");

    private static int getIntPartStart(String text) {
        if (text.charAt(0) == '-' || text.charAt(0) == '+') {
            return 1;
        } else {
            return 0;
        }
    }

    private static int getIntBase(String text, int start) {
        if (start >= text.length()) throw new NumberFormatException("no digits in integer");

        if (text.charAt(start) == '0') {
            if (text.length() - start == 1) return 10;
            if (text.charAt(start + 1) == 'x' || text.charAt(start + 1) == 'X') return 16;

            throw new NumberFormatException("unrecognized base");
        }

        return 10;
    }

    private static int getBasePrefixLength(int base) {
        return switch (base) {
            case 10 -> 0;
            case 16 -> 2;
            default -> throw new IllegalArgumentException("unrecognized base %d".formatted(base));
        };
    }

    public static int parseInteger(String text) {
        int start = getIntPartStart(text);
        int base = getIntBase(text, start);
        int realStart = start + getBasePrefixLength(base);
        if (realStart >= text.length()) throw new NumberFormatException("no digits in integer");
        int value = Integer.parseUnsignedInt(text, realStart, text.length(), base);

        if (text.charAt(0) != '-') {
            return value;
        } else {
            return -value;
        }
    }

    public static String transformName(String name) {
        if (!isNameReservedInC(name)) return name;
        return "_df_" + name;
    }

    private static boolean isNameReservedInC(String name) {
        return name.startsWith("_df") || name.matches("_[_A-Z]") || RESERVED_NAMES.contains(name);
    }

    public static String unescapeString(String str) {
        var text = new StringBuilder();
        boolean inEscape = false;

        for (int i = 1; i < str.length() - 1; i++) {
            char c = str.charAt(i);

            if (!inEscape) {
                if (c == '\\') {
                    inEscape = true;
                    continue;
                }
            } else {
                c = switch (c) {
                    case 'n' -> '\n';
                    case 't' -> '\t';
                    case 'r' -> '\r';
                    case '[' -> 0x1b;
                    default -> c;
                };
            }

            text.append(c);
            inEscape = false;
        }

        return text.toString();
    }

    public static String escapeString(String str) {
        var text = new StringBuilder("\"");
        var bytes = str.getBytes(StandardCharsets.UTF_8);

        for (int value : bytes) {
            if (value >= 0x20 && value <= 0x7e && value != '"') {
                text.append((char) value);
            } else {
                text.append("\\x%02x".formatted(value));
            }
        }

        text.append("\"");
        return text.toString();
    }

    public static void writeIndent(PrintStream stream, int indentLevel) {
        for (int i = 0; i < indentLevel; i++) {
            stream.print(INDENT);
        }
    }
}
