# AUTOMATICALLY GENERATED -- DO NOT EDIT

.section "text", "ax", %progbits

.globl OSConsolePutCharacter
.type OSConsolePutCharacter, @function
OSConsolePutCharacter:
	mov 4(%esp), %edx

	mov $1, %eax
	int $0x30

	ret
.size OSConsolePutCharacter, . - OSConsolePutCharacter

.globl OSSystemAbort
.type OSSystemAbort, @function
OSSystemAbort:
	sub $4, %esp
	mov %esi, 0(%esp)

	mov 8(%esp), %edx
	mov 12(%esp), %ecx
	mov 16(%esp), %esi

	mov $2, %eax
	int $0x30

	mov 0(%esp), %esi
	add $4, %esp
	ret
.size OSSystemAbort, . - OSSystemAbort

.globl OSGetBootFlags
.type OSGetBootFlags, @function
OSGetBootFlags:
	mov $3, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSGetBootFlags, . - OSGetBootFlags

.globl OSContinue
.type OSContinue, @function
OSContinue:
	sub $4, %esp
	mov %esi, 0(%esp)

	mov 8(%esp), %edx
	mov 12(%esp), %ecx
	mov 16(%esp), %esi

	mov $4, %eax
	int $0x30

	mov 0(%esp), %esi
	add $4, %esp
	ret
.size OSContinue, . - OSContinue

.globl OSQueryTime
.type OSQueryTime, @function
OSQueryTime:
	mov $5, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSQueryTime, . - OSQueryTime

.globl OSQueryUptime
.type OSQueryUptime, @function
OSQueryUptime:
	mov $6, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSQueryUptime, . - OSQueryUptime

.globl OSTimeZoneGet
.type OSTimeZoneGet, @function
OSTimeZoneGet:
	mov $7, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSTimeZoneGet, . - OSTimeZoneGet

.globl OSTimeZoneSet
.type OSTimeZoneSet, @function
OSTimeZoneSet:
	mov 8(%esp), %edx

	mov $8, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSTimeZoneSet, . - OSTimeZoneSet

.globl OSTimeSet
.type OSTimeSet, @function
OSTimeSet:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $9, %eax
	int $0x30

	ret
.size OSTimeSet, . - OSTimeSet

.globl OSShutdownSystem
.type OSShutdownSystem, @function
OSShutdownSystem:
	mov 4(%esp), %edx

	mov $10, %eax
	int $0x30

	ret
.size OSShutdownSystem, . - OSShutdownSystem

.globl OSVersion
.type OSVersion, @function
OSVersion:
	mov 4(%esp), %edx

	mov $11, %eax
	int $0x30

	ret
.size OSVersion, . - OSVersion

