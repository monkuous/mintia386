import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Locale;

public class Parser {
    private final Lexer lexer;
    private final ProtoFile file;
    private Token nextToken;
    private String dataSection = "data";
    private String bssSection = "bss";
    private ProtoDefinition.Sym.Function currentFunction;
    private ProtoOperation.Block rootBlock;

    private Parser(Lexer lexer, ProtoFile file) {
        this.lexer = lexer;
        this.file = file;
    }

    private ProtoDefinition parseDefinition() throws IOException {
        var token = expect(TokenType.IDENTIFIER);

        return switch (token.text()) {
            case "const" -> parseConstant();
            case "extern" -> parseExtern();
            case "externptr" -> parseExternPtr();
            case "struct" -> {
                parseStruct();
                yield null;
            }
            case "fnptr" -> parseFunctionType();
            case "fn" -> parseFunction();
            case "datasection" -> {
                dataSection = Utils.unescapeString(expect(TokenType.STRING).text());
                yield null;
            }
            case "bsssection" -> {
                bssSection = Utils.unescapeString(expect(TokenType.STRING).text());
                yield null;
            }
            case "rosection" -> {
                expect(TokenType.STRING);
                yield null;
            }
            case "buffer" -> parseBuffer();
            case "table" -> parseTable();
            case "var" -> parseVariable();
            case "public" -> {
                var name = expect(TokenType.IDENTIFIER);
                var value = file.resolve(name.text());

                if (value != null) {
                    if (value instanceof ProtoDefinition.Sym<?> sym) {
                        sym.externallyVisible = true;
                    } else {
                        name.error("don't know what to do with this kind of symbol");
                    }
                } else {
                    name.error("unrecognized symbol '%s'".formatted(name.text()));
                }

                yield null;
            }
            default -> {
                token.error("unrecognized definition type");
                yield null;
            }
        };
    }

    private ProtoDefinition.Constant parseConstant() throws IOException {
        var name = expect(TokenType.IDENTIFIER);
        var value = parseInitializer();

        return new ProtoDefinition.Constant(name, value);
    }

    private ProtoDefinition.Sym.Function parseExtern() throws IOException {
        var name = expect(TokenType.IDENTIFIER);
        expect(TokenType.LBRACE);
        var varargs = consume(TokenType.DOT_DOT_DOT);
        var arguments = new ArrayList<Token>();
        var returns = new ArrayList<Token>();

        while (consume(TokenType.MINUS_MINUS) == null) {
            arguments.addFirst(expect(TokenType.IDENTIFIER));
        }

        while (consume(TokenType.RBRACE) == null) {
            returns.add(expect(TokenType.IDENTIFIER));
        }

        var func = new ProtoDefinition.Sym.Function(name, arguments, returns, varargs);
        func.externallyVisible = true;
        return func;
    }

    private ProtoDefinition.Sym.Variable parseExternPtr() throws IOException {
        var name = expect(TokenType.IDENTIFIER);
        var variable = new ProtoDefinition.Sym.Variable(name, dataSection, bssSection, null);
        variable.externallyVisible = true;
        return variable;
    }

    private ProtoOperation parseInitializer() throws IOException {
        var token = advance();

        if (token.type() == TokenType.INTEGER) {
            return new ProtoOperation.Int(token, Utils.parseInteger(token.text()));
        } else if (token.type() == TokenType.CHAR) {
            return new ProtoOperation.Int(token, parseCharLiteral(token.text()));
        } else if (token.type() == TokenType.STRING) {
            return new ProtoOperation.Str(token, Utils.unescapeString(token.text()));
        } else if (token.type() == TokenType.IDENTIFIER) {
            if (token.text().equals("pointerof")) {
                return new ProtoOperation.Pointerof(expect(TokenType.IDENTIFIER));
            }

            return new ProtoOperation.Sym(token);
        } else if (token.type() == TokenType.LPAREN) {
            return parseBlock(TokenType.RPAREN, ")");
        } else {
            token.error("expected initializer");
            return new ProtoOperation.Int(token, 0);
        }
    }

