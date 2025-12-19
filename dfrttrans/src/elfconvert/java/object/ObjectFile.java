package object;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

public record ObjectFile(Machine machine, List<Section> sections, List<Symbol> symbols) {
    public void writeXloff(String path) throws IOException {
        var stringTable = new LinkedHashMap<String, Integer>();
        int headerSize = XloffHeader.SIZE;
        int stringTableSize = 0;
        int sectionTableSize = sections.size() * XloffSection.SIZE;
        int symbolTableSize = symbols.size() * XloffSymbol.SIZE;
        int totalRelocsSize = 0;
        int entrySymbol = -1;

        for (var section : sections) {
            if (!stringTable.containsKey(section.name())) {
                stringTable.put(section.name(), stringTableSize);
                stringTableSize += section.name().getBytes(StandardCharsets.UTF_8).length + 1;
            }

            totalRelocsSize += section.relocations().size() * XloffRelocation.SIZE;
        }

        for (int i = 0, symbolsSize = symbols.size(); i < symbolsSize; i++) {
            var symbol = symbols.get(i);

            if (symbol.name() != null && !stringTable.containsKey(symbol.name())) {
                stringTable.put(symbol.name(), stringTableSize);
                stringTableSize += symbol.name().getBytes(StandardCharsets.UTF_8).length + 1;
            }

            if (symbol.name() != null && symbol.name().equals("_start")) {
                entrySymbol = i;
            }
        }

        int sectionTableOffset = headerSize;
        int symbolTableOffset = sectionTableOffset + sectionTableSize;
        int relocsOffset = symbolTableOffset + symbolTableSize;
        int stringTableOffset = relocsOffset + totalRelocsSize;
        int paddingOffset = stringTableOffset + stringTableSize;
        int dataOffset = (paddingOffset + 3) & -4;
        int paddingSize = dataOffset - paddingOffset;

        var header = new XloffHeader(XloffHeader.MAGIC,
                symbolTableOffset, symbols.size(),
                stringTableOffset, stringTableSize,
                machine.getXloffCode(), entrySymbol, 0, 0,
                sectionTableOffset, sections.size(),
                0, 0,
                dataOffset);

        try (var stream = new DataOutputStream(new BufferedOutputStream(new FileOutputStream(path)))) {
            var output = new LittleEndian.Output(stream);
            header.write(output);

            for (var section : sections) {
                int flags = XloffSection.MAP;

                if (section.data() == null) flags |= XloffSection.BSS;
                if (!section.writable() && !section.executable()) flags |= XloffSection.READONLY;
                if (section.executable()) flags |= XloffSection.TEXT;

                var xloff = new XloffSection(stringTable.get(section.name()), dataOffset, section.size(),
                        section.address(), relocsOffset, section.relocations().size(), flags);
                xloff.write(output);

                if (section.data() != null) dataOffset += section.size();
                relocsOffset += section.relocations().size() * XloffRelocation.SIZE;
            }

            for (var symbol : symbols) {
                int nameOffset = symbol.name() != null ? stringTable.get(symbol.name()) : -1;
                int section = symbol.section() != null ? symbol.section().index() : -1;
                int type = switch (symbol.type()) {
                    case GLOBAL -> XloffSymbol.GLOBAL;
                    case LOCAL -> XloffSymbol.LOCAL;
                    case EXTERN -> XloffSymbol.EXTERN;
                    case SPECIAL -> XloffSymbol.SPECIAL;
                };

                var xloff = new XloffSymbol(nameOffset, symbol.value(), section, type, 0);
                xloff.write(output);
            }

            for (var section : sections) {
                for (var reloc : section.relocations()) {
                    var xloff = new XloffRelocation(reloc.offset(), reloc.symbol().index(), reloc.addend(), reloc.type(), section.index());
                    xloff.write(output);
                }
            }

            for (var str : stringTable.keySet()) {
                output.writeBytes(str.getBytes(StandardCharsets.UTF_8));
                output.write8(0);
            }

            if (paddingSize != 0) {
                output.writeBytes(new byte[paddingSize]);
            }

            for (var section : sections) {
                if (section.data() != null) {
                    output.writeBytes(section.data());
                }
            }
        }
    }