.globl OSEventCreate
.type OSEventCreate, @function
OSEventCreate:
	sub $8, %esp
	mov %esi, 0(%esp)
	mov %edi, 4(%esp)

	mov 16(%esp), %edx
	mov 20(%esp), %ecx
	mov 24(%esp), %esi
	mov 28(%esp), %edi

	mov $12, %eax
	int $0x30

	mov 12(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	mov 0(%esp), %esi
	mov 4(%esp), %edi
	add $8, %esp
	ret $4
.size OSEventCreate, . - OSEventCreate

.globl OSEventReset
.type OSEventReset, @function
OSEventReset:
	mov 8(%esp), %edx

	mov $13, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSEventReset, . - OSEventReset

.globl OSEventSignal
.type OSEventSignal, @function
OSEventSignal:
	mov 4(%esp), %edx

	mov $14, %eax
	int $0x30

	ret
.size OSEventSignal, . - OSEventSignal

.globl OSEventPulse
.type OSEventPulse, @function
OSEventPulse:
	mov 4(%esp), %edx

	mov $15, %eax
	int $0x30

	ret
.size OSEventPulse, . - OSEventPulse

.globl OSEventReadState
.type OSEventReadState, @function
OSEventReadState:
	mov 8(%esp), %edx

	mov $16, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSEventReadState, . - OSEventReadState

.globl OSSemaphoreCreate
.type OSSemaphoreCreate, @function
OSSemaphoreCreate:
	sub $4, %esp
	mov %esi, 0(%esp)

	mov 12(%esp), %edx
	mov 16(%esp), %ecx
	mov 20(%esp), %esi

	mov $17, %eax
	int $0x30

	mov 8(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	mov 0(%esp), %esi
	add $4, %esp
	ret $4
.size OSSemaphoreCreate, . - OSSemaphoreCreate

.globl OSSemaphoreRelease
.type OSSemaphoreRelease, @function
OSSemaphoreRelease:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $18, %eax
	int $0x30

	ret
.size OSSemaphoreRelease, . - OSSemaphoreRelease

.globl OSSemaphoreReadState
.type OSSemaphoreReadState, @function
OSSemaphoreReadState:
	mov 8(%esp), %edx

	mov $19, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSSemaphoreReadState, . - OSSemaphoreReadState

.globl OSMutexCreate
.type OSMutexCreate, @function
OSMutexCreate:
	mov 8(%esp), %edx
	mov 12(%esp), %ecx

	mov $20, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSMutexCreate, . - OSMutexCreate

.globl OSMutexRelease
.type OSMutexRelease, @function
OSMutexRelease:
	mov 4(%esp), %edx

	mov $21, %eax
	int $0x30

	ret
.size OSMutexRelease, . - OSMutexRelease

.globl OSMutexReadState
.type OSMutexReadState, @function
OSMutexReadState:
	mov 8(%esp), %edx

	mov $22, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSMutexReadState, . - OSMutexReadState

.globl OSTimerCreate
.type OSTimerCreate, @function
OSTimerCreate:
	mov 8(%esp), %edx
	mov 12(%esp), %ecx

	mov $23, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSTimerCreate, . - OSTimerCreate

.globl OSTimerReset
.type OSTimerReset, @function
OSTimerReset:
	mov 8(%esp), %edx

	mov $24, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSTimerReset, . - OSTimerReset

.globl OSTimerEnqueue
.type OSTimerEnqueue, @function
OSTimerEnqueue:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $25, %eax
	int $0x30

	ret
.size OSTimerEnqueue, . - OSTimerEnqueue

.globl OSTimerDequeue
.type OSTimerDequeue, @function
OSTimerDequeue:
	mov 4(%esp), %edx

	mov $26, %eax
	int $0x30

	ret
.size OSTimerDequeue, . - OSTimerDequeue

.globl OSTimerReadState
.type OSTimerReadState, @function
OSTimerReadState:
	mov 8(%esp), %edx

	mov $27, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSTimerReadState, . - OSTimerReadState

.globl OSGetStatistics
.type OSGetStatistics, @function
OSGetStatistics:
	mov 4(%esp), %edx

	mov $28, %eax
	int $0x30

	ret
.size OSGetStatistics, . - OSGetStatistics

.globl OSNvramVariableQuery
.type OSNvramVariableQuery, @function
OSNvramVariableQuery:
	mov 4(%esp), %edx

	mov $29, %eax
	int $0x30

	ret
.size OSNvramVariableQuery, . - OSNvramVariableQuery

.globl OSNvramVariableSet
.type OSNvramVariableSet, @function
OSNvramVariableSet:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $30, %eax
	int $0x30

	ret
.size OSNvramVariableSet, . - OSNvramVariableSet

.globl OSNvramVariableRead
.type OSNvramVariableRead, @function
OSNvramVariableRead:
	mov 8(%esp), %edx
	mov 12(%esp), %ecx

	mov $31, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSNvramVariableRead, . - OSNvramVariableRead

.globl OSIsComputerOn
.type OSIsComputerOn, @function
OSIsComputerOn:
	mov $32, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSIsComputerOn, . - OSIsComputerOn

.globl OSIsComputerOnFire
.type OSIsComputerOnFire, @function
OSIsComputerOnFire:
	mov $33, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSIsComputerOnFire, . - OSIsComputerOnFire

.globl OSOpenRelative
.type OSOpenRelative, @function
OSOpenRelative:
	sub $16, %esp
	mov %esi, 0(%esp)
	mov %edi, 4(%esp)
	mov %ebx, 8(%esp)
	mov %ebp, 12(%esp)

	mov 24(%esp), %edx
	mov 28(%esp), %ecx
	mov 32(%esp), %esi
	mov 36(%esp), %edi
	mov 40(%esp), %ebx
	mov 44(%esp), %ebp

	mov $34, %eax
	int $0x30

	mov 20(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	mov 0(%esp), %esi
	mov 4(%esp), %edi
	mov 8(%esp), %ebx
	mov 12(%esp), %ebp
	add $16, %esp
	ret $4
.size OSOpenRelative, . - OSOpenRelative

.globl OSClose
.type OSClose, @function
OSClose:
	mov 4(%esp), %edx

	mov $35, %eax
	int $0x30

	ret
.size OSClose, . - OSClose

.globl OSQuery
.type OSQuery, @function
OSQuery:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $36, %eax
	int $0x30

	ret
.size OSQuery, . - OSQuery

.globl OSWaitForMultipleObjects
.type OSWaitForMultipleObjects, @function
OSWaitForMultipleObjects:
	sub $12, %esp
	mov %esi, 0(%esp)
	mov %edi, 4(%esp)
	mov %ebx, 8(%esp)

	mov 16(%esp), %edx
	mov 20(%esp), %ecx
	mov 24(%esp), %esi
	mov 28(%esp), %edi
	mov 32(%esp), %ebx

	mov $37, %eax
	int $0x30

	mov 0(%esp), %esi
	mov 4(%esp), %edi
	mov 8(%esp), %ebx
	add $12, %esp
	ret
.size OSWaitForMultipleObjects, . - OSWaitForMultipleObjects

.globl OSWaitForObject
.type OSWaitForObject, @function
OSWaitForObject:
	sub $4, %esp
	mov %esi, 0(%esp)

	mov 8(%esp), %edx
	mov 12(%esp), %ecx
	mov 16(%esp), %esi

	mov $38, %eax
	int $0x30

	mov 0(%esp), %esi
	add $4, %esp
	ret
.size OSWaitForObject, . - OSWaitForObject

.globl OSHandleDuplicate
.type OSHandleDuplicate, @function
OSHandleDuplicate:
	sub $8, %esp
	mov %esi, 0(%esp)
	mov %edi, 4(%esp)

	mov 16(%esp), %edx
	mov 20(%esp), %ecx
	mov 24(%esp), %esi
	mov 28(%esp), %edi

	mov $39, %eax
	int $0x30

	mov 12(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	mov 0(%esp), %esi
	mov 4(%esp), %edi
	add $8, %esp
	ret $4
.size OSHandleDuplicate, . - OSHandleDuplicate

.globl OSObjectDirectoryCountQuery
.type OSObjectDirectoryCountQuery, @function
OSObjectDirectoryCountQuery:
	mov 8(%esp), %edx

	mov $40, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSObjectDirectoryCountQuery, . - OSObjectDirectoryCountQuery

.globl OSObjectDirectoryQueryAll
.type OSObjectDirectoryQueryAll, @function
OSObjectDirectoryQueryAll:
	sub $4, %esp
	mov %esi, 0(%esp)

	mov 12(%esp), %edx
	mov 16(%esp), %ecx
	mov 20(%esp), %esi

	mov $41, %eax
	int $0x30

	mov 8(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	mov 0(%esp), %esi
	add $4, %esp
	ret $4
.size OSObjectDirectoryQueryAll, . - OSObjectDirectoryQueryAll

.globl OSObjectDirectoryCreate
.type OSObjectDirectoryCreate, @function
OSObjectDirectoryCreate:
	mov 8(%esp), %edx
	mov 12(%esp), %ecx

	mov $42, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSObjectDirectoryCreate, . - OSObjectDirectoryCreate

.globl OSObjectDirectoryInsert
.type OSObjectDirectoryInsert, @function
OSObjectDirectoryInsert:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $43, %eax
	int $0x30

	ret
.size OSObjectDirectoryInsert, . - OSObjectDirectoryInsert

.globl OSObjectDirectoryRemove
.type OSObjectDirectoryRemove, @function
OSObjectDirectoryRemove:
	mov 4(%esp), %edx

	mov $44, %eax
	int $0x30

	ret
.size OSObjectDirectoryRemove, . - OSObjectDirectoryRemove

.globl OSSetSecurity
.type OSSetSecurity, @function
OSSetSecurity:
	sub $8, %esp
	mov %esi, 0(%esp)
	mov %edi, 4(%esp)

	mov 12(%esp), %edx
	mov 16(%esp), %ecx
	mov 20(%esp), %esi
	mov 24(%esp), %edi

	mov $45, %eax
	int $0x30

	mov 0(%esp), %esi
	mov 4(%esp), %edi
	add $8, %esp
	ret
.size OSSetSecurity, . - OSSetSecurity

.globl SysCreateRelative
.type SysCreateRelative, @function
SysCreateRelative:
	sub $16, %esp
	mov %esi, 0(%esp)
	mov %edi, 4(%esp)
	mov %ebx, 8(%esp)
	mov %ebp, 12(%esp)

	mov 24(%esp), %edx
	mov 28(%esp), %ecx
	mov 32(%esp), %esi
	mov 36(%esp), %edi
	mov 40(%esp), %ebx
	mov 44(%esp), %ebp

	mov $46, %eax
	int $0x30

	mov 20(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	mov 0(%esp), %esi
	mov 4(%esp), %edi
	mov 8(%esp), %ebx
	mov 12(%esp), %ebp
	add $16, %esp
	ret $4
.size SysCreateRelative, . - SysCreateRelative

.globl OSFileQuery
.type OSFileQuery, @function
OSFileQuery:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $47, %eax
	int $0x30

	ret
.size OSFileQuery, . - OSFileQuery

.globl OSFileTruncate
.type OSFileTruncate, @function
OSFileTruncate:
	sub $4, %esp
	mov %esi, 0(%esp)

	mov 12(%esp), %edx
	mov 16(%esp), %ecx
	mov 20(%esp), %esi

	mov $48, %eax
	int $0x30

	mov 8(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	mov 0(%esp), %esi
	add $4, %esp
	ret $4
.size OSFileTruncate, . - OSFileTruncate

.globl OSFileSeek
.type OSFileSeek, @function
OSFileSeek:
	sub $4, %esp
	mov %esi, 0(%esp)

	mov 12(%esp), %edx
	mov 16(%esp), %ecx
	mov 20(%esp), %esi

	mov $49, %eax
	int $0x30

	mov 8(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	mov 0(%esp), %esi
	add $4, %esp
	ret $4
.size OSFileSeek, . - OSFileSeek

.globl OSFileRead
.type OSFileRead, @function
OSFileRead:
	sub $12, %esp
	mov %esi, 0(%esp)
	mov %edi, 4(%esp)
	mov %ebx, 8(%esp)

	mov 20(%esp), %edx
	mov 24(%esp), %ecx
	mov 28(%esp), %esi
	mov 32(%esp), %edi
	mov 36(%esp), %ebx

	mov $50, %eax
	int $0x30

	mov 16(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	mov 0(%esp), %esi
	mov 4(%esp), %edi
	mov 8(%esp), %ebx
	add $12, %esp
	ret $4
.size OSFileRead, . - OSFileRead

.globl OSFileWrite
.type OSFileWrite, @function
OSFileWrite:
	sub $8, %esp
	mov %esi, 0(%esp)
	mov %edi, 4(%esp)

	mov 16(%esp), %edx
	mov 20(%esp), %ecx
	mov 24(%esp), %esi
	mov 28(%esp), %edi

	mov $51, %eax
	int $0x30

	mov 12(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	mov 0(%esp), %esi
	mov 4(%esp), %edi
	add $8, %esp
	ret $4
.size OSFileWrite, . - OSFileWrite

.globl OSFileFlush
.type OSFileFlush, @function
OSFileFlush:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $52, %eax
	int $0x30

	ret
.size OSFileFlush, . - OSFileFlush

.globl OSFileSetInformation
.type OSFileSetInformation, @function
OSFileSetInformation:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $53, %eax
	int $0x30

	ret
.size OSFileSetInformation, . - OSFileSetInformation

.globl OSFileReadAsync
.type OSFileReadAsync, @function
OSFileReadAsync:
	sub $16, %esp
	mov %esi, 0(%esp)
	mov %edi, 4(%esp)
	mov %ebx, 8(%esp)
	mov %ebp, 12(%esp)

	mov 20(%esp), %edx
	mov 24(%esp), %ecx
	mov 28(%esp), %esi
	mov 32(%esp), %edi
	mov 36(%esp), %ebx
	mov 40(%esp), %ebp

	mov $54, %eax
	int $0x30

	mov 0(%esp), %esi
	mov 4(%esp), %edi
	mov 8(%esp), %ebx
	mov 12(%esp), %ebp
	add $16, %esp
	ret
.size OSFileReadAsync, . - OSFileReadAsync

.globl OSFileWriteAsync
.type OSFileWriteAsync, @function
OSFileWriteAsync:
	sub $16, %esp
	mov %esi, 0(%esp)
	mov %edi, 4(%esp)
	mov %ebx, 8(%esp)
	mov %ebp, 12(%esp)

	mov 20(%esp), %edx
	mov 24(%esp), %ecx
	mov 28(%esp), %esi
	mov 32(%esp), %edi
	mov 36(%esp), %ebx
	mov 40(%esp), %ebp

	mov $55, %eax
	int $0x30

	mov 0(%esp), %esi
	mov 4(%esp), %edi
	mov 8(%esp), %ebx
	mov 12(%esp), %ebp
	add $16, %esp
	ret
.size OSFileWriteAsync, . - OSFileWriteAsync

.globl OSFileCancelIO
.type OSFileCancelIO, @function
OSFileCancelIO:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $56, %eax
	int $0x30

	ret
.size OSFileCancelIO, . - OSFileCancelIO

.globl OSDirectoryRename
.type OSDirectoryRename, @function
OSDirectoryRename:
	sub $8, %esp
	mov %esi, 0(%esp)
	mov %edi, 4(%esp)

	mov 12(%esp), %edx
	mov 16(%esp), %ecx
	mov 20(%esp), %esi
	mov 24(%esp), %edi

	mov $57, %eax
	int $0x30

	mov 0(%esp), %esi
	mov 4(%esp), %edi
	add $8, %esp
	ret
.size OSDirectoryRename, . - OSDirectoryRename

.globl OSDirectoryUnlink
.type OSDirectoryUnlink, @function
OSDirectoryUnlink:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $58, %eax
	int $0x30

	ret
.size OSDirectoryUnlink, . - OSDirectoryUnlink

.globl OSDirectoryRead
.type OSDirectoryRead, @function
OSDirectoryRead:
	sub $4, %esp
	mov %esi, 0(%esp)

	mov 12(%esp), %edx
	mov 16(%esp), %ecx
	mov 20(%esp), %esi

	mov $59, %eax
	int $0x30

	mov 8(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	mov 0(%esp), %esi
	add $4, %esp
	ret $4
.size OSDirectoryRead, . - OSDirectoryRead

.globl OSPageFileCreateRelative
.type OSPageFileCreateRelative, @function
OSPageFileCreateRelative:
	sub $12, %esp
	mov %esi, 0(%esp)
	mov %edi, 4(%esp)
	mov %ebx, 8(%esp)

	mov 16(%esp), %edx
	mov 20(%esp), %ecx
	mov 24(%esp), %esi
	mov 28(%esp), %edi
	mov 32(%esp), %ebx

	mov $60, %eax
	int $0x30

	mov 0(%esp), %esi
	mov 4(%esp), %edi
	mov 8(%esp), %ebx
	add $12, %esp
	ret
.size OSPageFileCreateRelative, . - OSPageFileCreateRelative

.globl OSPageFileQuery
.type OSPageFileQuery, @function
OSPageFileQuery:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $61, %eax
	int $0x30

	ret
.size OSPageFileQuery, . - OSPageFileQuery

.globl OSIOControl
.type OSIOControl, @function
OSIOControl:
	sub $4, %esp
	mov %esi, 0(%esp)

	mov 12(%esp), %edx
	mov 16(%esp), %ecx
	mov 20(%esp), %esi

	mov $62, %eax
	int $0x30

	mov 8(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	mov 0(%esp), %esi
	add $4, %esp
	ret $4
.size OSIOControl, . - OSIOControl

.globl OSGetBootDevicePath
.type OSGetBootDevicePath, @function
OSGetBootDevicePath:
	mov 4(%esp), %edx

	mov $63, %eax
	int $0x30

	ret
.size OSGetBootDevicePath, . - OSGetBootDevicePath

.globl OSFilesystemMount
.type OSFilesystemMount, @function
OSFilesystemMount:
	sub $4, %esp
	mov %esi, 0(%esp)

	mov 8(%esp), %edx
	mov 12(%esp), %ecx
	mov 16(%esp), %esi

	mov $64, %eax
	int $0x30

	mov 0(%esp), %esi
	add $4, %esp
	ret
.size OSFilesystemMount, . - OSFilesystemMount

.globl OSFilesystemUnmount
.type OSFilesystemUnmount, @function
OSFilesystemUnmount:
	mov 4(%esp), %edx

	mov $65, %eax
	int $0x30

	ret
.size OSFilesystemUnmount, . - OSFilesystemUnmount

.globl OSMountQueryAll
.type OSMountQueryAll, @function
OSMountQueryAll:
	mov 8(%esp), %edx
	mov 12(%esp), %ecx

	mov $66, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSMountQueryAll, . - OSMountQueryAll

.globl OSMountCountQuery
.type OSMountCountQuery, @function
OSMountCountQuery:
	mov $67, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSMountCountQuery, . - OSMountCountQuery

.globl OSMountUpdateFlags
.type OSMountUpdateFlags, @function
OSMountUpdateFlags:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $68, %eax
	int $0x30

	ret
.size OSMountUpdateFlags, . - OSMountUpdateFlags

.globl OSMountGetFilesystemName
.type OSMountGetFilesystemName, @function
OSMountGetFilesystemName:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $69, %eax
	int $0x30

	ret
.size OSMountGetFilesystemName, . - OSMountGetFilesystemName

.globl OSMountSet
.type OSMountSet, @function
OSMountSet:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $70, %eax
	int $0x30

	ret
.size OSMountSet, . - OSMountSet

.globl OSFlushModifiedPages
.type OSFlushModifiedPages, @function
OSFlushModifiedPages:
	mov $71, %eax
	int $0x30

	ret
.size OSFlushModifiedPages, . - OSFlushModifiedPages

.globl OSSectionCreate
.type OSSectionCreate, @function
OSSectionCreate:
	sub $4, %esp
	mov %esi, 0(%esp)

	mov 12(%esp), %edx
	mov 16(%esp), %ecx
	mov 20(%esp), %esi

	mov $72, %eax
	int $0x30

	mov 8(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	mov 0(%esp), %esi
	add $4, %esp
	ret $4
.size OSSectionCreate, . - OSSectionCreate

.globl OSMapView
.type OSMapView, @function
OSMapView:
	lea 8(%esp), %edx

	mov $73, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSMapView, . - OSMapView

.globl OSUnmapView
.type OSUnmapView, @function
OSUnmapView:
	sub $4, %esp
	mov %esi, 0(%esp)

	mov 8(%esp), %edx
	mov 12(%esp), %ecx
	mov 16(%esp), %esi

	mov $74, %eax
	int $0x30

	mov 0(%esp), %esi
	add $4, %esp
	ret
.size OSUnmapView, . - OSUnmapView

.globl OSRemapView
.type OSRemapView, @function
OSRemapView:
	sub $8, %esp
	mov %esi, 0(%esp)
	mov %edi, 4(%esp)

	mov 12(%esp), %edx
	mov 16(%esp), %ecx
	mov 20(%esp), %esi
	mov 24(%esp), %edi

	mov $75, %eax
	int $0x30

	mov 0(%esp), %esi
	mov 4(%esp), %edi
	add $8, %esp
	ret
.size OSRemapView, . - OSRemapView

.globl OSFlushView
.type OSFlushView, @function
OSFlushView:
	sub $4, %esp
	mov %esi, 0(%esp)

	mov 8(%esp), %edx
	mov 12(%esp), %ecx
	mov 16(%esp), %esi

	mov $76, %eax
	int $0x30

	mov 0(%esp), %esi
	add $4, %esp
	ret
.size OSFlushView, . - OSFlushView

.globl OSAllocate
.type OSAllocate, @function
OSAllocate:
	sub $12, %esp
	mov %esi, 0(%esp)
	mov %edi, 4(%esp)
	mov %ebx, 8(%esp)

	mov 20(%esp), %edx
	mov 24(%esp), %ecx
	mov 28(%esp), %esi
	mov 32(%esp), %edi
	mov 36(%esp), %ebx

	mov $77, %eax
	int $0x30

	mov 16(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	mov 0(%esp), %esi
	mov 4(%esp), %edi
	mov 8(%esp), %ebx
	add $12, %esp
	ret $4
.size OSAllocate, . - OSAllocate

.globl OSMemoryQuery
.type OSMemoryQuery, @function
OSMemoryQuery:
	mov 4(%esp), %edx

	mov $78, %eax
	int $0x30

	ret
.size OSMemoryQuery, . - OSMemoryQuery

.globl OSWorkingSetPurge
.type OSWorkingSetPurge, @function
OSWorkingSetPurge:
	mov $79, %eax
	int $0x30

	ret
.size OSWorkingSetPurge, . - OSWorkingSetPurge

.globl OSSynchronizeIcache
.type OSSynchronizeIcache, @function
OSSynchronizeIcache:
	mov $80, %eax
	int $0x30

	ret
.size OSSynchronizeIcache, . - OSSynchronizeIcache

.globl OSProcessCreate
.type OSProcessCreate, @function
OSProcessCreate:
	sub $12, %esp
	mov %esi, 0(%esp)
	mov %edi, 4(%esp)
	mov %ebx, 8(%esp)

	mov 20(%esp), %edx
	mov 24(%esp), %ecx
	mov 28(%esp), %esi
	mov 32(%esp), %edi
	mov 36(%esp), %ebx

	mov $81, %eax
	int $0x30

	mov 16(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	mov 0(%esp), %esi
	mov 4(%esp), %edi
	mov 8(%esp), %ebx
	add $12, %esp
	ret $4
.size OSProcessCreate, . - OSProcessCreate

.globl OSProcessSignal
.type OSProcessSignal, @function
OSProcessSignal:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $82, %eax
	int $0x30

	ret
.size OSProcessSignal, . - OSProcessSignal

.globl OSProcessOpenByPID
.type OSProcessOpenByPID, @function
OSProcessOpenByPID:
	mov 8(%esp), %edx
	mov 12(%esp), %ecx

	mov $83, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSProcessOpenByPID, . - OSProcessOpenByPID

.globl OSProcessQuery
.type OSProcessQuery, @function
OSProcessQuery:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $84, %eax
	int $0x30

	ret
.size OSProcessQuery, . - OSProcessQuery

.globl OSProcessQueryByPID
.type OSProcessQueryByPID, @function
OSProcessQueryByPID:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $85, %eax
	int $0x30

	ret
.size OSProcessQueryByPID, . - OSProcessQueryByPID

.globl OSProcessReadStatus
.type OSProcessReadStatus, @function
OSProcessReadStatus:
	mov 8(%esp), %edx

	mov $86, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSProcessReadStatus, . - OSProcessReadStatus

.globl OSProcessSetConsoleGroup
.type OSProcessSetConsoleGroup, @function
OSProcessSetConsoleGroup:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $87, %eax
	int $0x30

	ret
.size OSProcessSetConsoleGroup, . - OSProcessSetConsoleGroup

.globl OSProcessBasePrioritySet
.type OSProcessBasePrioritySet, @function
OSProcessBasePrioritySet:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $88, %eax
	int $0x30

	ret
.size OSProcessBasePrioritySet, . - OSProcessBasePrioritySet

.globl OSProcessSignalActivation
.type OSProcessSignalActivation, @function
OSProcessSignalActivation:
	mov 4(%esp), %edx

	mov $89, %eax
	int $0x30

	ret
.size OSProcessSignalActivation, . - OSProcessSignalActivation

.globl OSProcessWaitForActivation
.type OSProcessWaitForActivation, @function
OSProcessWaitForActivation:
	mov 8(%esp), %edx
	mov 12(%esp), %ecx

	mov $90, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSProcessWaitForActivation, . - OSProcessWaitForActivation

.globl OSProcessExit
.type OSProcessExit, @function
OSProcessExit:
	mov 4(%esp), %edx

	mov $91, %eax
	int $0x30

	ret
.size OSProcessExit, . - OSProcessExit

.globl OSProcessCountQuery
.type OSProcessCountQuery, @function
OSProcessCountQuery:
	mov $92, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSProcessCountQuery, . - OSProcessCountQuery

.globl OSProcessQueryAll
.type OSProcessQueryAll, @function
OSProcessQueryAll:
	mov 8(%esp), %edx
	mov 12(%esp), %ecx

	mov $93, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSProcessQueryAll, . - OSProcessQueryAll

.globl OSSetQuota
.type OSSetQuota, @function
OSSetQuota:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $94, %eax
	int $0x30

	ret
.size OSSetQuota, . - OSSetQuota

.globl OSQuotaQuery
.type OSQuotaQuery, @function
OSQuotaQuery:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $95, %eax
	int $0x30

	ret
.size OSQuotaQuery, . - OSQuotaQuery

.globl OSThreadGetExceptionStatus
.type OSThreadGetExceptionStatus, @function
OSThreadGetExceptionStatus:
	mov $96, %eax
	int $0x30

	ret
.size OSThreadGetExceptionStatus, . - OSThreadGetExceptionStatus

.globl OSThreadSleep
.type OSThreadSleep, @function
OSThreadSleep:
	mov 4(%esp), %edx

	mov $97, %eax
	int $0x30

	ret
.size OSThreadSleep, . - OSThreadSleep

.globl OSThreadSleepEx
.type OSThreadSleepEx, @function
OSThreadSleepEx:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $98, %eax
	int $0x30

	ret
.size OSThreadSleepEx, . - OSThreadSleepEx

.globl OSThreadCreate
.type OSThreadCreate, @function
OSThreadCreate:
	sub $16, %esp
	mov %esi, 0(%esp)
	mov %edi, 4(%esp)
	mov %ebx, 8(%esp)
	mov %ebp, 12(%esp)

	mov 24(%esp), %edx
	mov 28(%esp), %ecx
	mov 32(%esp), %esi
	mov 36(%esp), %edi
	mov 40(%esp), %ebx
	mov 44(%esp), %ebp

	mov $99, %eax
	int $0x30

	mov 20(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	mov 0(%esp), %esi
	mov 4(%esp), %edi
	mov 8(%esp), %ebx
	mov 12(%esp), %ebp
	add $16, %esp
	ret $4
.size OSThreadCreate, . - OSThreadCreate

.globl OSThreadTerminate
.type OSThreadTerminate, @function
OSThreadTerminate:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $100, %eax
	int $0x30

	ret
.size OSThreadTerminate, . - OSThreadTerminate

.globl OSThreadSuspend
.type OSThreadSuspend, @function
OSThreadSuspend:
	mov 4(%esp), %edx

	mov $101, %eax
	int $0x30

	ret
.size OSThreadSuspend, . - OSThreadSuspend

.globl OSThreadResume
.type OSThreadResume, @function
OSThreadResume:
	mov 4(%esp), %edx

	mov $102, %eax
	int $0x30

	ret
.size OSThreadResume, . - OSThreadResume

.globl OSThreadReadStatus
.type OSThreadReadStatus, @function
OSThreadReadStatus:
	mov 8(%esp), %edx

	mov $103, %eax
	int $0x30

	mov 4(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	ret $4
.size OSThreadReadStatus, . - OSThreadReadStatus

.globl OSThreadQuery
.type OSThreadQuery, @function
OSThreadQuery:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $104, %eax
	int $0x30

	ret
.size OSThreadQuery, . - OSThreadQuery

.globl OSThreadSignal
.type OSThreadSignal, @function
OSThreadSignal:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $105, %eax
	int $0x30

	ret
.size OSThreadSignal, . - OSThreadSignal

.globl OSThreadMaskSignal
.type OSThreadMaskSignal, @function
OSThreadMaskSignal:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $106, %eax
	int $0x30

	ret
.size OSThreadMaskSignal, . - OSThreadMaskSignal

.globl OSThreadDeliverOnWaitSignal
.type OSThreadDeliverOnWaitSignal, @function
OSThreadDeliverOnWaitSignal:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $107, %eax
	int $0x30

	ret
.size OSThreadDeliverOnWaitSignal, . - OSThreadDeliverOnWaitSignal

.globl OSJobCreate
.type OSJobCreate, @function
OSJobCreate:
	sub $12, %esp
	mov %esi, 0(%esp)
	mov %edi, 4(%esp)
	mov %ebx, 8(%esp)

	mov 20(%esp), %edx
	mov 24(%esp), %ecx
	mov 28(%esp), %esi
	mov 32(%esp), %edi
	mov 36(%esp), %ebx

	mov $108, %eax
	int $0x30

	mov 16(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	mov 0(%esp), %esi
	mov 4(%esp), %edi
	mov 8(%esp), %ebx
	add $12, %esp
	ret $4
.size OSJobCreate, . - OSJobCreate

.globl OSJobAddProcess
.type OSJobAddProcess, @function
OSJobAddProcess:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $109, %eax
	int $0x30

	ret
.size OSJobAddProcess, . - OSJobAddProcess

.globl OSJobRemoveProcess
.type OSJobRemoveProcess, @function
OSJobRemoveProcess:
	mov 4(%esp), %edx

	mov $110, %eax
	int $0x30

	ret
.size OSJobRemoveProcess, . - OSJobRemoveProcess

.globl OSJobSignal
.type OSJobSignal, @function
OSJobSignal:
	sub $4, %esp
	mov %esi, 0(%esp)

	mov 8(%esp), %edx
	mov 12(%esp), %ecx
	mov 16(%esp), %esi

	mov $111, %eax
	int $0x30

	mov 0(%esp), %esi
	add $4, %esp
	ret
.size OSJobSignal, . - OSJobSignal

.globl OSSetSystemConsole
.type OSSetSystemConsole, @function
OSSetSystemConsole:
	mov 4(%esp), %edx

	mov $112, %eax
	int $0x30

	ret
.size OSSetSystemConsole, . - OSSetSystemConsole

.globl OSConsoleSignal
.type OSConsoleSignal, @function
OSConsoleSignal:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $113, %eax
	int $0x30

	ret
.size OSConsoleSignal, . - OSConsoleSignal

.globl OSIsAConsole
.type OSIsAConsole, @function
OSIsAConsole:
	mov 4(%esp), %edx

	mov $114, %eax
	int $0x30

	ret
.size OSIsAConsole, . - OSIsAConsole

.globl OSDuplexCreate
.type OSDuplexCreate, @function
OSDuplexCreate:
	sub $4, %esp
	mov %esi, 0(%esp)

	mov 12(%esp), %edx
	mov 16(%esp), %ecx
	mov 20(%esp), %esi

	mov $115, %eax
	int $0x30

	mov 8(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)
	mov %esi, 8(%eax)

	mov 0(%esp), %esi
	add $4, %esp
	ret $4
.size OSDuplexCreate, . - OSDuplexCreate

.globl OSCheckPermission
.type OSCheckPermission, @function
OSCheckPermission:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $116, %eax
	int $0x30

	ret
.size OSCheckPermission, . - OSCheckPermission

.globl OSGrantPermission
.type OSGrantPermission, @function
OSGrantPermission:
	mov 4(%esp), %edx
	mov 8(%esp), %ecx

	mov $117, %eax
	int $0x30

	ret
.size OSGrantPermission, . - OSGrantPermission

.globl OSPortCreate
.type OSPortCreate, @function
OSPortCreate:
	sub $8, %esp
	mov %esi, 0(%esp)
	mov %edi, 4(%esp)

	mov 16(%esp), %edx
	mov 20(%esp), %ecx
	mov 24(%esp), %esi
	mov 28(%esp), %edi

	mov $118, %eax
	int $0x30

	mov 12(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	mov 0(%esp), %esi
	mov 4(%esp), %edi
	add $8, %esp
	ret $4
.size OSPortCreate, . - OSPortCreate

.globl OSPortConnectRelative
.type OSPortConnectRelative, @function
OSPortConnectRelative:
	sub $12, %esp
	mov %esi, 0(%esp)
	mov %edi, 4(%esp)
	mov %ebx, 8(%esp)

	mov 20(%esp), %edx
	mov 24(%esp), %ecx
	mov 28(%esp), %esi
	mov 32(%esp), %edi
	mov 36(%esp), %ebx

	mov $119, %eax
	int $0x30

	mov 16(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	mov 0(%esp), %esi
	mov 4(%esp), %edi
	mov 8(%esp), %ebx
	add $12, %esp
	ret $4
.size OSPortConnectRelative, . - OSPortConnectRelative

.globl OSPortAccept
.type OSPortAccept, @function
OSPortAccept:
	sub $8, %esp
	mov %esi, 0(%esp)
	mov %edi, 4(%esp)

	mov 12(%esp), %edx
	mov 16(%esp), %ecx
	mov 20(%esp), %esi
	mov 24(%esp), %edi

	mov $120, %eax
	int $0x30

	mov 0(%esp), %esi
	mov 4(%esp), %edi
	add $8, %esp
	ret
.size OSPortAccept, . - OSPortAccept

.globl OSPortSendAndWaitReceive
.type OSPortSendAndWaitReceive, @function
OSPortSendAndWaitReceive:
	sub $8, %esp
	mov %esi, 0(%esp)
	mov %edi, 4(%esp)

	mov 12(%esp), %edx
	mov 16(%esp), %ecx
	mov 20(%esp), %esi
	mov 24(%esp), %edi

	mov $121, %eax
	int $0x30

	mov 0(%esp), %esi
	mov 4(%esp), %edi
	add $8, %esp
	ret
.size OSPortSendAndWaitReceive, . - OSPortSendAndWaitReceive

.globl OSPortSendAndWaitReply
.type OSPortSendAndWaitReply, @function
OSPortSendAndWaitReply:
	sub $8, %esp
	mov %esi, 0(%esp)
	mov %edi, 4(%esp)

	mov 12(%esp), %edx
	mov 16(%esp), %ecx
	mov 20(%esp), %esi
	mov 24(%esp), %edi

	mov $122, %eax
	int $0x30

	mov 0(%esp), %esi
	mov 4(%esp), %edi
	add $8, %esp
	ret
.size OSPortSendAndWaitReply, . - OSPortSendAndWaitReply

.globl OSPortOpenProcessByClientID
.type OSPortOpenProcessByClientID, @function
OSPortOpenProcessByClientID:
	sub $4, %esp
	mov %esi, 0(%esp)

	mov 12(%esp), %edx
	mov 16(%esp), %ecx
	mov 20(%esp), %esi

	mov $123, %eax
	int $0x30

	mov 8(%esp), %eax
	mov %edx, 0(%eax)
	mov %ecx, 4(%eax)

	mov 0(%esp), %esi
	add $4, %esp
	ret $4
.size OSPortOpenProcessByClientID, . - OSPortOpenProcessByClientID
