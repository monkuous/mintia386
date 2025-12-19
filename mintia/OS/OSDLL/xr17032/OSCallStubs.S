# AUTOMATICALLY GENERATED -- DO NOT EDIT

.section "text", "ax", %progbits

.globl OSConsolePutCharacter
.type OSConsolePutCharacter, @function
OSConsolePutCharacter:
	add  t1, a0, zero

	addi  t0, zero, 1
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSConsolePutCharacter, . - OSConsolePutCharacter

.globl OSSystemAbort
.type OSSystemAbort, @function
OSSystemAbort:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero

	addi  t0, zero, 2
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSSystemAbort, . - OSSystemAbort

.globl OSGetBootFlags
.type OSGetBootFlags, @function
OSGetBootFlags:

	addi  t0, zero, 3
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSGetBootFlags, . - OSGetBootFlags

.globl OSContinue
.type OSContinue, @function
OSContinue:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero

	addi  t0, zero, 4
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSContinue, . - OSContinue

.globl OSQueryTime
.type OSQueryTime, @function
OSQueryTime:

	addi  t0, zero, 5
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSQueryTime, . - OSQueryTime

.globl OSQueryUptime
.type OSQueryUptime, @function
OSQueryUptime:

	addi  t0, zero, 6
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSQueryUptime, . - OSQueryUptime

.globl OSTimeZoneGet
.type OSTimeZoneGet, @function
OSTimeZoneGet:

	addi  t0, zero, 7
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSTimeZoneGet, . - OSTimeZoneGet

.globl OSTimeZoneSet
.type OSTimeZoneSet, @function
OSTimeZoneSet:
	add  t1, a0, zero

	addi  t0, zero, 8
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSTimeZoneSet, . - OSTimeZoneSet

.globl OSTimeSet
.type OSTimeSet, @function
OSTimeSet:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 9
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSTimeSet, . - OSTimeSet

.globl OSShutdownSystem
.type OSShutdownSystem, @function
OSShutdownSystem:
	add  t1, a0, zero

	addi  t0, zero, 10
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSShutdownSystem, . - OSShutdownSystem

.globl OSVersion
.type OSVersion, @function
OSVersion:
	add  t1, a0, zero

	addi  t0, zero, 11
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSVersion, . - OSVersion

.globl OSEventCreate
.type OSEventCreate, @function
OSEventCreate:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero

	addi  t0, zero, 12
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSEventCreate, . - OSEventCreate

.globl OSEventReset
.type OSEventReset, @function
OSEventReset:
	add  t1, a0, zero

	addi  t0, zero, 13
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSEventReset, . - OSEventReset

.globl OSEventSignal
.type OSEventSignal, @function
OSEventSignal:
	add  t1, a0, zero

	addi  t0, zero, 14
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSEventSignal, . - OSEventSignal

.globl OSEventPulse
.type OSEventPulse, @function
OSEventPulse:
	add  t1, a0, zero

	addi  t0, zero, 15
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSEventPulse, . - OSEventPulse

.globl OSEventReadState
.type OSEventReadState, @function
OSEventReadState:
	add  t1, a0, zero

	addi  t0, zero, 16
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSEventReadState, . - OSEventReadState

.globl OSSemaphoreCreate
.type OSSemaphoreCreate, @function
OSSemaphoreCreate:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero

	addi  t0, zero, 17
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSSemaphoreCreate, . - OSSemaphoreCreate

.globl OSSemaphoreRelease
.type OSSemaphoreRelease, @function
OSSemaphoreRelease:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 18
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSSemaphoreRelease, . - OSSemaphoreRelease

.globl OSSemaphoreReadState
.type OSSemaphoreReadState, @function
OSSemaphoreReadState:
	add  t1, a0, zero

	addi  t0, zero, 19
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSSemaphoreReadState, . - OSSemaphoreReadState

.globl OSMutexCreate
.type OSMutexCreate, @function
OSMutexCreate:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 20
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSMutexCreate, . - OSMutexCreate

.globl OSMutexRelease
.type OSMutexRelease, @function
OSMutexRelease:
	add  t1, a0, zero

	addi  t0, zero, 21
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSMutexRelease, . - OSMutexRelease

