# this file defines block 2 of a MINTIA partition.
#
# Loads /OSLoader.bin from an AisixFS volume. If it exists, loads /OSLoader.txt as well and passes it as the command line.
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

#define AFS_MAGIC 0xafbbafbb
#define AFS_VERSION 6

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

#define INode_type 0
#define INode_permissions 4
#define INode_uid 8
#define INode_iparent 12
#define INode_timestamp 16
#define INode_startblock 20
#define INode_bytesize 28

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
    mov $BootHeader, %sp
    ljmp $0, $1f
1:  sti

    # Initialize I/O
    xchg %dx, %cx
    call IOInit

    # Verify block size
    cmpw $512, (IOBlockSize)
    jne .LinvalidBlockSize

    # Read superblock
    # Can't use CacheLoad here because no block has been loaded into the cache yet.
    mov $DiskBlockBuffer, %bx
    xor %ax, %ax
    xor %dx, %dx
    mov $1, %cx
    push %es
    push %bx
    callw *(IORead)
    pop %bx
    pop %es

    # Verify filesystem
    cmpw $(AFS_VERSION & 0xffff), %es:Superblock_Version(%bx)
    jne .LinvalidFs
    cmpw $(AFS_VERSION >> 16), %es:(Superblock_Version + 2)(%bx)
    jne .LinvalidFs
    cmpw $(AFS_MAGIC & 0xffff), %es:Superblock_Magic(%bx)
    jne .LinvalidFs
    cmpw $(AFS_MAGIC >> 16), %es:(Superblock_Magic + 2)(%bx)
    jne .LinvalidFs

    # Save the FAT start block number
    mov %es:Superblock_FATStart(%bx), %bp
    mov %es:(Superblock_FATStart + 2)(%bx), %di

    # Load the first block of the inode table
    mov %es:Superblock_IStart(%bx), %ax
    mov %es:(Superblock_IStart + 2)(%bx), %dx
    mov %ax, (IStart)
    mov %dx, (IStart + 2)
    push %es
    push %bx
    push %di
    call CacheLoad
    pop %di
    pop %bx
    pop %es

    # Look in the root directory for the files we want
    mov %es:(32 + INode_startblock)(%bx), %ax
    mov %es:(32 + INode_startblock + 2)(%bx), %dx
    push %bx
.Lsearchloop:
    cmp $-1, %ax
    jne 1f
    cmp $-1, %dx
    je .Lsearchdone
1:
    mov $LOAD_ADDRESS, %bx

    push %es
    push %bx
    push %ax
    push %dx
    push %di
    mov $1, %cx
    callw *(IORead)
    pop %di
    pop %dx
    pop %ax
    pop %bx
    pop %es

.Lsearchone:
    cmpw $0, %es:DirEnt_INum(%bx)
    jne 1f
    cmpw $0, %es:(DirEnt_INum + 2)(%bx)
    je .Lsearchnext
1:
    push %di
    lea DirEnt_Name(%bx), %di
    mov $LoaderName, %si
    mov $.LloaderNameLen, %cx
    repe cmpsb
    pop %di
    mov $LoaderInode, %si
    je .LhaveInode

    push %di
    lea DirEnt_Name(%bx), %di
    mov $ConfigName, %si
    mov $.LconfigNameLen, %cx
    repe cmpsb
    pop %di
    mov $ConfigInode, %si
    jne .Lsearchnext
.LhaveInode:
    mov %es:DirEnt_INum(%bx), %cx
    mov %cx, (%si)
    mov %es:(DirEnt_INum + 2)(%bx), %cx
    mov %cx, 2(%si)

.Lsearchnext:
    add $64, %bx
    test $511, %bx
    jne .Lsearchone

    push %es
    push %di
    call NextBlock
    pop %di
    pop %es
    jmp .Lsearchloop
.Lsearchdone:
    pop %bx

    # Load the actual inodes
    mov $LoaderInode, %si
    cmpw $0, (%si)
    jne 1f
    cmpw $0, 2(%si)
    je .LnotFound
1:  push %es
    push %bx
    push %di
    call LoadInode
    pop %di
    pop %bx
    pop %es

    mov $ConfigInode, %si
    cmpw $0, (%si)
    jne 1f
    cmpw $0, 2(%si)
    je 2f
1:  push %di
    call LoadInode
    pop %di
2:
    # Make sure we have enough memory to load the image
    int $0x12
    mov $1024, %cx
    mul %cx
    sub $LOAD_ADDRESS, %ax
    sbb $0, %dx
    cmp (LoaderInode), %ax
    sbb (LoaderInode + 2), %dx
    jc .LnoMemory

    # Get the first block number in the FAT chain
    mov (LoaderInode + 4), %ax
    mov (LoaderInode + 6), %dx

    # Iterate the FAT chain until we see a 0xFFFFFFFF (-1) and load OSLoader.bin
    # starting at LOAD_ADDRESS.
    mov $LOAD_ADDRESS, %bx

.Lloadloop:
    cmp $-1, %ax
    jne 1f
    cmp $-1, %dx
    je .Lloaded
1:
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
    jmp .Lloadloop
.Lloaded:

    # Check for the magic number
    cmpw $(LOAD_MAGIC & 0xffff), (LOAD_ADDRESS)
    jne .LinvalidLoader
    cmpw $(LOAD_MAGIC >> 16), (LOAD_ADDRESS + 2)
    jne .LinvalidLoader

    # Load the config if present
    # We only load the first block because the protocol documents a maximum of 255 bytes (excluding null terminator)
    xor %si, %si
    cmpw $0, (ConfigInode)
    jne 1f
    cmpw $0, (ConfigInode + 2)
    je 2f
