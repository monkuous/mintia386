import java.io.*;

public class Main {
    public static final int WORD_SIZE = 4;
    public static final int PTR_SIZE = 4;
    public static int errors = 0;

    public static void main(String[] args) throws IOException {
        if (args.length != 2) {
            System.err.println("usage: dfrttrans INPUT OUTPUT");
            System.exit(2);
        }

        ProtoFile proto;

        try (var stream = new BufferedInputStream(new FileInputStream(args[0]))) {
            proto = Parser.parse(stream, args[0]);
        }

        if (errors != 0) System.exit(1);

        AstFile file = proto.convertToAst();

        if (errors != 0) System.exit(1);

        try (var stream = new PrintStream(args[1])) {
            for (var sym : file.symbols()) {
                sym.print(stream);
            }

            for (var def : file.definitions()) {
                stream.printf("__attribute__((section(%s))) ", Utils.escapeString(def.section()));
                def.print(stream);
            }
        }
    }
}
