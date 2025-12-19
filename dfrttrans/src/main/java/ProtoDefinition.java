import java.util.ArrayList;
import java.util.List;

public abstract class ProtoDefinition {
    public final Token name;

    public ProtoDefinition(Token name) {
        this.name = name;
    }

    public void resolve(ProtoFile file) {
    }

    public abstract static class Sym<T extends AstSymbol> extends ProtoDefinition {
        public boolean externallyVisible;
        private T symbol;

        public Sym(Token name) {
            super(name);
        }

        public T getSymbol(ProtoFile file) {
            if (symbol == null) symbol = createSymbol(file);
            return symbol;
        }

        protected abstract T createSymbol(ProtoFile file);

        public AstDefinition createDefinition(ProtoFile file) {
            return null;
        }

        public static class FunctionType extends Sym<AstSymbol.FunctionType> {
            public final int arguments;
            private final List<Token> returns;
            public final boolean varargs;

            public FunctionType(Token name, int arguments, List<Token> returns, boolean varargs) {
                super(name);
                this.arguments = arguments;
                this.returns = returns;
                this.varargs = varargs;
            }

            @Override
            protected AstSymbol.FunctionType createSymbol(ProtoFile file) {
                var returnNames = new ArrayList<String>();

                for (var ret : returns) {
                    returnNames.add(Utils.transformName(ret.text()));
                }

                return new AstSymbol.FunctionType(Utils.transformName(name.text()), arguments + (varargs ? 2 : 0), returnNames, false);
            }
        }

        public static class Function extends Sym<AstSymbol.Location.Function> {
            public final List<Token> arguments;
            public final List<Token> returns;
            public final Token varargs;
            public Token type;
            public String section = "";
            public ProtoOperation body;

            public Function(Token name, List<Token> arguments, List<Token> returns, Token varargs) {
                super(name);
                this.arguments = arguments;
                this.returns = returns;
                this.varargs = varargs;
            }

            private AstSymbol.FunctionType getExplicitType(ProtoFile file) {
                if (type == null) return null;

                var proto = file.resolve(type.text());

                if (proto == null) {
                    type.error("cannot resolve symbol '%s'".formatted(type.text()));
                    return null;
                }

                if (proto instanceof FunctionType funcTypeProto) {
                    if (funcTypeProto.arguments != arguments.size()) type.error("mismatched argument count");
                    if (funcTypeProto.returns.size() != returns.size()) type.error("mismatched return count");
                    if (funcTypeProto.varargs == (varargs == null)) type.error("mismatched varargs status");

                    return funcTypeProto.getSymbol(file);
                } else {
                    type.error("'%s' is not a function type".formatted(type.text()));
                    return null;
                }
            }

            @Override
            protected AstSymbol.Location.Function createSymbol(ProtoFile file) {
                AstSymbol.FunctionType type = getExplicitType(file);

                if (type == null) {
                    var returnNames = new ArrayList<String>();

                    for (var ret : returns) {
                        returnNames.add(Utils.transformName(ret.text()));
                    }

                    type = new AstSymbol.FunctionType(Utils.transformName(name.text()), arguments.size() + (varargs != null ? 2 : 0), returnNames, true);
                }

                return new AstSymbol.Location.Function(Utils.transformName(name.text()), externallyVisible, type);
            }

            @Override
            public AstDefinition createDefinition(ProtoFile file) {
                if (body == null) return null;

                var builder = new StatementBuilder(new Scope(file));
                var argSymbols = new ArrayList<AstSymbol.Location>();
                var retSymbols = new ArrayList<AstSymbol.Location>();

                for (var arg : arguments) {
                    var proto = new Variable(arg, "", "", null);
                    builder.scope.add(proto);
                    argSymbols.add(proto.getSymbol(file));
                }

                if (varargs != null) {
                    var argcToken = new Token(TokenType.IDENTIFIER, "argc", varargs.location());
                    var argvToken = new Token(TokenType.IDENTIFIER, "argv", varargs.location());
                    var argcProto = new Variable(argcToken, "", "", null);
                    var argvProto = new Variable(argvToken, "", "", null);
                    argcProto.nameOverride = "_dfs_argc";
                    argvProto.nameOverride = "_dfs_argv";
                    builder.scope.add(argcProto);
                    builder.scope.add(argvProto);
                    argSymbols.add(argcProto.getSymbol(file));
                    argSymbols.add(argvProto.getSymbol(file));
                }

                for (var ret : returns) {
                    var proto = new Variable(ret, "", "", null);
                    builder.scope.add(proto);
                    retSymbols.add(proto.getSymbol(file));
                }

                body.buildAst(builder, file);

                return new AstDefinition.Function(getSymbol(file), section, argSymbols, retSymbols, builder.buildBlock());
            }
        }

        public static class Variable extends Sym<AstSymbol.Location.Variable> {
            private final String dataSection;
            private final String bssSection;
            public ProtoOperation value;
            public String nameOverride;

            public Variable(Token name, String dataSection, String bssSection, ProtoOperation value) {
                super(name);
                this.dataSection = dataSection;
                this.bssSection = bssSection;
                this.value = value;
            }

            @Override
            protected AstSymbol.Location.Variable createSymbol(ProtoFile file) {
                return new AstSymbol.Location.Variable(nameOverride == null ? Utils.transformName(name.text()) : nameOverride, externallyVisible);
            }

