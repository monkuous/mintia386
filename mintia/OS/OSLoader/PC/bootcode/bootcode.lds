ENTRY(_start)

SECTIONS {
    .bcode LoadBase : { KEEP(*(.bcode)) }
    .bss : { *(.bss .bss.*) }

    /DISCARD/ : { *(.note .note.*) }
}