.globl OSMutexReadState
.type OSMutexReadState, @function
OSMutexReadState:
	add  t1, a0, zero

	addi  t0, zero, 22
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSMutexReadState, . - OSMutexReadState

.globl OSTimerCreate
.type OSTimerCreate, @function
OSTimerCreate:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 23
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSTimerCreate, . - OSTimerCreate

.globl OSTimerReset
.type OSTimerReset, @function
OSTimerReset:
	add  t1, a0, zero

	addi  t0, zero, 24
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSTimerReset, . - OSTimerReset

.globl OSTimerEnqueue
.type OSTimerEnqueue, @function
OSTimerEnqueue:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 25
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSTimerEnqueue, . - OSTimerEnqueue

.globl OSTimerDequeue
.type OSTimerDequeue, @function
OSTimerDequeue:
	add  t1, a0, zero

	addi  t0, zero, 26
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSTimerDequeue, . - OSTimerDequeue

.globl OSTimerReadState
.type OSTimerReadState, @function
OSTimerReadState:
	add  t1, a0, zero

	addi  t0, zero, 27
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSTimerReadState, . - OSTimerReadState

.globl OSGetStatistics
.type OSGetStatistics, @function
OSGetStatistics:
	add  t1, a0, zero

	addi  t0, zero, 28
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSGetStatistics, . - OSGetStatistics

.globl OSNvramVariableQuery
.type OSNvramVariableQuery, @function
OSNvramVariableQuery:
	add  t1, a0, zero

	addi  t0, zero, 29
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSNvramVariableQuery, . - OSNvramVariableQuery

.globl OSNvramVariableSet
.type OSNvramVariableSet, @function
OSNvramVariableSet:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 30
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSNvramVariableSet, . - OSNvramVariableSet

.globl OSNvramVariableRead
.type OSNvramVariableRead, @function
OSNvramVariableRead:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 31
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSNvramVariableRead, . - OSNvramVariableRead

.globl OSIsComputerOn
.type OSIsComputerOn, @function
OSIsComputerOn:

	addi  t0, zero, 32
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSIsComputerOn, . - OSIsComputerOn

.globl OSIsComputerOnFire
.type OSIsComputerOnFire, @function
OSIsComputerOnFire:

	addi  t0, zero, 33
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSIsComputerOnFire, . - OSIsComputerOnFire

.globl OSOpenRelative
.type OSOpenRelative, @function
OSOpenRelative:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero
	mov  t5, long [sp + 0]
	mov  a0, long [sp + 4]

	addi  t0, zero, 34
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSOpenRelative, . - OSOpenRelative

.globl OSClose
.type OSClose, @function
OSClose:
	add  t1, a0, zero

	addi  t0, zero, 35
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSClose, . - OSClose

.globl OSQuery
.type OSQuery, @function
OSQuery:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 36
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSQuery, . - OSQuery

.globl OSWaitForMultipleObjects
.type OSWaitForMultipleObjects, @function
OSWaitForMultipleObjects:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero
	mov  t5, long [sp + 0]

	addi  t0, zero, 37
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSWaitForMultipleObjects, . - OSWaitForMultipleObjects

.globl OSWaitForObject
.type OSWaitForObject, @function
OSWaitForObject:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero

	addi  t0, zero, 38
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSWaitForObject, . - OSWaitForObject

.globl OSHandleDuplicate
.type OSHandleDuplicate, @function
OSHandleDuplicate:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero

	addi  t0, zero, 39
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSHandleDuplicate, . - OSHandleDuplicate

.globl OSObjectDirectoryCountQuery
.type OSObjectDirectoryCountQuery, @function
OSObjectDirectoryCountQuery:
	add  t1, a0, zero

	addi  t0, zero, 40
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSObjectDirectoryCountQuery, . - OSObjectDirectoryCountQuery

.globl OSObjectDirectoryQueryAll
.type OSObjectDirectoryQueryAll, @function
OSObjectDirectoryQueryAll:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero

	addi  t0, zero, 41
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSObjectDirectoryQueryAll, . - OSObjectDirectoryQueryAll

