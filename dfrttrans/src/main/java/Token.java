public record Token(TokenType type, String text, Location location) {
    public void error(String message) {
        location.error(message);
    }
}
