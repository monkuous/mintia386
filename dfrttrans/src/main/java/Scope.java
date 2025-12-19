import java.util.LinkedHashMap;
import java.util.Map;

public class Scope {
    public final Scope parent;
    protected final Map<String, ProtoDefinition> definitions = new LinkedHashMap<>();

    public Scope(Scope parent) {
        this.parent = parent;
    }

    public ProtoDefinition addOrReplace(ProtoDefinition definition) {
        return definitions.put(definition.name.text(), definition);
    }

    public void add(ProtoDefinition definition) {
        if (addOrReplace(definition) != null) {
            definition.name.error("symbol '%s' is already defined in this scope".formatted(definition.name.text()));
        }
    }

    public ProtoDefinition resolve(String name) {
        for (var scope = this; scope != null; scope = scope.parent) {
            var definition = scope.definitions.get(name);

            if (definition != null) return definition;
        }

        return null;
    }
}