.globl OSObjectDirectoryCreate
.type OSObjectDirectoryCreate, @function
OSObjectDirectoryCreate:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 42
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSObjectDirectoryCreate, . - OSObjectDirectoryCreate

.globl OSObjectDirectoryInsert
.type OSObjectDirectoryInsert, @function
OSObjectDirectoryInsert:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 43
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSObjectDirectoryInsert, . - OSObjectDirectoryInsert

.globl OSObjectDirectoryRemove
.type OSObjectDirectoryRemove, @function
OSObjectDirectoryRemove:
	add  t1, a0, zero

	addi  t0, zero, 44
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSObjectDirectoryRemove, . - OSObjectDirectoryRemove

.globl OSSetSecurity
.type OSSetSecurity, @function
OSSetSecurity:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero

	addi  t0, zero, 45
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSSetSecurity, . - OSSetSecurity

.globl SysCreateRelative
.type SysCreateRelative, @function
SysCreateRelative:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero
	mov  t5, long [sp + 0]
	mov  a0, long [sp + 4]

	addi  t0, zero, 46
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size SysCreateRelative, . - SysCreateRelative

.globl OSFileQuery
.type OSFileQuery, @function
OSFileQuery:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 47
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSFileQuery, . - OSFileQuery

.globl OSFileTruncate
.type OSFileTruncate, @function
OSFileTruncate:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero

	addi  t0, zero, 48
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSFileTruncate, . - OSFileTruncate

.globl OSFileSeek
.type OSFileSeek, @function
OSFileSeek:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero

	addi  t0, zero, 49
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSFileSeek, . - OSFileSeek

.globl OSFileRead
.type OSFileRead, @function
OSFileRead:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero
	mov  t5, long [sp + 0]

	addi  t0, zero, 50
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSFileRead, . - OSFileRead

.globl OSFileWrite
.type OSFileWrite, @function
OSFileWrite:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero

	addi  t0, zero, 51
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSFileWrite, . - OSFileWrite

.globl OSFileFlush
.type OSFileFlush, @function
OSFileFlush:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 52
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSFileFlush, . - OSFileFlush

.globl OSFileSetInformation
.type OSFileSetInformation, @function
OSFileSetInformation:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 53
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSFileSetInformation, . - OSFileSetInformation

.globl OSFileReadAsync
.type OSFileReadAsync, @function
OSFileReadAsync:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero
	mov  t5, long [sp + 0]
	mov  a0, long [sp + 4]

	addi  t0, zero, 54
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSFileReadAsync, . - OSFileReadAsync

.globl OSFileWriteAsync
.type OSFileWriteAsync, @function
OSFileWriteAsync:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero
	mov  t5, long [sp + 0]
	mov  a0, long [sp + 4]

	addi  t0, zero, 55
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSFileWriteAsync, . - OSFileWriteAsync

.globl OSFileCancelIO
.type OSFileCancelIO, @function
OSFileCancelIO:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 56
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSFileCancelIO, . - OSFileCancelIO

.globl OSDirectoryRename
.type OSDirectoryRename, @function
OSDirectoryRename:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero

	addi  t0, zero, 57
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSDirectoryRename, . - OSDirectoryRename

.globl OSDirectoryUnlink
.type OSDirectoryUnlink, @function
OSDirectoryUnlink:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 58
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSDirectoryUnlink, . - OSDirectoryUnlink

.globl OSDirectoryRead
.type OSDirectoryRead, @function
OSDirectoryRead:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero

	addi  t0, zero, 59
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSDirectoryRead, . - OSDirectoryRead

.globl OSPageFileCreateRelative
.type OSPageFileCreateRelative, @function
OSPageFileCreateRelative:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero
	mov  t5, long [sp + 0]

	addi  t0, zero, 60
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSPageFileCreateRelative, . - OSPageFileCreateRelative

.globl OSPageFileQuery
.type OSPageFileQuery, @function
OSPageFileQuery:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 61
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSPageFileQuery, . - OSPageFileQuery

.globl OSIOControl
.type OSIOControl, @function
OSIOControl:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero

	addi  t0, zero, 62
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSIOControl, . - OSIOControl

