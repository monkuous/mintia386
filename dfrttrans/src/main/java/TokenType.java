public enum TokenType {
    EOF,
    INTEGER,
    IDENTIFIER,
    STRING,
    CHAR,
    EXCL,
    AT,
    LPAREN,
    RPAREN,
    LBRACK,
    RBRACK,
    LBRACE("{"),
    RBRACE("}"),
    MINUS_MINUS("--"),
    DOT_DOT_DOT("..."),
    TILDE("~"),
    TILDE_TILDE("~~"),
    AND("&"),
    AND_AND("&&"),
    PIPE("|"),
    CARET("^"),
    PIPE_PIPE("||"),
    GT_GT(">>"),
    LT_LT("<<"),
    EQ_EQ("=="),
    TILDE_EQ("~="),
    GT(">"),
    LT("<"),
    GT_EQ(">="),
    LT_EQ("<="),
    Z_LT("z<"),
    Z_GT("z>"),
    S_GT("s>"),
    S_LT("s<"),
    S_GT_EQ("s>="),
    S_LT_EQ("s<="),
    PLUS("+"),
    MINUS("-"),
    STAR("*"),
    SLASH("/"),
    PERCENT("%"),
    PLUS_EQ("+="),
    MINUS_EQ("-="),
    STAR_EQ("*="),
    SLASH_EQ("/="),
    PERCENT_EQ("%="),
    AND_EQ("&="),
    PIPE_EQ("|="),
    GT_GT_EQ(">>="),
    LT_LT_EQ("<<=");

    public final String text;

    TokenType() {
        this(null);
    }

    TokenType(String text) {
        this.text = text;
    }
}