    private ProtoOperation parseIf(Token token) throws IOException {
        expect(TokenType.LPAREN);
        var condition = parseBlock(TokenType.RPAREN, ")");
        var trueBody = parseBlock(TokenType.IDENTIFIER, "end");
        ProtoOperation falseBody;

        var elseIfToken = consumeIdent("elseif");

        if (elseIfToken != null) {
            falseBody = parseIf(elseIfToken);
        } else if (consumeIdent("else") != null) {
            falseBody = parseBlock(TokenType.IDENTIFIER, "end");
        } else {
            falseBody = null;
        }

        return new ProtoOperation.If(token, condition, trueBody, falseBody);
    }

    private ProtoOperation parseBlock(TokenType terminator, String terminatorText) throws IOException {
        var block = new ProtoOperation.Block(new ArrayList<>());

        boolean root = rootBlock == null;
        if (root) rootBlock = block;

        for (var token = advance(); token.type() != terminator || !token.text().equals(terminatorText); token = advance()) {
            switch (token.type()) {
                case IDENTIFIER -> {
                    switch (token.text()) {
                        case "if" -> block.operations().add(parseIf(token));
                        case "while" -> {
                            expect(TokenType.LPAREN);
                            var condition = parseBlock(TokenType.RPAREN, ")");
                            var body = parseBlock(TokenType.IDENTIFIER, "end");
                            block.operations().add(new ProtoOperation.While(token, condition, body));
                        }
                        case "auto" ->
                                rootBlock.operations().addFirst(new ProtoOperation.DeclareVariable(expect(TokenType.IDENTIFIER)));
                        case "fnsection" -> {
                            var name = expect(TokenType.STRING);

                            if (currentFunction != null) {
                                currentFunction.section = Utils.unescapeString(name.text());
                            } else {
                                token.error("fnsection outside function");
                            }
                        }
                        case "rosection" -> {
                        }
                        case "pointerof" -> {
                            var name = expect(TokenType.IDENTIFIER);

                            if (file.resolve(name.text()) == null) {
                                var proto = new ProtoDefinition.Sym.Variable(name, "", "", null);
                                proto.externallyVisible = true;
                                file.add(proto);
                            }

                            block.operations().add(new ProtoOperation.Pointerof(name));
                        }
                        case "swap", "bswap" -> token.error("TODO %s".formatted(token.text()));
                        case "return" -> block.operations().add(new ProtoOperation.Basic(token, "goto ret;"));
                        case "drop" -> block.operations().add(new ProtoOperation.Drop(token));
                        case "alloc" -> block.operations().add(new ProtoOperation.StackAllocate(token));
                        case "gb" -> block.operations().add(new ProtoOperation.ReadByte(token));
                        case "break" -> block.operations().add(new ProtoOperation.Basic(token, "break;"));
                        case "sb" -> block.operations().add(new ProtoOperation.WriteByte(token));
                        case "gi" -> block.operations().add(new ProtoOperation.ReadShort(token));
                        case "si" -> block.operations().add(new ProtoOperation.WriteShort(token));
                        case "continue" -> block.operations().add(new ProtoOperation.Basic(token, "continue;"));
                        case "_max" -> block.operations().add(new ProtoOperation.Max(token));
                        case "dup" -> block.operations().add(new ProtoOperation.Dup(token));
                        default -> block.operations().add(new ProtoOperation.Sym(token));
                    }
                }
                case INTEGER -> block.operations().add(new ProtoOperation.Int(token, Utils.parseInteger(token.text())));
                case CHAR -> block.operations().add(new ProtoOperation.Int(token, parseCharLiteral(token.text())));
                case STRING ->
                        block.operations().add(new ProtoOperation.Str(token, Utils.unescapeString(token.text())));
                case STAR -> block.operations().add(new ProtoOperation.Multiply(token));
                case GT_GT -> block.operations().add(new ProtoOperation.RightShift(token));
                case MINUS -> block.operations().add(new ProtoOperation.Subtract(token));
                case TILDE -> block.operations().add(new ProtoOperation.BitNot(token));
                case LT_LT -> block.operations().add(new ProtoOperation.LeftShift(token));
                case PLUS -> block.operations().add(new ProtoOperation.Add(token));
                case PIPE -> block.operations().add(new ProtoOperation.BitOr(token));
                case SLASH -> block.operations().add(new ProtoOperation.Divide(token));
                case EXCL -> block.operations().add(new ProtoOperation.Write(token, "="));
                case AT -> block.operations().add(new ProtoOperation.Read(token));
                case LT -> block.operations().add(new ProtoOperation.LowerThan(token));
                case EQ_EQ -> block.operations().add(new ProtoOperation.Equal(token));
                case PLUS_EQ -> block.operations().add(new ProtoOperation.Write(token, "+="));
                case TILDE_EQ -> block.operations().add(new ProtoOperation.NotEqual(token));
                case AND -> block.operations().add(new ProtoOperation.BitAnd(token));
                case GT_EQ -> block.operations().add(new ProtoOperation.GreaterEqual(token));
                case TILDE_TILDE -> block.operations().add(new ProtoOperation.LogicNot(token));
                case PERCENT -> block.operations().add(new ProtoOperation.Modulo(token));
                case MINUS_EQ -> block.operations().add(new ProtoOperation.Write(token, "-="));
                case GT -> block.operations().add(new ProtoOperation.GreaterThan(token));
                case LBRACK -> {
                    var index = parseBlock(TokenType.RBRACK, "]");
                    var name = expect(TokenType.IDENTIFIER);
                    block.operations().add(new ProtoOperation.Index(token, index, name));
                }
                case GT_GT_EQ -> block.operations().add(new ProtoOperation.Write(token, ">>="));
                case LT_LT_EQ -> block.operations().add(new ProtoOperation.Write(token, "<<="));
                case LT_EQ -> block.operations().add(new ProtoOperation.LowerEqual(token));
                case AND_AND -> block.operations().add(new ProtoOperation.LogicAnd(token));
                case AND_EQ -> block.operations().add(new ProtoOperation.Write(token, "&="));
                case PIPE_EQ -> block.operations().add(new ProtoOperation.Write(token, "|="));
                case Z_LT -> block.operations().add(new ProtoOperation.LowerThanZero(token));
                case Z_GT -> block.operations().add(new ProtoOperation.GreaterThanZero(token));
                case S_LT -> block.operations().add(new ProtoOperation.LowerThanSigned(token));
                case S_LT_EQ -> block.operations().add(new ProtoOperation.LowerEqualSigned(token));
                case S_GT -> block.operations().add(new ProtoOperation.GreaterThanSigned(token));
                case S_GT_EQ -> block.operations().add(new ProtoOperation.GreaterEqualSigned(token));
                case CARET -> block.operations().add(new ProtoOperation.Xor(token));
                case PERCENT_EQ -> block.operations().add(new ProtoOperation.Write(token, "%="));
                case PIPE_PIPE -> block.operations().add(new ProtoOperation.LogicOr(token));
                case SLASH_EQ -> block.operations().add(new ProtoOperation.Write(token, "/="));
                case STAR_EQ -> block.operations().add(new ProtoOperation.Write(token, "*="));
                default -> token.error("unrecognized operation");
            }
        }

        if (root) rootBlock = null;

        return block;
    }