.globl OSGetBootDevicePath
.type OSGetBootDevicePath, @function
OSGetBootDevicePath:
	add  t1, a0, zero

	addi  t0, zero, 63
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSGetBootDevicePath, . - OSGetBootDevicePath

.globl OSFilesystemMount
.type OSFilesystemMount, @function
OSFilesystemMount:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero

	addi  t0, zero, 64
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSFilesystemMount, . - OSFilesystemMount

.globl OSFilesystemUnmount
.type OSFilesystemUnmount, @function
OSFilesystemUnmount:
	add  t1, a0, zero

	addi  t0, zero, 65
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSFilesystemUnmount, . - OSFilesystemUnmount

.globl OSMountQueryAll
.type OSMountQueryAll, @function
OSMountQueryAll:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 66
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSMountQueryAll, . - OSMountQueryAll

.globl OSMountCountQuery
.type OSMountCountQuery, @function
OSMountCountQuery:

	addi  t0, zero, 67
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSMountCountQuery, . - OSMountCountQuery

.globl OSMountUpdateFlags
.type OSMountUpdateFlags, @function
OSMountUpdateFlags:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 68
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSMountUpdateFlags, . - OSMountUpdateFlags

.globl OSMountGetFilesystemName
.type OSMountGetFilesystemName, @function
OSMountGetFilesystemName:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 69
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSMountGetFilesystemName, . - OSMountGetFilesystemName

.globl OSMountSet
.type OSMountSet, @function
OSMountSet:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 70
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSMountSet, . - OSMountSet

.globl OSFlushModifiedPages
.type OSFlushModifiedPages, @function
OSFlushModifiedPages:

	addi  t0, zero, 71
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSFlushModifiedPages, . - OSFlushModifiedPages

.globl OSSectionCreate
.type OSSectionCreate, @function
OSSectionCreate:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero

	addi  t0, zero, 72
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSSectionCreate, . - OSSectionCreate

.globl OSMapView
.type OSMapView, @function
OSMapView:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero
	mov  t5, long [sp + 0]
	mov  a0, long [sp + 4]
	mov  a1, long [sp + 8]

	addi  t0, zero, 73
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSMapView, . - OSMapView

.globl OSUnmapView
.type OSUnmapView, @function
OSUnmapView:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero

	addi  t0, zero, 74
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSUnmapView, . - OSUnmapView

.globl OSRemapView
.type OSRemapView, @function
OSRemapView:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero

	addi  t0, zero, 75
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSRemapView, . - OSRemapView

.globl OSFlushView
.type OSFlushView, @function
OSFlushView:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero

	addi  t0, zero, 76
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSFlushView, . - OSFlushView

.globl OSAllocate
.type OSAllocate, @function
OSAllocate:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero
	mov  t5, long [sp + 0]

	addi  t0, zero, 77
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSAllocate, . - OSAllocate

.globl OSMemoryQuery
.type OSMemoryQuery, @function
OSMemoryQuery:
	add  t1, a0, zero

	addi  t0, zero, 78
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSMemoryQuery, . - OSMemoryQuery

.globl OSWorkingSetPurge
.type OSWorkingSetPurge, @function
OSWorkingSetPurge:

	addi  t0, zero, 79
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSWorkingSetPurge, . - OSWorkingSetPurge

.globl OSSynchronizeIcache
.type OSSynchronizeIcache, @function
OSSynchronizeIcache:

	addi  t0, zero, 80
	sys


	jalr zero, lr, 0

.size OSSynchronizeIcache, . - OSSynchronizeIcache

.globl OSProcessCreate
.type OSProcessCreate, @function
OSProcessCreate:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero
	mov  t5, long [sp + 0]

	addi  t0, zero, 81
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSProcessCreate, . - OSProcessCreate

.globl OSProcessSignal
.type OSProcessSignal, @function
OSProcessSignal:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 82
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSProcessSignal, . - OSProcessSignal

.globl OSProcessOpenByPID
.type OSProcessOpenByPID, @function
OSProcessOpenByPID:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 83
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSProcessOpenByPID, . - OSProcessOpenByPID

.globl OSProcessQuery
.type OSProcessQuery, @function
OSProcessQuery:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 84
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSProcessQuery, . - OSProcessQuery

