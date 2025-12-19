# this file defines block 2 of a MINTIA partition.
#
# it is very dumb and only understands how to load /OSLoader.sys from an
# AisixFS volume. assumes OSLoader.bin is inode number 2.
# =========== BOOT PROGRAM ============

.code16
.arch i8086

#include "BootDefs.S"

.globl LoadBase
.set LoadBase, BOOT_ADDRESS

.section ".bcode", "ax", %progbits

.type BootHeader, @object
BootHeader:
.Lmagic: .long BOOT_MAGIC
.Lsize: .word .Lend - BootHeader
.Lentry: .word _start
.Lname: .asciz "MINTIA"
.size BootHeader, . - BootHeader

#define Superblock_Version 0
#define Superblock_Magic 4
#define Superblock_Dirty 8
#define Superblock_ReservedBlocks 12
#define Superblock_FATStart 16
#define Superblock_FATSize 20
#define Superblock_IStart 24
#define Superblock_ICount 28
#define Superblock_DataStart 32
#define Superblock_DataSize 36
#define Superblock_VolSize 40

#define DirEnt_INum 0
#define DirEnt_Name 4

#define INode_type 64
#define INode_permissions 68
#define INode_uid 72
#define INode_iparent 76
#define INode_timestamp 80
#define INode_startblock 84
#define INode_bytesize 92

# [in] dx:ax = boot volume sector
# [in] cl = boot drive id
.globl _start
.type _start, @function
_start:
    # Ensure we're running with the right segment registers
    cli
    cld
    xor %bx, %bx
    mov %bx, %ds
    mov %bx, %es
    mov %bx, %ss
    mov $_start, %sp
    ljmp $0, $1f
1:  sti

    # Initialize I/O
    xchg %dx, %cx
    call IOInit

    # Verify block size
    cmpw $512, (IOBlockSize)
    jne .LinvalidBlockSize

    # Read superblock
    mov $DiskBlockBuffer, %bx
    xor %ax, %ax
    xor %dx, %dx
    mov $1, %cx
    push %es
    push %bx
    callw *(IORead)
    pop %bx
    pop %es

    # Save the FAT start block number
    mov %es:Superblock_FATStart(%bx), %bp
    mov %es:(Superblock_FATStart + 2)(%bx), %di

    # Load the first block of the inode table
    mov %es:Superblock_IStart(%bx), %ax
    mov %es:(Superblock_IStart + 2)(%bx), %dx
    mov $1, %cx
    push %es
    push %bx
    push %di
    callw *(IORead)
    pop %di
    pop %bx
    pop %es

    # Check the type number of inode 2 (should be nonzero)
    cmpw $0, %es:INode_type(%bx)
    jne 1f
    cmpw $0, %es:(INode_type + 2)(%bx)
    je .LnotFound
1:
    # Make sure we have enough memory to load the file
    int $0x12
    mov $1024, %cx
    mul %cx
    sub $LOAD_ADDRESS, %ax
    sbb $0, %dx
    cmp %es:INode_bytesize(%bx), %ax
    sbb %es:(INode_bytesize + 2)(%bx), %dx
    jc .LnoMemory

    # Get the first block number in the FAT chain
    mov %es:INode_startblock(%bx), %ax
    mov %es:(INode_startblock + 2)(%bx), %dx

    # Iterate the FAT chain until we see a 0xFFFFFFFF (-1) and load OSLoader.bin
    # starting at LOAD_ADDRESS.
    mov $LOAD_ADDRESS, %bx

.Lloadloop:

    # Load this block of the file
    push %ax
    push %dx
    push %di
    mov $1, %cx
    callw *(IORead)
    pop %di
    pop %dx
    pop %ax

    push %es
    push %bx
    push %di
    call NextBlock
    pop %di
    pop %bx
    pop %es

    cmp $-1, %ax
    jne .Lloadloop
    cmp $-1, %dx
    jne .Lloadloop

    # Check for the magic number
    cmpw $(LOAD_MAGIC & 0xffff), (LOAD_ADDRESS)
    jne .LinvalidLoader
    cmpw $(LOAD_MAGIC >> 16), (LOAD_ADDRESS + 2)
    jne .LinvalidLoader

    # Reload the arguments so we can chain-load OSLoader.bin which just uses
    # the same boot protocol.
    mov (IOBase), %ax
    mov (IOBase + 2), %dx
    mov (IODrive), %cl

    # Jump to the entrypoint
    jmpw *(LOAD_ADDRESS + 4)
.size _start, . - _start

# [inout] dx:ax = block number
# [in] di:bp = fat start
# clobbers: bx, cx, si, di
.type NextBlock, @function
NextBlock:
    xor %bx, %bx
    mov %bx, %es
    mov $DiskBlockBuffer, %bx

    # We have to get the next block number in the chain; if the FAT block we need
    # is already loaded, then skip over that.
    mov $128, %cx
    mov %ax, %si
    mov %dx, %ax
    xor %dx, %dx
    div %cx
    xchg %ax, %si
    div %cx
    xchg %dx, %si

    cmp %ax, (CurrentBlock)
    jne 1f
    cmp %dx, (CurrentBlock + 2)
    je .LskipFatLoad
1:
    # Not already loaded, load that FAT block
    mov %ax, (CurrentBlock)
    mov %dx, (CurrentBlock + 2)

    add %bp, %ax
    adc %di, %dx

    push %es
    push %bx
    push %si
    mov $1, %cx
    callw *(IORead)
    pop %si
    pop %bx
    pop %es

.LskipFatLoad:
    shl %si
    shl %si
    mov %es:(%bx,%si), %ax
    mov %es:2(%bx,%si), %dx
    ret
.size NextBlock, . - NextBlock

.type LoadError, @function
LoadError:
.LinvalidBlockSize:
    mov $InvalidBlockSizeMessage, %si
    jmp Error
.LioReadFailed:
    mov $ReadFailedMessage, %si
    jmp Error
.LnotFound:
    mov $NotFoundMessage, %si
    jmp Error
.LnoMemory:
    mov $NoMemoryMessage, %si
    jmp Error
.LinvalidLoader:
    mov $InvalidLoaderMessage, %si
    jmp Error
.size LoadError, . - LoadError

#include "LibPrint.S"
#include "LibIO.S"

.type InvalidBlockSizeMessage, @object
InvalidBlockSizeMessage: .asciz "\r\nUnsupported disk block size."
.size InvalidBlockSizeMessage, . - InvalidBlockSizeMessage

.type ReadFailedMessage, @object
ReadFailedMessage: .asciz "\r\nFailed to read from disk."
.size ReadFailedMessage, . - ReadFailedMessage

.type NotFoundMessage, @object
NotFoundMessage: .asciz "\r\nOSLoader.bin not found."
.size NotFoundMessage, . - NotFoundMessage

.type NoMemoryMessage, @object
NoMemoryMessage: .asciz "\r\nNot enough memory."
.size NoMemoryMessage, . - NoMemoryMessage

.type InvalidLoaderMessage, @object
InvalidLoaderMessage: .asciz "\r\nUnknown file format."
.size InvalidLoaderMessage, . - InvalidLoaderMessage

.type CurrentBlock, @object
CurrentBlock: .long 0
.size CurrentBlock, . - CurrentBlock

.Lend:

.bss

.type DiskBlockBuffer, @object
DiskBlockBuffer: .space 512
.size DiskBlockBuffer, . - DiskBlockBuffer
