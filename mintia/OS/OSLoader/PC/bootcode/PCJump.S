.code16
.arch i8086

#include "BootDefs.S"

.globl LoadBase
.set LoadBase, 0x1000

.section ".bcode", "ax", %progbits

.globl _start
.type _start, @function
_start:
    jmp LoadInit
.size _start, . - _start

#define APT_MAGIC 0x4e4d494d
#define APT_PARTITIONS 8

.org 15
.type PartitionTable, @object
PartitionTable:
.LffIfVariant:  .byte 0
.Lpartitions:   .fill APT_PARTITIONS * 16, 1, 0
.Lmagic:        .long 0
.Llabel:        .fill 8, 1, 0
.org 164
.size PartitionTable, . - PartitionTable

#define Partition_Label 0
#define Partition_SectorCount 8
#define Partition_Status 12

#define BootHeader_Magic 0
#define BootHeader_Size 4
#define BootHeader_Entry 6
#define BootHeader_Name 8

#define BootOption_Size 0
#define BootOption_Entry 2
#define BootOption_Sector 4

.type LoadInit, @function
LoadInit:
    # Ensure we're running at the correct address
    cli
    cld
    xor %ax, %ax
    mov %ax, %ds
    mov %ax, %es
    mov %ax, %ss
    mov $_start, %sp
    mov $0x7c00, %si
    mov %sp, %di
    mov $0x100, %cx
    rep movsw
    ljmp $0, $1f
1:  sti

    # Read rest of PCJump.bin using CHS
    mov $5, %si
.LtryRead:
    mov $0x203, %ax
    mov $2, %cx
    xor %dh, %dh
    mov $0x1200, %bx
    push %dx
    stc
    int $0x13
    sti
    pop %dx
    jnc .LreadOk
    dec %si
    jz .LioReadFailed
    xor %ax, %ax
    int $0x13
    jmp .LtryRead
.LreadOk:

    # Initialize I/O library
    xor %ax, %ax
    xor %cx, %cx
    call IOInit

    # Verify partition table
    cmpw $(APT_MAGIC & 0xffff), (.Lmagic)
    jne .LinvalidTable
    cmpw $(APT_MAGIC >> 16), (.Lmagic + 2)
    jne .LinvalidTable

    # Create list of bootable partitions
    mov $4, %ax
    xor %dx, %dx
    mov $.Lpartitions, %si
    mov $BootOptions, %di
    mov $APT_PARTITIONS, %cx
    xor %bp, %bp
.LcheckPartition:
    # Check if partition slot is occupied
    cmpw $0, Partition_Status(%si)
    jne 1f
    cmpw $0, (Partition_Status + 2)(%si)
    je .LnextPartition

1:  # Check if partition is large enough to contain a boot record
    mov $1, %bx
    cmp Partition_SectorCount(%si), %bx
    mov $0, %bx
    cmp (Partition_SectorCount + 2)(%si), %bx
    jnc .LadvancePartition

    # Load potential boot record
    push %es
    push %dx
    push %ax
    push %cx
    push %si
    push %di
    mov $BOOT_ADDRESS, %bx
    add $1, %ax
    adc $0, %dx
    mov $1, %cx
    callw *(IORead)
    pop %di
    pop %si
    pop %cx
    pop %ax
    pop %dx
    pop %es

    # Check magic number
    cmpw $(BOOT_MAGIC & 0xffff), (BOOT_ADDRESS + BootHeader_Magic)
    jne .LadvancePartition
    cmpw $(BOOT_MAGIC >> 16), (BOOT_ADDRESS + BootHeader_Magic + 2)
    jne .LadvancePartition

    # Register boot option
    mov (BOOT_ADDRESS + BootHeader_Size), %bx
    mov %bx, BootOption_Size(%di)
    mov (BOOT_ADDRESS + BootHeader_Entry), %bx
    mov %bx, BootOption_Entry(%di)
    mov %ax, BootOption_Sector(%di)
    mov %dx, (BootOption_Sector + 2)(%di)
    inc %bp
    add $16, %di

    # Print boot option
    push %si
    mov $BootOptionHeader, %si
    incb (.LbootOptionIndex)
    call Message
    mov $(BOOT_ADDRESS + BootHeader_Name), %si
    call Message
    pop %si