    private int parseCharLiteral(String text) {
        int value = 0;

        for (int b : Utils.unescapeString(text).getBytes(StandardCharsets.UTF_8)) {
            value = (value << 8) | b;
        }

        return value;
    }

    private void parseStruct() throws IOException {
        var baseName = expect(TokenType.IDENTIFIER);
        var structure = new ArrayList<ProtoDefinition.StructureField>();

        while (consumeIdent("endstruct") == null) {
            var size = parseInitializer();
            var name = expect(TokenType.IDENTIFIER);
            var field = new ProtoDefinition.StructureField(
                    new Token(TokenType.IDENTIFIER, "%s_%s".formatted(baseName.text(), name.text()), name.location()),
                    structure, structure.size(), size
            );
            structure.add(field);
            file.add(field);
        }

        var field = new ProtoDefinition.StructureField(
                new Token(TokenType.IDENTIFIER, "%s_SIZEOF".formatted(baseName.text()), baseName.location()),
                structure, structure.size(),
                new ProtoOperation.Int(new Token(TokenType.INTEGER, "0", baseName.location()), 0)
        );
        structure.add(field);
        file.add(field);
    }

    private ProtoDefinition.Sym.FunctionType parseFunctionType() throws IOException {
        var name = expect(TokenType.IDENTIFIER);
        expect(TokenType.LBRACE);
        var varargs = consume(TokenType.DOT_DOT_DOT) != null;
        int arguments = 0;
        var returns = new ArrayList<Token>();

        while (consume(TokenType.MINUS_MINUS) == null) {
            expect(TokenType.IDENTIFIER);
            arguments += 1;
        }

        while (consume(TokenType.RBRACE) == null) {
            returns.add(expect(TokenType.IDENTIFIER));
        }

        return new ProtoDefinition.Sym.FunctionType(name, arguments, returns, varargs);
    }