            @Override
            public AstDefinition createDefinition(ProtoFile file) {
                if (value == null) return null;

                var astValue = StatementBuilder.buildLiteral(value, file, name.location());
                String section = dataSection;

                if (astValue instanceof AstExpression.Literal.Int(int v) && v == 0) {
                    section = bssSection;
                }

                return new AstDefinition.Variable(getSymbol(file), section, astValue);
            }
        }

        public static class Buffer extends Sym<AstSymbol.Location.Buffer> {
            private final String section;
            public ProtoOperation size;

            public Buffer(Token name, String section, ProtoOperation size) {
                super(name);
                this.section = section;
                this.size = size;
            }

            @Override
            protected AstSymbol.Location.Buffer createSymbol(ProtoFile file) {
                return new AstSymbol.Location.Buffer(Utils.transformName(name.text()), externallyVisible);
            }

            @Override
            public AstDefinition createDefinition(ProtoFile file) {
                var astSize = StatementBuilder.buildLiteral(size, file, name.location());
                return new AstDefinition.Buffer(getSymbol(file), section, astSize);
            }
        }

        public static class DataTable extends Sym<AstSymbol.Location.Table> {
            private final String section;
            private final List<ProtoOperation> values;

            public DataTable(Token name, String section, List<ProtoOperation> values) {
                super(name);
                this.section = section;
                this.values = values;
            }

            @Override
            protected AstSymbol.Location.Table createSymbol(ProtoFile file) {
                return new AstSymbol.Location.Table(Utils.transformName(name.text()), externallyVisible);
            }

            @Override
            public AstDefinition createDefinition(ProtoFile file) {
                var astValues = new ArrayList<AstExpression.Literal>(values.size());

                for (var value : values) {
                    astValues.add(StatementBuilder.buildLiteral(value, file, name.location()));
                }

                return new AstDefinition.DataTable(getSymbol(file), section, astValues);
            }
        }

        public static class EmptyTable extends Sym<AstSymbol.Location.Table> {
            private final String section;
            public ProtoOperation count;

            public EmptyTable(Token name, String section, ProtoOperation count) {
                super(name);
                this.section = section;
                this.count = count;
            }

            @Override
            protected AstSymbol.Location.Table createSymbol(ProtoFile file) {
                return new AstSymbol.Location.Table(Utils.transformName(name.text()), externallyVisible);
            }

            @Override
            public AstDefinition createDefinition(ProtoFile file) {
                var astCount = StatementBuilder.buildLiteral(count, file, name.location());
                return new AstDefinition.EmptyTable(getSymbol(file), section, astCount);
            }
        }
    }

    public static class Constant extends ProtoDefinition {
        private final ProtoOperation value;
        private AstExpression.Literal astValue;
        private boolean creating;

        public Constant(Token name, ProtoOperation value) {
            super(name);
            this.value = value;
        }

        public AstExpression.Literal getAstValue(ProtoFile file) {
            if (astValue == null) {
                if (creating) {
                    name.error("recursive constant initializers");
                    return new AstExpression.Literal.Int(0);
                }

                creating = true;
                astValue = StatementBuilder.buildLiteral(value, file, name.location());
            }

            return astValue;
        }

        @Override
        public void resolve(ProtoFile file) {
            getAstValue(file);
        }
    }

    public static class StructureField extends ProtoDefinition {
        private final List<StructureField> structure;
        private final int index;
        private final ProtoOperation size;
        private AstExpression.Literal astSize;
        private AstExpression.Literal astOffset;
        private boolean creatingSize, creatingOffset;

        public StructureField(Token name, List<StructureField> structure, int index, ProtoOperation size) {
            super(name);
            this.structure = structure;
            this.index = index;
            this.size = size;
        }

        public AstExpression.Literal getAstSize(ProtoFile file) {
            if (astSize == null) {
                if (creatingSize) {
                    name.error("recursive constant initializers");
                    return new AstExpression.Literal.Int(0);
                }

                creatingSize = true;
                astSize = StatementBuilder.buildLiteral(size, file, name.location());

                if (!(astSize instanceof AstExpression.Literal.Int)) {
                    name.error("size is not a constant integer");
                }
            }

            return astSize;
        }

        public AstExpression.Literal getAstOffset(ProtoFile file) {
            if (astOffset == null) {
                if (creatingOffset) {
                    name.error("recursive constant initializers");
                }

                creatingOffset = true;
                int offset = 0;
                int i;

                for (i = index; i > 0; i--) {
                    var field = structure.get(i - 1);

                    if (field.astOffset instanceof AstExpression.Literal.Int(int o)) {
                        offset = o;

                        if (field.getAstSize(file) instanceof AstExpression.Literal.Int(int s)) {
                            offset += s;
                        }

                        break;
                    }
                }

                for (; i < index; i++) {
                    var field = structure.get(i);

                    if (field.astOffset == null) {
                        field.astOffset = new AstExpression.Literal.Int(offset);
                    }

                    if (field.getAstSize(file) instanceof AstExpression.Literal.Int(int s)) {
                        offset += s;
                    }
                }

                astOffset = new AstExpression.Literal.Int(offset);
            }

            return astOffset;
        }

        @Override
        public void resolve(ProtoFile file) {
            getAstSize(file);
            getAstOffset(file);
        }
    }
}
