.section "text", "ax", %progbits

.globl LdrPlatformMapRange
LdrPlatformMapRange:
    int3
.globl LdrPlatformBootDriversLoadAll
LdrPlatformBootDriversLoadAll:
    int3
.globl LdrPlatformVirtualToPhysical
LdrPlatformVirtualToPhysical:
    int3
.globl LdrPlatformStartSystem
LdrPlatformStartSystem:
    int3
.globl LdrPlatformIOInit
LdrPlatformIOInit:
    int3

.section "bss", "aw", %progbits

.globl LdrPlatformKernelPageDirectory
LdrPlatformKernelPageDirectory:
    .long 0xabcdef02