    private ProtoDefinition.Sym.Function parseFunction() throws IOException {
        Token type = null;

        if (consume(TokenType.LPAREN) != null) {
            type = expect(TokenType.IDENTIFIER);
            expect(TokenType.RPAREN);
        }

        boolean externallyVisible = consumeIdent("private") == null;
        var func = parseExtern();
        func.type = type;
        func.section = "text";
        func.externallyVisible = externallyVisible;

        currentFunction = func;
        func.body = parseBlock(TokenType.IDENTIFIER, "end");
        currentFunction = null;

        return func;
    }

    private ProtoDefinition.Sym.Buffer parseBuffer() throws IOException {
        var name = expect(TokenType.IDENTIFIER);
        var size = parseInitializer();

        return new ProtoDefinition.Sym.Buffer(name, bssSection, size);
    }

    private ProtoDefinition.Sym<AstSymbol.Location.Table> parseTable() throws IOException {
        var name = expect(TokenType.IDENTIFIER);

        if (consume(TokenType.LBRACK) != null) {
            var count = parseInitializer();
            expect(TokenType.RBRACK);
            return new ProtoDefinition.Sym.EmptyTable(name, bssSection, count);
        }

        var values = new ArrayList<ProtoOperation>();

        while (consumeIdent("endtable") == null) {
            values.add(parseInitializer());
        }

        return new ProtoDefinition.Sym.DataTable(name, dataSection, values);
    }

    private ProtoDefinition.Sym.Variable parseVariable() throws IOException {
        var name = expect(TokenType.IDENTIFIER);
        var value = parseInitializer();

        return new ProtoDefinition.Sym.Variable(name, dataSection, bssSection, value);
    }

    private Token consume(TokenType type) throws IOException {
        var token = peek();
        if (token.type() == type) advance();
        else return null;
        return token;
    }

    private Token consumeIdent(String text) throws IOException {
        var token = peek();
        if (token.type() == TokenType.IDENTIFIER && token.text().equals(text)) advance();
        else return null;
        return token;
    }

    private Token expect(TokenType type) throws IOException {
        var token = advance();
        if (token.type() != type) token.error("expected %s".formatted(type.name().toLowerCase(Locale.ENGLISH)));
        return token;
    }

    private Token advance() throws IOException {
        var token = peek();
        nextToken = null;
        return token;
    }

    private Token peek() throws IOException {
        if (nextToken == null) nextToken = lexer.nextToken();
        return nextToken;
    }

    public static ProtoFile parse(InputStream stream, String path) throws IOException {
        var file = new ProtoFile(path);
        var parser = new Parser(new Lexer(stream, path), file);

        while (parser.peek().type() != TokenType.EOF) {
            var def = parser.parseDefinition();
            if (def == null) continue;
            file.addOrReplace(def);
        }

        return file;
    }
}