.globl OSProcessQueryByPID
.type OSProcessQueryByPID, @function
OSProcessQueryByPID:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 85
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSProcessQueryByPID, . - OSProcessQueryByPID

.globl OSProcessReadStatus
.type OSProcessReadStatus, @function
OSProcessReadStatus:
	add  t1, a0, zero

	addi  t0, zero, 86
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSProcessReadStatus, . - OSProcessReadStatus

.globl OSProcessSetConsoleGroup
.type OSProcessSetConsoleGroup, @function
OSProcessSetConsoleGroup:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 87
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSProcessSetConsoleGroup, . - OSProcessSetConsoleGroup

.globl OSProcessBasePrioritySet
.type OSProcessBasePrioritySet, @function
OSProcessBasePrioritySet:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 88
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSProcessBasePrioritySet, . - OSProcessBasePrioritySet

.globl OSProcessSignalActivation
.type OSProcessSignalActivation, @function
OSProcessSignalActivation:
	add  t1, a0, zero

	addi  t0, zero, 89
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSProcessSignalActivation, . - OSProcessSignalActivation

.globl OSProcessWaitForActivation
.type OSProcessWaitForActivation, @function
OSProcessWaitForActivation:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 90
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSProcessWaitForActivation, . - OSProcessWaitForActivation

.globl OSProcessExit
.type OSProcessExit, @function
OSProcessExit:
	add  t1, a0, zero

	addi  t0, zero, 91
	sys


	jalr zero, lr, 0

.size OSProcessExit, . - OSProcessExit

.globl OSProcessCountQuery
.type OSProcessCountQuery, @function
OSProcessCountQuery:

	addi  t0, zero, 92
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSProcessCountQuery, . - OSProcessCountQuery

.globl OSProcessQueryAll
.type OSProcessQueryAll, @function
OSProcessQueryAll:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 93
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSProcessQueryAll, . - OSProcessQueryAll

.globl OSSetQuota
.type OSSetQuota, @function
OSSetQuota:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 94
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSSetQuota, . - OSSetQuota

.globl OSQuotaQuery
.type OSQuotaQuery, @function
OSQuotaQuery:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 95
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSQuotaQuery, . - OSQuotaQuery

.globl OSThreadGetExceptionStatus
.type OSThreadGetExceptionStatus, @function
OSThreadGetExceptionStatus:

	addi  t0, zero, 96
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSThreadGetExceptionStatus, . - OSThreadGetExceptionStatus

.globl OSThreadSleep
.type OSThreadSleep, @function
OSThreadSleep:
	add  t1, a0, zero

	addi  t0, zero, 97
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSThreadSleep, . - OSThreadSleep

.globl OSThreadSleepEx
.type OSThreadSleepEx, @function
OSThreadSleepEx:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 98
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSThreadSleepEx, . - OSThreadSleepEx

.globl OSThreadCreate
.type OSThreadCreate, @function
OSThreadCreate:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero
	mov  t5, long [sp + 0]
	mov  a0, long [sp + 4]

	addi  t0, zero, 99
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSThreadCreate, . - OSThreadCreate

.globl OSThreadTerminate
.type OSThreadTerminate, @function
OSThreadTerminate:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 100
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSThreadTerminate, . - OSThreadTerminate

.globl OSThreadSuspend
.type OSThreadSuspend, @function
OSThreadSuspend:
	add  t1, a0, zero

	addi  t0, zero, 101
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSThreadSuspend, . - OSThreadSuspend

.globl OSThreadResume
.type OSThreadResume, @function
OSThreadResume:
	add  t1, a0, zero

	addi  t0, zero, 102
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSThreadResume, . - OSThreadResume

.globl OSThreadReadStatus
.type OSThreadReadStatus, @function
OSThreadReadStatus:
	add  t1, a0, zero

	addi  t0, zero, 103
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSThreadReadStatus, . - OSThreadReadStatus

.globl OSThreadQuery
.type OSThreadQuery, @function
OSThreadQuery:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 104
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSThreadQuery, . - OSThreadQuery

.globl OSThreadSignal
.type OSThreadSignal, @function
OSThreadSignal:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 105
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSThreadSignal, . - OSThreadSignal

