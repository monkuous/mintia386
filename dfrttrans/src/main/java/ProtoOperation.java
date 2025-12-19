import java.util.ArrayList;
import java.util.List;

public interface ProtoOperation {
    void buildAst(StatementBuilder builder, ProtoFile file);

    record Int(Token token, int value) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            builder.pushExpr(new AstExpression.Literal.Int(value));
        }
    }

    record Str(Token token, String value) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            builder.pushExpr(new AstExpression.Literal.Str(value));
        }
    }

    record Sym(Token token) implements ProtoOperation {
        private void buildCall(StatementBuilder builder, AstSymbol.FunctionType type, int arguments, boolean varargs) {
            var funcExpr = builder.popExpr(token.location());
            var args = new ArrayList<AstExpression>();

            for (int i = 0; i < arguments; i++) {
                args.add(builder.popExpr(token.location()));
            }

            if (varargs) {
                var vargs = new ArrayList<AstExpression>();

                while (true) {
                    AstExpression expr = builder.maybePopExpr();
                    if (expr == null) break;
                    vargs.add(expr);
                }

                args.add(new AstExpression.Literal.Int(vargs.size()));

                var vargsName = builder.getTemporaryName();
                var vargsSym = new AstSymbol.Location.Table(vargsName, false);
                builder.add(new AstStatement.DeclareVariable(vargsSym, new AstExpression.InitializerList(vargs)));
                args.add(new AstExpression.Literal.Sym(vargsSym));
            }

            var callExpr = new AstExpression.Call(funcExpr, type, args);

            switch (type.returns().size()) {
                case 0 -> builder.add(new AstStatement.Expression(callExpr));
                case 1 -> builder.pushExpr(callExpr);
                default -> {
                    var allName = builder.getTemporaryName();
                    var allSym = new AstSymbol.Location.Variable(allName, false);
                    builder.add(new AstStatement.DeclareVariable(allSym, callExpr));

                    for (var ret : type.returns()) {
                        var retSym = new AstSymbol.Location.Variable("%s.%s".formatted(allName, ret), false);
                        builder.pushPureExpr(new AstExpression.Dereference(new AstExpression.Literal.Sym(retSym), ""));
                    }
                }
            }
        }

        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var def = builder.scope.resolve(token.text());

            if (def != null) {
                switch (def) {
                    case ProtoDefinition.Constant constant -> builder.pushExpr(constant.getAstValue(file));
                    case ProtoDefinition.StructureField field -> builder.pushExpr(field.getAstOffset(file));
                    case ProtoDefinition.Sym.Function function -> {
                        var sym = function.getSymbol(file);
                        builder.pushExpr(new AstExpression.Literal.Sym(sym));
                        buildCall(builder, sym.type(), function.arguments.size(), function.varargs != null);
                    }
                    case ProtoDefinition.Sym.FunctionType funcType ->
                            buildCall(builder, funcType.getSymbol(file), funcType.arguments, funcType.varargs);
                    case ProtoDefinition.Sym<?> symbolDef -> {
                        if (symbolDef.getSymbol(file) instanceof AstSymbol.Location location) {
                            builder.pushExpr(new AstExpression.Literal.Sym(location));
                        } else {
                            token.error("don't know what to do for this kind of symbol");
                        }
                    }
                    default -> token.error("don't know what to do for this kind of symbol");
                }
            } else {
                token.error("unrecognized symbol '%s'".formatted(token.text()));
            }
        }
    }

    record Pointerof(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var def = builder.scope.resolve(token.text());

            if (def != null) {
                if (def instanceof ProtoDefinition.Sym<?> sym) {
                    if (sym.getSymbol(file) instanceof AstSymbol.Location loc) {
                        builder.pushExpr(new AstExpression.Literal.Sym(loc));
                        return;
                    }
                }

                token.error("don't know what to do with this kind of symbol");
            } else {
                token.error("unrecognized symbol '%s'".formatted(token.text()));
            }
        }
    }

    record Block(List<ProtoOperation> operations) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            for (var op : operations) {
                op.buildAst(builder, file);
            }
        }
    }

    record Read(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            builder.pushExpr(new AstExpression.Dereference(builder.popExpr(token.location()), "volatile "));
        }
    }

    record ReadShort(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            builder.pushExpr(new AstExpression.DereferenceShort(builder.popExpr(token.location()), "volatile "));
        }
    }

    record ReadByte(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            builder.pushExpr(new AstExpression.DereferenceByte(builder.popExpr(token.location()), "volatile "));
        }
    }

    record Write(Token token, String operator) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            builder.add(new AstStatement.Expression(new AstExpression.Write(
                    new AstExpression.Dereference(builder.popExpr(token.location()), "volatile "), operator,
                    builder.popExpr(token.location()))
            ));
        }
    }

    record WriteShort(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var location = builder.popExpr(token.location());
            var value = builder.popExpr(token.location());

            if (value instanceof AstExpression.Literal.Int(int v)) {
                value = new AstExpression.Literal.Int(v & 0xffff);
            }

            builder.add(new AstStatement.Expression(new AstExpression.Write(
                    new AstExpression.DereferenceShort(location, "volatile "), "=",
                    value
            )));
        }
    }

    record WriteByte(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var location = builder.popExpr(token.location());
            var value = builder.popExpr(token.location());

            if (value instanceof AstExpression.Literal.Int(int v)) {
                value = new AstExpression.Literal.Int(v & 0xff);
            }

            builder.add(new AstStatement.Expression(new AstExpression.Write(
                    new AstExpression.DereferenceByte(location, "volatile "), "=",
                    value
            )));
        }
    }

    record Multiply(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                builder.pushExpr(new AstExpression.Literal.Int(a * b));
            } else {
                builder.pushExpr(new AstExpression.BinaryOperator(left, "*", right));
            }
        }
    }

    record RightShift(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                builder.pushExpr(new AstExpression.Literal.Int(a >>> (b & 31)));
            } else {
                builder.pushExpr(new AstExpression.BinaryOperator(left, ">>", right));
            }
        }
    }

    record Subtract(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                builder.pushExpr(new AstExpression.Literal.Int(a - b));
            } else {
                builder.pushExpr(new AstExpression.BinaryOperator(left, "-", right));
            }
        }
    }

    record BitNot(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var value = builder.popExpr(token.location());

            if (value instanceof AstExpression.Literal.Int(int v)) {
                builder.pushExpr(new AstExpression.Literal.Int(~v));
            } else {
                builder.pushExpr(new AstExpression.UnaryOperator("~", value));
            }
        }
    }

    record LeftShift(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                builder.pushExpr(new AstExpression.Literal.Int(a << (b & 31)));
            } else {
                builder.pushExpr(new AstExpression.BinaryOperator(left, "<<", right));
            }
        }
    }

    record Add(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                builder.pushExpr(new AstExpression.Literal.Int(a + b));
            } else {
                builder.pushExpr(new AstExpression.BinaryOperator(left, "+", right));
            }
        }
    }

    record BitOr(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                builder.pushExpr(new AstExpression.Literal.Int(a | b));
            } else {
                builder.pushExpr(new AstExpression.BinaryOperator(left, "|", right));
            }
        }
    }

    record Divide(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                if (b != 0) {
                    builder.pushExpr(new AstExpression.Literal.Int(Integer.divideUnsigned(a, b)));
                } else {
                    token.error("division by zero");
                    builder.pushExpr(new AstExpression.Literal.Int(0));
                }
            } else {
                builder.pushExpr(new AstExpression.BinaryOperator(left, "/", right));
            }
        }
    }

    record DeclareVariable(Token name) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var proto = new ProtoDefinition.Sym.Variable(name, "", "", null);
            var sym = proto.getSymbol(file);
            builder.add(new AstStatement.DeclareVariable(sym, null));
            builder.scope.add(proto);
        }
    }

    record While(Token token, ProtoOperation condition, ProtoOperation body) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var bodyBuilder = new StatementBuilder(builder.scope);

            condition.buildAst(bodyBuilder, file);
            var condExpr = bodyBuilder.popExpr(token.location());
            bodyBuilder.add(new AstStatement.If(
                    new AstExpression.UnaryOperator("!", condExpr),
                    new AstStatement.Block(List.of(new AstStatement.Basic("break;"))),
                    null
            ));

            body.buildAst(bodyBuilder, file);
            var body = bodyBuilder.buildBlock();

            builder.add(new AstStatement.While(new AstExpression.Literal.Int(1), body));
        }
    }

    record LowerThan(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                builder.pushExpr(new AstExpression.Literal.Int(Integer.compareUnsigned(a, b) < 0 ? 1 : 0));
            } else {
                builder.pushExpr(new AstExpression.BinaryOperator(left, "<", right));
            }
        }
    }

    record If(Token token, ProtoOperation condition, ProtoOperation trueBody,
              ProtoOperation falseBody) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            condition.buildAst(builder, file);
            var condExpr = builder.popExpr(token.location());

            if (condExpr instanceof AstExpression.Literal.Int(int i) && i == 0) {
                if (this.falseBody != null) {
                    this.falseBody.buildAst(builder, file);
                }

                return;
            }

            var bodyBuilder = new StatementBuilder(builder.scope);
            trueBody.buildAst(bodyBuilder, file);
            var trueBody = bodyBuilder.buildBlock();

            AstStatement falseBody;

            if (this.falseBody != null) {
                bodyBuilder = new StatementBuilder(builder.scope);
                this.falseBody.buildAst(bodyBuilder, file);
                falseBody = bodyBuilder.buildBlock();
            } else {
                falseBody = null;
            }

            builder.add(new AstStatement.If(condExpr, trueBody, falseBody));
        }
    }

    record Equal(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                builder.pushExpr(new AstExpression.Literal.Int(a == b ? 1 : 0));
            } else {
                builder.pushExpr(new AstExpression.BinaryOperator(left, "==", right));
            }
        }
    }

    record Basic(Token token, String text) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            builder.add(new AstStatement.Basic(text));
        }
    }

    record NotEqual(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                builder.pushExpr(new AstExpression.Literal.Int(a != b ? 1 : 0));
            } else {
                builder.pushExpr(new AstExpression.BinaryOperator(left, "!=", right));
            }
        }
    }

    record BitAnd(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                builder.pushExpr(new AstExpression.Literal.Int(a & b));
            } else {
                builder.pushExpr(new AstExpression.BinaryOperator(left, "&", right));
            }
        }
    }

    record GreaterEqual(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                builder.pushExpr(new AstExpression.Literal.Int(Integer.compareUnsigned(a, b) >= 0 ? 1 : 0));
            } else {
                builder.pushExpr(new AstExpression.BinaryOperator(left, ">=", right));
            }
        }
    }

    record Drop(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            builder.popExpr(token.location());
        }
    }

    record LogicNot(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var value = builder.popExpr(token.location());

            if (value instanceof AstExpression.Literal.Int(int v)) {
                builder.pushExpr(new AstExpression.Literal.Int(v == 0 ? 1 : 0));
            } else {
                builder.pushExpr(new AstExpression.UnaryOperator("!", value));
            }
        }
    }

    record Modulo(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                if (b != 0) {
                    builder.pushExpr(new AstExpression.Literal.Int(Integer.remainderUnsigned(a, b)));
                } else {
                    token.error("division by zero");
                    builder.pushExpr(new AstExpression.Literal.Int(0));
                }
            } else {
                builder.pushExpr(new AstExpression.BinaryOperator(left, "%", right));
            }
        }
    }

    record StackAllocate(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var sym = new AstSymbol.Location.Buffer(builder.getTemporaryName(), false);

            if (builder.popExpr(token.location()) instanceof AstExpression.Literal.Int(int size)) {
                builder.add(new AstStatement.DeclareBuffer(sym, size));
            } else {
                token.error("size must be constant");
            }

            builder.pushExpr(new AstExpression.Literal.Sym(sym));
        }
    }

    record GreaterThan(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                builder.pushExpr(new AstExpression.Literal.Int(Integer.compareUnsigned(a, b) > 0 ? 1 : 0));
            } else {
                builder.pushExpr(new AstExpression.BinaryOperator(left, ">", right));
            }
        }
    }

    record Index(Token token, ProtoOperation index, Token name) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var def = builder.scope.resolve(name.text());

            if (def instanceof ProtoDefinition.Sym<?> sym && sym.getSymbol(file) instanceof AstSymbol.Location loc) {
                index.buildAst(builder, file);
                var indexExpr = builder.popExpr(token.location());
                builder.pushExpr(new AstExpression.BinaryOperator(
                        new AstExpression.Literal.Sym(loc), "+",
                        new AstExpression.BinaryOperator(
                                indexExpr, "*", new AstExpression.Literal.Int(Main.WORD_SIZE)
                        )
                ));
            } else if (def != null) {
                name.error("don't know what to do with this kind of symbol");
            } else {
                name.error("unrecognized symbol '%s'".formatted(name.text()));
            }
        }
    }

    record LowerEqual(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                builder.pushExpr(new AstExpression.Literal.Int(Integer.compareUnsigned(a, b) <= 0 ? 1 : 0));
            } else {
                builder.pushExpr(new AstExpression.BinaryOperator(left, "<=", right));
            }
        }
    }

    record LogicAnd(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                builder.pushExpr(new AstExpression.Literal.Int(a != 0 && b != 0 ? 1 : 0));
            } else {
                builder.pushExpr(new AstExpression.BinaryOperator(left, "&&", right));
            }
        }
    }

    record LowerThanZero(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var value = builder.popExpr(token.location());

            if (value instanceof AstExpression.Literal.Int(int v)) {
                builder.pushExpr(new AstExpression.Literal.Int(v < 0 ? 1 : 0));
            } else {
                builder.pushExpr(new AstExpression.SignedBinaryOperator(value, "<", new AstExpression.Literal.Int(0)));
            }
        }
    }

    record GreaterThanZero(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var value = builder.popExpr(token.location());

            if (value instanceof AstExpression.Literal.Int(int v)) {
                builder.pushExpr(new AstExpression.Literal.Int(v > 0 ? 1 : 0));
            } else {
                builder.pushExpr(new AstExpression.SignedBinaryOperator(value, ">", new AstExpression.Literal.Int(0)));
            }
        }
    }

    record LowerThanSigned(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                builder.pushExpr(new AstExpression.Literal.Int(a < b ? 1 : 0));
            } else {
                builder.pushExpr(new AstExpression.SignedBinaryOperator(left, "<", right));
            }
        }
    }

    record LowerEqualSigned(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                builder.pushExpr(new AstExpression.Literal.Int(a <= b ? 1 : 0));
            } else {
                builder.pushExpr(new AstExpression.SignedBinaryOperator(left, "<=", right));
            }
        }
    }

    record GreaterThanSigned(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                builder.pushExpr(new AstExpression.Literal.Int(a > b ? 1 : 0));
            } else {
                builder.pushExpr(new AstExpression.SignedBinaryOperator(left, ">", right));
            }
        }
    }

    record GreaterEqualSigned(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                builder.pushExpr(new AstExpression.Literal.Int(a >= b ? 1 : 0));
            } else {
                builder.pushExpr(new AstExpression.SignedBinaryOperator(left, ">=", right));
            }
        }
    }

    record Xor(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                builder.pushExpr(new AstExpression.Literal.Int(a ^ b));
            } else {
                builder.pushExpr(new AstExpression.SignedBinaryOperator(left, "^", right));
            }
        }
    }

    record LogicOr(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                builder.pushExpr(new AstExpression.Literal.Int(a != 0 || b != 0 ? 1 : 0));
            } else {
                builder.pushExpr(new AstExpression.BinaryOperator(left, "||", right));
            }
        }
    }

    record Max(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var right = builder.popExpr(token.location());
            var left = builder.popExpr(token.location());

            if (left instanceof AstExpression.Literal.Int(int a) && right instanceof AstExpression.Literal.Int(int b)) {
                builder.pushExpr(a > b ? left : right);
            } else {
                token.error("_max only works with constant values");
            }
        }
    }

    record Dup(Token token) implements ProtoOperation {
        @Override
        public void buildAst(StatementBuilder builder, ProtoFile file) {
            var value = builder.popExpr(token.location());
            builder.pushExpr(value);
            builder.pushExpr(value);
        }
    }
}
