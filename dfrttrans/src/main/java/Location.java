public record Location(String path, int line, int column) {
    public void error(String message) {
        System.out.printf("%s:%d:%d: %s%n", path, line, column, message);
        Main.errors += 1;
    }
}