.globl OSThreadMaskSignal
.type OSThreadMaskSignal, @function
OSThreadMaskSignal:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 106
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSThreadMaskSignal, . - OSThreadMaskSignal

.globl OSThreadDeliverOnWaitSignal
.type OSThreadDeliverOnWaitSignal, @function
OSThreadDeliverOnWaitSignal:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 107
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSThreadDeliverOnWaitSignal, . - OSThreadDeliverOnWaitSignal

.globl OSJobCreate
.type OSJobCreate, @function
OSJobCreate:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero
	mov  t5, long [sp + 0]

	addi  t0, zero, 108
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSJobCreate, . - OSJobCreate

.globl OSJobAddProcess
.type OSJobAddProcess, @function
OSJobAddProcess:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 109
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSJobAddProcess, . - OSJobAddProcess

.globl OSJobRemoveProcess
.type OSJobRemoveProcess, @function
OSJobRemoveProcess:
	add  t1, a0, zero

	addi  t0, zero, 110
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSJobRemoveProcess, . - OSJobRemoveProcess

.globl OSJobSignal
.type OSJobSignal, @function
OSJobSignal:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero

	addi  t0, zero, 111
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSJobSignal, . - OSJobSignal

.globl OSSetSystemConsole
.type OSSetSystemConsole, @function
OSSetSystemConsole:
	add  t1, a0, zero

	addi  t0, zero, 112
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSSetSystemConsole, . - OSSetSystemConsole

.globl OSConsoleSignal
.type OSConsoleSignal, @function
OSConsoleSignal:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 113
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSConsoleSignal, . - OSConsoleSignal

.globl OSIsAConsole
.type OSIsAConsole, @function
OSIsAConsole:
	add  t1, a0, zero

	addi  t0, zero, 114
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSIsAConsole, . - OSIsAConsole

.globl OSDuplexCreate
.type OSDuplexCreate, @function
OSDuplexCreate:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero

	addi  t0, zero, 115
	sys

	add  a3, t4, zero
	add  a2, t3, zero
	add  a1, t2, zero

	jalr zero, lr, 0

.size OSDuplexCreate, . - OSDuplexCreate

.globl OSCheckPermission
.type OSCheckPermission, @function
OSCheckPermission:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 116
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSCheckPermission, . - OSCheckPermission

.globl OSGrantPermission
.type OSGrantPermission, @function
OSGrantPermission:
	add  t1, a0, zero
	add  t2, a1, zero

	addi  t0, zero, 117
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSGrantPermission, . - OSGrantPermission

.globl OSPortCreate
.type OSPortCreate, @function
OSPortCreate:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero

	addi  t0, zero, 118
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSPortCreate, . - OSPortCreate

.globl OSPortConnectRelative
.type OSPortConnectRelative, @function
OSPortConnectRelative:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero
	mov  t5, long [sp + 0]

	addi  t0, zero, 119
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSPortConnectRelative, . - OSPortConnectRelative

.globl OSPortAccept
.type OSPortAccept, @function
OSPortAccept:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero

	addi  t0, zero, 120
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSPortAccept, . - OSPortAccept

.globl OSPortSendAndWaitReceive
.type OSPortSendAndWaitReceive, @function
OSPortSendAndWaitReceive:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero

	addi  t0, zero, 121
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSPortSendAndWaitReceive, . - OSPortSendAndWaitReceive

.globl OSPortSendAndWaitReply
.type OSPortSendAndWaitReply, @function
OSPortSendAndWaitReply:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero
	add  t4, a3, zero

	addi  t0, zero, 122
	sys

	add  a3, t4, zero

	jalr zero, lr, 0

.size OSPortSendAndWaitReply, . - OSPortSendAndWaitReply

.globl OSPortOpenProcessByClientID
.type OSPortOpenProcessByClientID, @function
OSPortOpenProcessByClientID:
	add  t1, a0, zero
	add  t2, a1, zero
	add  t3, a2, zero

	addi  t0, zero, 123
	sys

	add  a3, t4, zero
	add  a2, t3, zero

	jalr zero, lr, 0

.size OSPortOpenProcessByClientID, . - OSPortOpenProcessByClientID
