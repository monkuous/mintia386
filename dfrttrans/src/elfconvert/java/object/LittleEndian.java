package object;

import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;

public class LittleEndian {
    private static int bswap16(int value) {
        return ((value >>> 8) & 0xff) | ((value << 8) & 0xff00);
    }

    private static int bswap32(int value) {
        return ((value >>> 24) & 0xff) | ((value >>> 8) & 0xff00) | ((value << 8) & 0xff0000) | (value << 24);
    }

    public static class Input {
        private final DataInput input;

        public Input(DataInput input) {
            this.input = input;
        }

        public byte[] readBytes(int count) throws IOException {
            byte[] data = new byte[count];
            input.readFully(data);
            return data;
        }

        public int read8() throws IOException {
            return input.readUnsignedByte();
        }

        public int read16() throws IOException {
            return bswap16(input.readUnsignedShort());
        }

        public int read32() throws IOException {
            return bswap32(input.readInt());
        }
    }

    public static class Output {
        private final DataOutput output;

        public Output(DataOutput output) {
            this.output = output;
        }

        public void writeBytes(byte[] data) throws IOException {
            output.write(data);
        }

        public void write8(int value) throws IOException {
            output.write(value);
        }

        public void write16(int value) throws IOException {
            output.writeShort(bswap16(value));
        }

        public void write32(int value) throws IOException {
            output.writeInt(bswap32(value));
        }
    }
}
