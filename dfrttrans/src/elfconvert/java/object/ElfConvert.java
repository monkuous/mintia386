package object;

import java.io.IOException;

public class ElfConvert {
    public static void main(String[] args) throws IOException {
        if (args.length != 2) {
            System.err.println("usage: elfconvert INPUT OUTPUT");
            System.exit(2);
        }

        ObjectFile object = ObjectFile.loadElf(args[0]);
        object.writeXloff(args[1]);
    }
}