    public static ObjectFile loadElf(String path) throws IOException {
        ObjectFile object;
        Section textSection = null;
        Section dataSection = null;
        Section bssSection = null;
        var specialSymbols = new HashMap<String, Symbol>();

        try (var file = new RandomAccessFile(path, "r")) {
            var input = new LittleEndian.Input(file);
            var header = new ElfHeader(input);

            if (header.type() != ElfHeader.ET_REL) {
                throw new IllegalArgumentException("not a relocatable object");
            }

            var machine = Machine.getFromElfCode(header.machine());

            object = new ObjectFile(machine, new ArrayList<>(), new ArrayList<>());

            var elfSections = new ElfSection[header.sectionCount()];

            for (var i = 0; i < elfSections.length; i++) {
                file.seek(header.sectionsOffset() + (long) i * header.sectionSize());
                elfSections[i] = new ElfSection(input);
            }

            var sectionNameData = loadData(elfSections[header.sectionNamesSection()], file);

            var sectionMap = new Section[header.sectionCount()];
            var sectionOffsets = new int[header.sectionCount()];
            ElfSection symbolTable = null;
            int symbolTableIndex = -1;
            var relocSections = new ArrayList<ElfSection>();

            for (var i = 0; i < elfSections.length; i++) {
                var elfSection = elfSections[i];

                switch (elfSection.type()) {
                    case ElfSection.SHT_PROGBITS, ElfSection.SHT_NOBITS -> {
                        if ((elfSection.flags() & ElfSection.SHF_ALLOC) == 0 || elfSection.size() <= 0) continue;

                        byte[] data;
                        int size = (elfSection.size() + 3) & -4;

                        if (elfSection.type() != ElfSection.SHT_NOBITS) {
                            data = new byte[size];
                            file.seek(elfSection.offset());
                            file.readFully(data);
                        } else {
                            data = null;
                        }

                        var name = new String(sectionNameData, elfSection.name(), stringLength(sectionNameData, elfSection.name()), StandardCharsets.UTF_8)
                                .intern();

                        var executable = (elfSection.flags() & ElfSection.SHF_EXECINSTR) != 0;
                        var writable = (elfSection.flags() & ElfSection.SHF_WRITE) != 0;
                        Section section = null;
                        int offset = 0;

                        if (name.equals(".text") || name.startsWith(".text.") || name.equals(".rodata") || name.startsWith(".rodata.")) {
                            name = "text";

                            if (textSection != null) section = textSection;
                        } else if (name.equals(".data") || name.startsWith(".data.")) {
                            name = "data";

                            if (dataSection != null) section = dataSection;
                        } else if (name.equals(".bss") || name.startsWith(".bss.")) {
                            name = "bss";

                            if (bssSection != null) section = bssSection;
                        }

                        if (name.endsWith("text")) {
                            executable = true;
                            writable = false;
                            if (data == null) data = new byte[size];
                        }

                        if (name.endsWith("data")) {
                            executable = false;
                            writable = true;
                            if (data == null) data = new byte[size];
                        }

                        if (name.endsWith("bss")) {
                            executable = false;
                            writable = true;
                            data = null;
                        }

                        if (section == null) {
                            section = new Section(
                                    name,
                                    elfSection.address(),
                                    size,
                                    data,
                                    writable,
                                    executable,
                                    new ArrayList<>(),
                                    object.sections().size(),
                                    object
                            );

                            object.sections().add(section);
                            specialSymbols.put(section.startSym.name(), section.startSym);
                            specialSymbols.put(section.sizeSym.name(), section.sizeSym);
                            specialSymbols.put(section.endSym.name(), section.endSym);

                            switch (name) {
                                case "text" -> textSection = section;
                                case "data" -> dataSection = section;
                                case "bss" -> bssSection = section;
                            }
                        } else {
                            offset = section.size();

                            if (elfSection.addressAlignment() != 0) {
                                offset = (offset + elfSection.addressAlignment() - 1) & -elfSection.addressAlignment();
                            }

                            int newSize = offset + size;
                            byte[] newData = null;

                            if (section.data() != null) {
                                newData = new byte[newSize];
                                System.arraycopy(section.data(), 0, newData, 0, section.size());
                                if (data != null) System.arraycopy(data, 0, newData, offset, size);
                            }

                            section.setData(newSize, newData);
                        }

                        sectionMap[i] = section;
                        sectionOffsets[i] = offset;
                    }
                    case ElfSection.SHT_SYMTAB -> {
                        if (symbolTable != null) throw new IllegalArgumentException("multiple symbol tables");
                        symbolTable = elfSection;
                        symbolTableIndex = i;
                    }
                    case ElfSection.SHT_REL, ElfSection.SHT_RELA -> relocSections.add(elfSection);
                }
            }

            if (textSection == null) {
                var section = new Section("text", 0, 0, new byte[0], false, true, new ArrayList<>(), object.sections().size(), object);
                object.sections().add(section);
                specialSymbols.put(section.startSym.name(), section.startSym);
                specialSymbols.put(section.sizeSym.name(), section.sizeSym);
                specialSymbols.put(section.endSym.name(), section.endSym);
            }

            if (dataSection == null) {
                var section = new Section("data", 0, 0, new byte[0], true, false, new ArrayList<>(), object.sections().size(), object);
                object.sections().add(section);
                specialSymbols.put(section.startSym.name(), section.startSym);
                specialSymbols.put(section.sizeSym.name(), section.sizeSym);
                specialSymbols.put(section.endSym.name(), section.endSym);
            }

            if (bssSection == null) {
                var section = new Section("bss", 0, 0, null, true, false, new ArrayList<>(), object.sections().size(), object);
                object.sections().add(section);
                specialSymbols.put(section.startSym.name(), section.startSym);
                specialSymbols.put(section.sizeSym.name(), section.sizeSym);
                specialSymbols.put(section.endSym.name(), section.endSym);
            }

            Symbol[] symbolMap;

            if (symbolTable != null) {
                symbolMap = new Symbol[symbolTable.size() / symbolTable.entrySize()];
                var symbolNameData = loadData(elfSections[symbolTable.link()], file);

                for (var i = 0; i < symbolMap.length; i++) {
                    file.seek(symbolTable.offset() + (long) i * symbolTable.entrySize());
                    var elfSymbol = new ElfSymbol(input);

                    Symbol.Type type;
                    Section section;
                    int offset;

                    if (elfSymbol.section() == ElfSection.SHN_UNDEF) {
                        if (elfSymbol.bind() == ElfSymbol.STB_LOCAL) continue;

                        type = Symbol.Type.EXTERN;
                        section = null;
                        offset = 0;
                    } else if (elfSymbol.section() != ElfSection.SHN_ABS) {
                        if (elfSymbol.bind() == ElfSymbol.STB_LOCAL) {
                            type = Symbol.Type.LOCAL;
                        } else {
                            type = Symbol.Type.GLOBAL;
                        }

                        section = sectionMap[elfSymbol.section()];
                        if (section == null) continue;
                        offset = sectionOffsets[elfSymbol.section()];
                    } else {
                        continue;
                    }

                    var name = new String(symbolNameData, elfSymbol.name(), stringLength(symbolNameData, elfSymbol.name()), StandardCharsets.UTF_8)
                            .intern();

                    Symbol symbol = specialSymbols.get(name);

                    if (symbol == null) {
                        if (elfSymbol.name() == 0 || type == Symbol.Type.LOCAL) name = null;

                        symbol = new Symbol(name, elfSymbol.value() + offset, section, type, object.symbols().size());
                        object.symbols().add(symbol);
                    } else if (type != Symbol.Type.EXTERN) {
                        throw new IllegalArgumentException("tried to redefine special symbol");
                    }

                    symbolMap[i] = symbol;
                }
            } else {
                symbolMap = new Symbol[0];
            }

            for (var relocSection : relocSections) {
                var section = sectionMap[relocSection.info()];
                var offset = sectionOffsets[relocSection.info()];
                if (section == null) continue;
                if (relocSection.link() != symbolTableIndex) {
                    throw new IllegalArgumentException("relocs refer to wrong symbol table");
                }

                LoadFunction<? extends ElfRelocationBase> loadFunc = (relocSection.type() == ElfSection.SHT_RELA)
                        ? ElfRelocationWithAddend::new : ElfRelocation::new;
                var numRelocs = relocSection.size() / relocSection.entrySize();

                for (var i = 0; i < numRelocs; i++) {
                    file.seek(relocSection.offset() + (long) i * relocSection.entrySize());

                    var reloc = loadFunc.load(input);
                    var symbol = symbolMap[reloc.symbol()];
                    if (symbol == null) throw new IllegalArgumentException("no symbol for relocation");

                    section.relocations().add(new Relocation(reloc.offset() + offset, symbol, reloc.addend(section.data(), offset, machine), machine.translateElfRelocType(reloc.type())));
                }
            }
        }

        return object;
    }

    private static byte[] loadData(ElfSection section, RandomAccessFile file) throws IOException {
        file.seek(section.offset());
        var data = new byte[section.size()];
        file.readFully(data);
        return data;
    }

    private static int stringLength(byte[] data, int offset) {
        int length = 0;
        while (data[offset + length] != 0) length += 1;
        return length;
    }
}
