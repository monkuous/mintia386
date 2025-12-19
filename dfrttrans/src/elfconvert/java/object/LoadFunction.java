package object;

import java.io.IOException;

public interface LoadFunction<T> {
    T load(LittleEndian.Input input) throws IOException;
}