1:  push %ds
    pop %es
    mov $DiskBlockBuffer, %bx
    mov (ConfigInode + 4), %ax
    mov (ConfigInode + 6), %dx
    call CacheLoad
    mov $DiskBlockBuffer, %si
    movb $0, 255(%si) # limit the command line
2:
    # Load the remaining arguments
    mov (IOBase), %ax
    mov (IOBase + 2), %dx
    mov (IODrive), %cl

    # Jump to the entrypoint
    jmpw *(LOAD_ADDRESS + 4)
.size _start, . - _start

# [in] es:bx = buffer
# [in] dx:ax = block number
# clobbers: ax, bx, cx, dx, si, di, es
.type CacheLoad, @function
CacheLoad:
    cmp %ax, (CurrentBlock)
    jne 1f
    cmp %dx, (CurrentBlock + 2)
    je 2f
1:  mov $1, %cx
    callw *(IORead)
2:  ret
.size CacheLoad, . - CacheLoad

# [inout] dx:ax = block number
# [in] di:bp = fat start
# clobbers: bx, cx, si, di
.type NextBlock, @function
NextBlock:
    xor %bx, %bx
    mov %bx, %es
    mov $DiskBlockBuffer, %bx

    # We have to get the next block number in the chain.
    mov $128, %cx
    mov %ax, %si
    mov %dx, %ax
    xor %dx, %dx
    div %cx
    xchg %ax, %si
    div %cx
    xchg %dx, %si

    add %bp, %ax
    adc %di, %dx
    push %es
    push %bx
    push %si
    call CacheLoad
    pop %si
    pop %bx
    pop %es

    shl %si
    shl %si
    mov %es:(%bx,%si), %ax
    mov %es:2(%bx,%si), %dx
    ret
.size NextBlock, . - NextBlock

# [in] es:bx = block buffer
# [in] si = inode data buffer
# clobbers: ax, cx, dx, si, di
.type LoadInode, @function
LoadInode:
    push %si
    # multiply inode number by inode size to get byte offset into inode table
    mov (%si), %ax
    mov 2(%si), %di
    mov $32, %cx
    mul %cx
    xchg %ax, %di
    mov %dx, %si
    mul %cx
    add %si, %ax
    # ax:di = byte offset into inode table
    # divide by block size to get block offset into inode table and byte offset into block
    xor %dx, %dx
    divw (IOBlockSize)
    xchg %ax, %di
    divw (IOBlockSize)
    xchg %dx, %di
    # dx:ax = block offset into inode table, di = byte offset into block
    add (IStart), %ax
    adc (IStart + 2), %dx
    # load block containing inode
    push %es
    push %bx
    push %di
    call CacheLoad
    pop %di
    pop %bx
    pop %es
    # verify it's a file inode
    cmpw $1, %es:INode_type(%bx,%di)
    jne .LnotFile
    cmpw $0, %es:(INode_type + 2)(%bx,%di)
    jne .LnotFile
    # copy data into output
    pop %si
    mov %es:INode_bytesize(%bx,%di), %ax
    mov %es:(INode_bytesize + 2)(%bx,%di), %dx
    mov %es:INode_startblock(%bx,%di), %cx
    mov %es:(INode_startblock + 2)(%bx, %di), %di
    mov %ax, (%si)
    mov %dx, 2(%si)
    mov %cx, 4(%si)
    mov %di, 6(%si)
    # return
    ret
.size LoadInode, . - LoadInode

.type LoadError, @function
LoadError:
.LinvalidBlockSize:
    mov $InvalidBlockSizeMessage, %si
    jmp Error
.LioReadFailed:
    mov $ReadFailedMessage, %si
    jmp Error
.LinvalidFs:
    mov $InvalidFsMessage, %si
    jmp Error
.LnotFound:
    mov $NotFoundMessage, %si
    jmp Error
.LnotFile:
    mov $NotFileMessage, %si
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

.type InvalidFsMessage, @object
InvalidFsMessage: .asciz "\r\nInvalid filesystem."
.size InvalidFsMessage, . - InvalidFsMessage

.type NotFoundMessage, @object
NotFoundMessage: .asciz "\r\nOSLoader.bin not found."
.size NotFoundMessage, . - NotFoundMessage

.type NotFileMessage, @object
NotFileMessage: .asciz "\r\nNot a file."
.size NotFileMessage, . - NotFileMessage

.type NoMemoryMessage, @object
NoMemoryMessage: .asciz "\r\nNot enough memory."
.size NoMemoryMessage, . - NoMemoryMessage

.type InvalidLoaderMessage, @object
InvalidLoaderMessage: .asciz "\r\nUnknown file format."
.size InvalidLoaderMessage, . - InvalidLoaderMessage

.type LoaderName, @object
LoaderName: .asciz "OSLoader.bin"
.set .LloaderNameLen, . - LoaderName
.size LoaderName, . - LoaderName

.type ConfigName, @object
ConfigName: .asciz "OSLoader.txt"
.set .LconfigNameLen, . - ConfigName
.size ConfigName, . - ConfigName

.type IStart, @function
IStart: .long 0
.size IStart, . - IStart

.type CurrentBlock, @object
CurrentBlock: .long 0
.size CurrentBlock, . - CurrentBlock

.type LoaderInode, @object
LoaderInode: .long 0, 0
.size LoaderInode, . - LoaderInode

.type ConfigInode, @object
ConfigInode: .long 0, 0
.size ConfigInode, . - ConfigInode

.Lend:

.bss

.type DiskBlockBuffer, @object
DiskBlockBuffer: .space 512
.size DiskBlockBuffer, . - DiskBlockBuffer
