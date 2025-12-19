import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.function.IntPredicate;

public class Lexer {
    private static final int TAB_WIDTH = 8;
    private static final Map<String, TokenType> OPERATORS = new HashMap<>();
    private final InputStream input;
    private final StringBuilder text = new StringBuilder();
    private Location startLocation = null;
    private String currentPath;
    private int currentLine = 1;
    private int currentColumn = 1;
    private boolean eof = false;
    private boolean lineStart = true;
    private int nextValue = -1;

    public Lexer(InputStream input, String path) {
        this.input = input;
        this.currentPath = path;
    }

    private int peek() throws IOException {
        if (eof) return -1;
        if (nextValue >= 0) return nextValue;

        int value = input.read();

        if (value < 0) {
            eof = true;
            return -1;
        }

        nextValue = value;
        return value;
    }

    private int advance() throws IOException {
        int value = peek();
        nextValue = -1;
        if (value < 0) return value;

        text.append((char) value);

        if (value == '\n') {
            currentLine += 1;
            currentColumn = 1;
            lineStart = true;
        } else {
            if (value == '\t') {
                currentColumn = ((currentColumn - 1 + TAB_WIDTH) & -TAB_WIDTH) + 1;
            } else {
                currentColumn += 1;
            }

            lineStart = false;
        }

        return value;
    }

    private boolean isWs(int value) {
        return value == ' ' || value == '\t';
    }

    private boolean isWsOrLf(int value) {
        return isWs(value) || value == '\n';
    }

    private void skipWhile(IntPredicate predicate) throws IOException {
        while (predicate.test(peek())) advance();
    }

    private void skipUntil(IntPredicate predicate) throws IOException {
        while (true) {
            int value = peek();
            if (value < 0 || predicate.test(value)) break;
            advance();
        }
    }

    private boolean consume(int value) throws IOException {
        int actual = peek();
        if (actual == value) advance();
        return actual == value;
    }

    private void error(String message) {
        new Location(currentPath, currentLine, currentColumn).error(message);
    }

    private void expect(int value) throws IOException {
        if (!consume(value)) error("expected '%c'".formatted((char) value));
    }

    private void processLocationDirective() throws IOException {
        while (lineStart) {
            if (!consume('#')) return;

            skipWhile(this::isWs);
            text.setLength(0);
            skipUntil(this::isWsOrLf);
            String path = text.toString();

            skipWhile(this::isWs);
            text.setLength(0);
            skipUntil(this::isWsOrLf);
            int line = Integer.parseUnsignedInt(text.toString(), 10);

            skipWhile(this::isWs);
            expect('\n');

            currentPath = path;
            currentLine = line;

            skipWhile(this::isWsOrLf);
        }
    }

    private Token emitToken(TokenType type) {
        return new Token(type, text.toString(), startLocation);
    }

    private boolean isDigit(int value) {
        return value >= '0' && value <= '9';
    }

    private boolean isIdentStart(int value) {
        return (value >= 'A' && value <= 'Z') || (value >= 'a' && value <= 'z') || value == '_';
    }

    private boolean isIdentPart(int value) {
        return isIdentStart(value) || isDigit(value);
    }

    private boolean isWsOrLfOrKc(int value) {
        return isWsOrLf(value) || value == '!' || value == '@' || value == '(' || value == ')' || value == '[' || value == ']';
    }

    public Token nextToken() throws IOException {
        start:
        while (true) {
            skipWhile(this::isWsOrLf);
            processLocationDirective();

            text.setLength(0);
            startLocation = new Location(currentPath, currentLine, currentColumn);

            int value = advance();

            if (value < 0) return emitToken(TokenType.EOF);

            if (value == '"' || value == '\'') {
                boolean isEscape = false;

                while (true) {
                    int stringChar = advance();

                    if (stringChar < 0) {
                        error("unterminated string literal");
                        break;
                    }

                    if (!isEscape) {
                        if (stringChar == value) {
                            break;
                        } else if (stringChar == '\\') {
                            isEscape = true;
                        }
                    } else {
                        isEscape = false;
                    }
                }

                return emitToken(value == '"' ? TokenType.STRING : TokenType.CHAR);
            } else if (isWsOrLfOrKc(value)) {
                return emitToken(switch (value) {
                    case '!' -> TokenType.EXCL;
                    case '@' -> TokenType.AT;
                    case '(' -> TokenType.LPAREN;
                    case ')' -> TokenType.RPAREN;
                    case '[' -> TokenType.LBRACK;
                    case ']' -> TokenType.RBRACK;
                    default -> throw new IllegalStateException("unknown key char '%c'".formatted((char) value));
                });
            }

            skipUntil(this::isWsOrLfOrKc);

            String text = this.text.toString();
            TokenType type = OPERATORS.get(text);

            if (type == null) {
                if (value == '-' || value == '+' || isDigit(value)) {
                    type = TokenType.INTEGER;

                    try {
                        Utils.parseInteger(text);
                    } catch (NumberFormatException ignored) {
                        error("unrecognized token '%s'".formatted(text));
                        continue;
                    }
                } else if (isIdentStart(value)) {
                    for (int i = 1; i < text.length(); i++) {
                        if (!isIdentPart(text.charAt(i))) {
                            error("unrecognized token '%s'".formatted(text));
                            continue start;
                        }
                    }

                    type = TokenType.IDENTIFIER;
                } else {
                    error("unrecognized token '%s'".formatted(text));
                    continue;
                }
            }

            return new Token(type, text, startLocation);
        }
    }

    static {
        for (TokenType type : TokenType.values()) {
            if (type.text != null) {
                OPERATORS.put(type.text, type);
            }
        }
    }
}
