import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

public class StatementBuilder {
    private static int TEMPORARIES = 0;
    private final List<AstStatement> statements = new ArrayList<>();
    private final Stack<AstExpression> expressions = new Stack<>();
    public Scope scope;

    public StatementBuilder(Scope scope) {
        this.scope = scope;
    }

    public String getTemporaryName() {
        return "_dft%d".formatted(TEMPORARIES++);
    }

    public AstStatement.Block buildBlock() {
        if (statements.size() == 1 && statements.getFirst() instanceof AstStatement.Block block) {
            return block;
        }

        return new AstStatement.Block(statements);
    }

    public void add(AstStatement statement) {
        statements.add(statement);
    }

    public void pushExpr(AstExpression expr) {
        if (!(expr instanceof AstExpression.Literal)) {
            var sym = new AstSymbol.Location.Variable(getTemporaryName(), false);
            add(new AstStatement.DeclareVariable(sym, expr));
            expr = new AstExpression.Dereference(new AstExpression.Literal.Sym(sym), "");
        }

        expressions.push(expr);
    }

    public void pushPureExpr(AstExpression expr) {
        expressions.push(expr);
    }

    public AstExpression maybePopExpr() {
        return expressions.empty() ? null : expressions.pop();
    }

    public AstExpression popExpr(Location errorLoc) {
        if (expressions.empty()) {
            errorLoc.error("not enough operands");
            return new AstExpression.Literal.Int(0);
        }

        return expressions.pop();
    }

    public static AstExpression.Literal buildLiteral(ProtoOperation operation, ProtoFile file, Location errorLoc) {
        var builder = new StatementBuilder(new Scope(file));

        operation.buildAst(builder, file);

        var expr = builder.popExpr(errorLoc);

        if (builder.statements.isEmpty() && builder.expressions.empty() && expr instanceof AstExpression.Literal literal) {
            return literal;
        } else {
            errorLoc.error("value is not a constant");
            return new AstExpression.Literal.Int(0);
        }
    }
}