.LadvancePartition:
    add Partition_SectorCount(%si), %ax
    adc (Partition_SectorCount + 2)(%si), %dx
.LnextPartition:
    add $16, %si
    loop .LcheckPartition

    jmp ProcessBootOptions
.size LoadInit, . - LoadInit

.type LoadError, @function
LoadError:
.LnoPartitions:
    mov $NoPartitionsMessage, %si
    jmp Error
.LinvalidTable:
    mov $InvalidTableMessage, %si
    jmp Error
.LioReadFailed:
    mov $ReadFailedMessage, %si
    jmp Error
.LnoMemory:
    mov $NoMemoryMessage, %si
    jmp Error
.size LoadError, . - LoadError

#include "LibPrint.S"

.type ReadFailedMessage, @object
ReadFailedMessage: .asciz "\r\nFailed to read from disk."
.size ReadFailedMessage, . - ReadFailedMessage

.org 510
.type BootSig, @object
BootSig: .word 0xaa55
.size BootSig, . - BootSig

#include "LibIO.S"

.type ProcessBootOptions, @function
ProcessBootOptions:
    test %bp, %bp
    jz .LnoPartitions

    mov $BootPrompt, %si
    call Message

    # Allow user to force the boot prompt by holding shift
    mov $2, %ah
    int $0x16
    test $3, %al
    jnz .LselectOption

    cmp $1, %bp
    je .LoptionSelected

.LselectOption:
    # Wait until the user inputs a valid digit
    xor %ax, %ax
    int $0x16
    cmp $0x30, %al
    jbe .LselectOption
    mov %bp, %dx
    add $0x30, %dx
    cmp %dl, %al
    ja .LselectOption
    xor %ah, %ah
    mov %ax, %bp
    sub $0x30, %bp

.LoptionSelected:
    # Tell user which option was selected
    mov $BootSelectedMessage, %si
    mov %bp, %ax
    add %al, (%si)
    call Message

    # Get pointer to option data
    dec %bp
    mov $4, %cl
    shl %cl, %bp
    add $BootOptions, %bp

    # Check whether we have enough memory
    int $0x12
    mov (%bp), %dx
    add $1023, %dx
    mov $10, %cl
    shr %cl, %dx
    add $(BOOT_ADDRESS / 1024), %dx
    cmp %ax, %dx
    ja .LnoMemory

    # Convert image size to blocks
    mov (%bp), %ax
    xor %dx, %dx
    divw (IOBlockSize)
    test %dx, %dx
    jz 1f
    inc %ax
1:  mov %ax, %cx

    # Load image
    mov $BOOT_ADDRESS, %bx
    mov BootOption_Sector(%bp), %ax
    mov (BootOption_Sector + 2)(%bp), %dx
    add $1, %ax
    adc $0, %dx
    callw *(IORead)

    mov BootOption_Sector(%bp), %ax
    mov (BootOption_Sector + 2)(%bp), %dx
    mov (IODrive), %cl
    jmpw *BootOption_Entry(%bp)
.size ProcessBootOptions, . - ProcessBootOptions

.type InvalidTableMessage, @object
InvalidTableMessage: .asciz "\r\nInvalid partition table."
.size InvalidTableMessage, . - InvalidTableMessage

.type NoPartitionsMessage, @object
NoPartitionsMessage: .asciz "\r\nNo bootable partitions."
.size NoPartitionsMessage, . - NoPartitionsMessage

.type NoMemoryMessage, @object
NoMemoryMessage: .asciz "\r\nNot enough memory."
.size NoMemoryMessage, . - NoMemoryMessage

.type BootOptionHeader, @object
BootOptionHeader:
    .ascii "\r\n["
.LbootOptionIndex:
    .asciz "0] "
.size BootOptionHeader, . - BootOptionHeader

.type BootPrompt, @object
BootPrompt: .asciz "\r\n\r\nSelect an operating system to boot: "
.size BootPrompt, . - BootPrompt

.type BootSelectedMessage, @object
BootSelectedMessage: .asciz "0\r\nLoading operating system...\r\n"
.size BootSelectedMessage, . - BootSelectedMessage

.type BootOptions, @object
BootOptions: .fill 16 * 8, 1, 0
.size BootOptions, . - BootOptions

.org 2048
