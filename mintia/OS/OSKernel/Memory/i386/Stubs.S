.section "text", "ax", %progbits

.globl MiPageDirectoryAlloc
MiPageDirectoryAlloc:
    int3
.globl MiPTECreate
MiPTECreate:
    int3
.globl MiPTESet
MiPTESet:
    int3
.globl MiPTEUpdateByVirtual
MiPTEUpdateByVirtual:
    int3
.globl MiPageDirectoryDestroy
MiPageDirectoryDestroy:
    int3
.globl MmVirtualtoPTEAddressUser
MmVirtualtoPTEAddressUser:
    int3
.globl MiPageDirectoryReference
MiPageDirectoryReference:
    int3
.globl MiPageDirectoryDereference
MiPageDirectoryDereference:
    int3
.globl MiPTEIsZero
MiPTEIsZero:
    int3
.globl MiPTEInterpret
MiPTEInterpret:
    int3
.globl MmVirtualtoPTEAddress
MmVirtualtoPTEAddress:
    int3
.globl MmVirtualToPFDBE
MmVirtualToPFDBE:
    int3
.globl MmVirtualAddressIsValid
MmVirtualAddressIsValid:
    int3
.globl MiPTESetDirty
MiPTESetDirty:
    int3
.globl MiPlatformInit
MiPlatformInit:
    int3
.globl MiPTEPin
MiPTEPin:
    int3
.globl MiPTEUnpin
MiPTEUnpin:
    int3
.globl MmVirtualtoPTEAddressWithFail
MmVirtualtoPTEAddressWithFail:
    int3
.globl MiPTEDelete
MiPTEDelete:
    int3
.globl MiPTEUpdate
MiPTEUpdate:
    int3
.globl MiPTEInitializePageTable
MiPTEInitializePageTable:
    int3
.globl MmVirtualToPhysical
MmVirtualToPhysical:
    int3
