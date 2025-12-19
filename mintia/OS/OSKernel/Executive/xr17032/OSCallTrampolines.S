# AUTOMATICALLY GENERATED -- DO NOT EDIT

.section "PAGE$text", "ax", %progbits

.globl OSCallCount
.type OSCallCount, @object
OSCallCount: .long 123
.size OSCallCount, . - OSCallCount

.globl OSCallTable
.type OSCallTable, @object
OSCallTable:	.long 0                                                # 0
	.long OSTOSConsolePutCharacter                         # 1
	.long OSTOSSystemAbort                                 # 2
	.long OSTOSGetBootFlags                                # 3
	.long OSTOSContinue                                    # 4
	.long OSTOSQueryTime                                   # 5
	.long OSTOSQueryUptime                                 # 6
	.long OSTOSTimeZoneGet                                 # 7
	.long OSTOSTimeZoneSet                                 # 8
	.long OSTOSTimeSet                                     # 9
	.long OSTOSShutdownSystem                              # 10
	.long OSTOSVersion                                     # 11
	.long OSTOSEventCreate                                 # 12
	.long OSTOSEventReset                                  # 13
	.long OSTOSEventSignal                                 # 14
	.long OSTOSEventPulse                                  # 15
	.long OSTOSEventReadState                              # 16
	.long OSTOSSemaphoreCreate                             # 17
	.long OSTOSSemaphoreRelease                            # 18
	.long OSTOSSemaphoreReadState                          # 19
	.long OSTOSMutexCreate                                 # 20
	.long OSTOSMutexRelease                                # 21
	.long OSTOSMutexReadState                              # 22
	.long OSTOSTimerCreate                                 # 23
	.long OSTOSTimerReset                                  # 24
	.long OSTOSTimerEnqueue                                # 25
	.long OSTOSTimerDequeue                                # 26
	.long OSTOSTimerReadState                              # 27
	.long OSTOSGetStatistics                               # 28
	.long OSTOSNvramVariableQuery                          # 29
	.long OSTOSNvramVariableSet                            # 30
	.long OSTOSNvramVariableRead                           # 31
	.long OSTOSIsComputerOn                                # 32
	.long OSTOSIsComputerOnFire                            # 33
	.long OSTOSOpenRelative                                # 34
	.long OSTOSClose                                       # 35
	.long OSTOSQuery                                       # 36
	.long OSTOSWaitForMultipleObjects                      # 37
	.long OSTOSWaitForObject                               # 38
	.long OSTOSHandleDuplicate                             # 39
	.long OSTOSObjectDirectoryCountQuery                   # 40
	.long OSTOSObjectDirectoryQueryAll                     # 41
	.long OSTOSObjectDirectoryCreate                       # 42
	.long OSTOSObjectDirectoryInsert                       # 43
	.long OSTOSObjectDirectoryRemove                       # 44
	.long OSTOSSetSecurity                                 # 45
	.long OSTSysCreateRelative                             # 46
	.long OSTOSFileQuery                                   # 47
	.long OSTOSFileTruncate                                # 48
	.long OSTOSFileSeek                                    # 49
	.long OSTOSFileRead                                    # 50
	.long OSTOSFileWrite                                   # 51
	.long OSTOSFileFlush                                   # 52
	.long OSTOSFileSetInformation                          # 53
	.long OSTOSFileReadAsync                               # 54
	.long OSTOSFileWriteAsync                              # 55
	.long OSTOSFileCancelIO                                # 56
	.long OSTOSDirectoryRename                             # 57
	.long OSTOSDirectoryUnlink                             # 58
	.long OSTOSDirectoryRead                               # 59
	.long OSTOSPageFileCreateRelative                      # 60
	.long OSTOSPageFileQuery                               # 61
	.long OSTOSIOControl                                   # 62
	.long OSTOSGetBootDevicePath                           # 63
	.long OSTOSFilesystemMount                             # 64
	.long OSTOSFilesystemUnmount                           # 65
	.long OSTOSMountQueryAll                               # 66
	.long OSTOSMountCountQuery                             # 67
	.long OSTOSMountUpdateFlags                            # 68
	.long OSTOSMountGetFilesystemName                      # 69
	.long OSTOSMountSet                                    # 70
	.long OSTOSFlushModifiedPages                          # 71
	.long OSTOSSectionCreate                               # 72
	.long OSTOSMapView                                     # 73
	.long OSTOSUnmapView                                   # 74
	.long OSTOSRemapView                                   # 75
	.long OSTOSFlushView                                   # 76
	.long OSTOSAllocate                                    # 77
	.long OSTOSMemoryQuery                                 # 78
	.long OSTOSWorkingSetPurge                             # 79
	.long OSTOSSynchronizeIcache                           # 80
	.long OSTOSProcessCreate                               # 81
	.long OSTOSProcessSignal                               # 82
	.long OSTOSProcessOpenByPID                            # 83
	.long OSTOSProcessQuery                                # 84
	.long OSTOSProcessQueryByPID                           # 85
	.long OSTOSProcessReadStatus                           # 86
	.long OSTOSProcessSetConsoleGroup                      # 87
	.long OSTOSProcessBasePrioritySet                      # 88
	.long OSTOSProcessSignalActivation                     # 89
	.long OSTOSProcessWaitForActivation                    # 90
	.long OSTOSProcessExit                                 # 91
	.long OSTOSProcessCountQuery                           # 92
	.long OSTOSProcessQueryAll                             # 93
	.long OSTOSSetQuota                                    # 94
	.long OSTOSQuotaQuery                                  # 95
	.long OSTOSThreadGetExceptionStatus                    # 96
	.long OSTOSThreadSleep                                 # 97
	.long OSTOSThreadSleepEx                               # 98
	.long OSTOSThreadCreate                                # 99
	.long OSTOSThreadTerminate                             # 100
	.long OSTOSThreadSuspend                               # 101
	.long OSTOSThreadResume                                # 102
	.long OSTOSThreadReadStatus                            # 103
	.long OSTOSThreadQuery                                 # 104
	.long OSTOSThreadSignal                                # 105
	.long OSTOSThreadMaskSignal                            # 106
	.long OSTOSThreadDeliverOnWaitSignal                   # 107
	.long OSTOSJobCreate                                   # 108
	.long OSTOSJobAddProcess                               # 109
	.long OSTOSJobRemoveProcess                            # 110
	.long OSTOSJobSignal                                   # 111
	.long OSTOSSetSystemConsole                            # 112
	.long OSTOSConsoleSignal                               # 113
	.long OSTOSIsAConsole                                  # 114
	.long OSTOSDuplexCreate                                # 115
	.long OSTOSCheckPermission                             # 116
	.long OSTOSGrantPermission                             # 117
	.long OSTOSPortCreate                                  # 118
	.long OSTOSPortConnectRelative                         # 119
	.long OSTOSPortAccept                                  # 120
	.long OSTOSPortSendAndWaitReceive                      # 121
	.long OSTOSPortSendAndWaitReply                        # 122
	.long OSTOSPortOpenProcessByClientID                   # 123
.size OSCallTable, . - OSCallTable

.globl OSTOSConsolePutCharacter
.type OSTOSConsolePutCharacter, @function
OSTOSConsolePutCharacter:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSConsolePutCharacter

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSConsolePutCharacter, . - OSTOSConsolePutCharacter

.globl OSTOSSystemAbort
.type OSTOSSystemAbort, @function
OSTOSSystemAbort:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3

	jal  OSSystemAbort

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSSystemAbort, . - OSTOSSystemAbort

.globl OSTOSGetBootFlags
.type OSTOSGetBootFlags, @function
OSTOSGetBootFlags:	subi sp, sp, 4
	mov  long [sp + 0], lr

	jal  OSGetBootFlags

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSGetBootFlags, . - OSTOSGetBootFlags

.globl OSTOSContinue
.type OSTOSContinue, @function
OSTOSContinue:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3

	jal  OSContinue

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSContinue, . - OSTOSContinue

.globl OSTOSQueryTime
.type OSTOSQueryTime, @function
OSTOSQueryTime:	subi sp, sp, 4
	mov  long [sp + 0], lr

	jal  OSQueryTime

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSQueryTime, . - OSTOSQueryTime

.globl OSTOSQueryUptime
.type OSTOSQueryUptime, @function
OSTOSQueryUptime:	subi sp, sp, 4
	mov  long [sp + 0], lr

	jal  OSQueryUptime

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSQueryUptime, . - OSTOSQueryUptime

.globl OSTOSTimeZoneGet
.type OSTOSTimeZoneGet, @function
OSTOSTimeZoneGet:	subi sp, sp, 4
	mov  long [sp + 0], lr

	jal  OSTimeZoneGet

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSTimeZoneGet, . - OSTOSTimeZoneGet

.globl OSTOSTimeZoneSet
.type OSTOSTimeZoneSet, @function
OSTOSTimeZoneSet:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSTimeZoneSet

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSTimeZoneSet, . - OSTOSTimeZoneSet

.globl OSTOSTimeSet
.type OSTOSTimeSet, @function
OSTOSTimeSet:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSTimeSet

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSTimeSet, . - OSTOSTimeSet

.globl OSTOSShutdownSystem
.type OSTOSShutdownSystem, @function
OSTOSShutdownSystem:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSShutdownSystem

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSShutdownSystem, . - OSTOSShutdownSystem

.globl OSTOSVersion
.type OSTOSVersion, @function
OSTOSVersion:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSVersion

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSVersion, . - OSTOSVersion

.globl OSTOSEventCreate
.type OSTOSEventCreate, @function
OSTOSEventCreate:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	jal  OSEventCreate

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSEventCreate, . - OSTOSEventCreate

.globl OSTOSEventReset
.type OSTOSEventReset, @function
OSTOSEventReset:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSEventReset

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSEventReset, . - OSTOSEventReset

.globl OSTOSEventSignal
.type OSTOSEventSignal, @function
OSTOSEventSignal:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSEventSignal

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSEventSignal, . - OSTOSEventSignal

.globl OSTOSEventPulse
.type OSTOSEventPulse, @function
OSTOSEventPulse:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSEventPulse

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSEventPulse, . - OSTOSEventPulse

.globl OSTOSEventReadState
.type OSTOSEventReadState, @function
OSTOSEventReadState:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSEventReadState

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSEventReadState, . - OSTOSEventReadState

.globl OSTOSSemaphoreCreate
.type OSTOSSemaphoreCreate, @function
OSTOSSemaphoreCreate:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3

	jal  OSSemaphoreCreate

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSSemaphoreCreate, . - OSTOSSemaphoreCreate

.globl OSTOSSemaphoreRelease
.type OSTOSSemaphoreRelease, @function
OSTOSSemaphoreRelease:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSSemaphoreRelease

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSSemaphoreRelease, . - OSTOSSemaphoreRelease

.globl OSTOSSemaphoreReadState
.type OSTOSSemaphoreReadState, @function
OSTOSSemaphoreReadState:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSSemaphoreReadState

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSSemaphoreReadState, . - OSTOSSemaphoreReadState

.globl OSTOSMutexCreate
.type OSTOSMutexCreate, @function
OSTOSMutexCreate:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSMutexCreate

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSMutexCreate, . - OSTOSMutexCreate

.globl OSTOSMutexRelease
.type OSTOSMutexRelease, @function
OSTOSMutexRelease:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSMutexRelease

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSMutexRelease, . - OSTOSMutexRelease

.globl OSTOSMutexReadState
.type OSTOSMutexReadState, @function
OSTOSMutexReadState:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSMutexReadState

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSMutexReadState, . - OSTOSMutexReadState

.globl OSTOSTimerCreate
.type OSTOSTimerCreate, @function
OSTOSTimerCreate:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSTimerCreate

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSTimerCreate, . - OSTOSTimerCreate

.globl OSTOSTimerReset
.type OSTOSTimerReset, @function
OSTOSTimerReset:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSTimerReset

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSTimerReset, . - OSTOSTimerReset

.globl OSTOSTimerEnqueue
.type OSTOSTimerEnqueue, @function
OSTOSTimerEnqueue:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSTimerEnqueue

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSTimerEnqueue, . - OSTOSTimerEnqueue

.globl OSTOSTimerDequeue
.type OSTOSTimerDequeue, @function
OSTOSTimerDequeue:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSTimerDequeue

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSTimerDequeue, . - OSTOSTimerDequeue

.globl OSTOSTimerReadState
.type OSTOSTimerReadState, @function
OSTOSTimerReadState:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSTimerReadState

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSTimerReadState, . - OSTOSTimerReadState

.globl OSTOSGetStatistics
.type OSTOSGetStatistics, @function
OSTOSGetStatistics:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSGetStatistics

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSGetStatistics, . - OSTOSGetStatistics

.globl OSTOSNvramVariableQuery
.type OSTOSNvramVariableQuery, @function
OSTOSNvramVariableQuery:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSNvramVariableQuery

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSNvramVariableQuery, . - OSTOSNvramVariableQuery

.globl OSTOSNvramVariableSet
.type OSTOSNvramVariableSet, @function
OSTOSNvramVariableSet:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSNvramVariableSet

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSNvramVariableSet, . - OSTOSNvramVariableSet

.globl OSTOSNvramVariableRead
.type OSTOSNvramVariableRead, @function
OSTOSNvramVariableRead:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSNvramVariableRead

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSNvramVariableRead, . - OSTOSNvramVariableRead

.globl OSTOSIsComputerOn
.type OSTOSIsComputerOn, @function
OSTOSIsComputerOn:	subi sp, sp, 4
	mov  long [sp + 0], lr

	jal  OSIsComputerOn

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSIsComputerOn, . - OSTOSIsComputerOn

.globl OSTOSIsComputerOnFire
.type OSTOSIsComputerOnFire, @function
OSTOSIsComputerOnFire:	subi sp, sp, 4
	mov  long [sp + 0], lr

	jal  OSIsComputerOnFire

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSIsComputerOnFire, . - OSTOSIsComputerOnFire

.globl OSTOSOpenRelative
.type OSTOSOpenRelative, @function
OSTOSOpenRelative:	subi sp, sp, 12
	mov  long [sp + 8], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	mov  t0, long [s17 + 20] # t5
	mov  long [sp + 0], t0

	mov  t0, long [s17 + 24] # a0
	mov  long [sp + 4], t0

	jal  OSOpenRelative

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 8]
	addi sp, sp, 12
	jalr zero, lr, 0

.size OSTOSOpenRelative, . - OSTOSOpenRelative

.globl OSTOSClose
.type OSTOSClose, @function
OSTOSClose:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSClose

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSClose, . - OSTOSClose

.globl OSTOSQuery
.type OSTOSQuery, @function
OSTOSQuery:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSQuery

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSQuery, . - OSTOSQuery

.globl OSTOSWaitForMultipleObjects
.type OSTOSWaitForMultipleObjects, @function
OSTOSWaitForMultipleObjects:	subi sp, sp, 8
	mov  long [sp + 4], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	mov  t0, long [s17 + 20] # t5
	mov  long [sp + 0], t0

	jal  OSWaitForMultipleObjects

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 4]
	addi sp, sp, 8
	jalr zero, lr, 0

.size OSTOSWaitForMultipleObjects, . - OSTOSWaitForMultipleObjects

.globl OSTOSWaitForObject
.type OSTOSWaitForObject, @function
OSTOSWaitForObject:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3

	jal  OSWaitForObject

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSWaitForObject, . - OSTOSWaitForObject

.globl OSTOSHandleDuplicate
.type OSTOSHandleDuplicate, @function
OSTOSHandleDuplicate:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	jal  OSHandleDuplicate

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSHandleDuplicate, . - OSTOSHandleDuplicate

.globl OSTOSObjectDirectoryCountQuery
.type OSTOSObjectDirectoryCountQuery, @function
OSTOSObjectDirectoryCountQuery:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSObjectDirectoryCountQuery

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSObjectDirectoryCountQuery, . - OSTOSObjectDirectoryCountQuery

.globl OSTOSObjectDirectoryQueryAll
.type OSTOSObjectDirectoryQueryAll, @function
OSTOSObjectDirectoryQueryAll:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3

	jal  OSObjectDirectoryQueryAll

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSObjectDirectoryQueryAll, . - OSTOSObjectDirectoryQueryAll

.globl OSTOSObjectDirectoryCreate
.type OSTOSObjectDirectoryCreate, @function
OSTOSObjectDirectoryCreate:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSObjectDirectoryCreate

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSObjectDirectoryCreate, . - OSTOSObjectDirectoryCreate

.globl OSTOSObjectDirectoryInsert
.type OSTOSObjectDirectoryInsert, @function
OSTOSObjectDirectoryInsert:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSObjectDirectoryInsert

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSObjectDirectoryInsert, . - OSTOSObjectDirectoryInsert

.globl OSTOSObjectDirectoryRemove
.type OSTOSObjectDirectoryRemove, @function
OSTOSObjectDirectoryRemove:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSObjectDirectoryRemove

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSObjectDirectoryRemove, . - OSTOSObjectDirectoryRemove

.globl OSTOSSetSecurity
.type OSTOSSetSecurity, @function
OSTOSSetSecurity:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	jal  OSSetSecurity

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSSetSecurity, . - OSTOSSetSecurity

.globl OSTSysCreateRelative
.type OSTSysCreateRelative, @function
OSTSysCreateRelative:	subi sp, sp, 12
	mov  long [sp + 8], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	mov  t0, long [s17 + 20] # t5
	mov  long [sp + 0], t0

	mov  t0, long [s17 + 24] # a0
	mov  long [sp + 4], t0

	jal  SysCreateRelative

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 8]
	addi sp, sp, 12
	jalr zero, lr, 0

.size OSTSysCreateRelative, . - OSTSysCreateRelative

.globl OSTOSFileQuery
.type OSTOSFileQuery, @function
OSTOSFileQuery:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSFileQuery

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSFileQuery, . - OSTOSFileQuery

.globl OSTOSFileTruncate
.type OSTOSFileTruncate, @function
OSTOSFileTruncate:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3

	jal  OSFileTruncate

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSFileTruncate, . - OSTOSFileTruncate

.globl OSTOSFileSeek
.type OSTOSFileSeek, @function
OSTOSFileSeek:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3

	jal  OSFileSeek

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSFileSeek, . - OSTOSFileSeek

.globl OSTOSFileRead
.type OSTOSFileRead, @function
OSTOSFileRead:	subi sp, sp, 8
	mov  long [sp + 4], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	mov  t0, long [s17 + 20] # t5
	mov  long [sp + 0], t0

	jal  OSFileRead

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 4]
	addi sp, sp, 8
	jalr zero, lr, 0

.size OSTOSFileRead, . - OSTOSFileRead

.globl OSTOSFileWrite
.type OSTOSFileWrite, @function
OSTOSFileWrite:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	jal  OSFileWrite

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSFileWrite, . - OSTOSFileWrite

.globl OSTOSFileFlush
.type OSTOSFileFlush, @function
OSTOSFileFlush:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSFileFlush

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSFileFlush, . - OSTOSFileFlush

.globl OSTOSFileSetInformation
.type OSTOSFileSetInformation, @function
OSTOSFileSetInformation:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSFileSetInformation

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSFileSetInformation, . - OSTOSFileSetInformation

.globl OSTOSFileReadAsync
.type OSTOSFileReadAsync, @function
OSTOSFileReadAsync:	subi sp, sp, 12
	mov  long [sp + 8], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	mov  t0, long [s17 + 20] # t5
	mov  long [sp + 0], t0

	mov  t0, long [s17 + 24] # a0
	mov  long [sp + 4], t0

	jal  OSFileReadAsync

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 8]
	addi sp, sp, 12
	jalr zero, lr, 0

.size OSTOSFileReadAsync, . - OSTOSFileReadAsync

.globl OSTOSFileWriteAsync
.type OSTOSFileWriteAsync, @function
OSTOSFileWriteAsync:	subi sp, sp, 12
	mov  long [sp + 8], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	mov  t0, long [s17 + 20] # t5
	mov  long [sp + 0], t0

	mov  t0, long [s17 + 24] # a0
	mov  long [sp + 4], t0

	jal  OSFileWriteAsync

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 8]
	addi sp, sp, 12
	jalr zero, lr, 0

.size OSTOSFileWriteAsync, . - OSTOSFileWriteAsync

.globl OSTOSFileCancelIO
.type OSTOSFileCancelIO, @function
OSTOSFileCancelIO:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSFileCancelIO

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSFileCancelIO, . - OSTOSFileCancelIO

.globl OSTOSDirectoryRename
.type OSTOSDirectoryRename, @function
OSTOSDirectoryRename:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	jal  OSDirectoryRename

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSDirectoryRename, . - OSTOSDirectoryRename

.globl OSTOSDirectoryUnlink
.type OSTOSDirectoryUnlink, @function
OSTOSDirectoryUnlink:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSDirectoryUnlink

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSDirectoryUnlink, . - OSTOSDirectoryUnlink

.globl OSTOSDirectoryRead
.type OSTOSDirectoryRead, @function
OSTOSDirectoryRead:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3

	jal  OSDirectoryRead

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSDirectoryRead, . - OSTOSDirectoryRead

.globl OSTOSPageFileCreateRelative
.type OSTOSPageFileCreateRelative, @function
OSTOSPageFileCreateRelative:	subi sp, sp, 8
	mov  long [sp + 4], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	mov  t0, long [s17 + 20] # t5
	mov  long [sp + 0], t0

	jal  OSPageFileCreateRelative

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 4]
	addi sp, sp, 8
	jalr zero, lr, 0

.size OSTOSPageFileCreateRelative, . - OSTOSPageFileCreateRelative

.globl OSTOSPageFileQuery
.type OSTOSPageFileQuery, @function
OSTOSPageFileQuery:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSPageFileQuery

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSPageFileQuery, . - OSTOSPageFileQuery

.globl OSTOSIOControl
.type OSTOSIOControl, @function
OSTOSIOControl:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3

	jal  OSIOControl

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSIOControl, . - OSTOSIOControl

.globl OSTOSGetBootDevicePath
.type OSTOSGetBootDevicePath, @function
OSTOSGetBootDevicePath:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSGetBootDevicePath

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSGetBootDevicePath, . - OSTOSGetBootDevicePath

.globl OSTOSFilesystemMount
.type OSTOSFilesystemMount, @function
OSTOSFilesystemMount:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3

	jal  OSFilesystemMount

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSFilesystemMount, . - OSTOSFilesystemMount

.globl OSTOSFilesystemUnmount
.type OSTOSFilesystemUnmount, @function
OSTOSFilesystemUnmount:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSFilesystemUnmount

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSFilesystemUnmount, . - OSTOSFilesystemUnmount

.globl OSTOSMountQueryAll
.type OSTOSMountQueryAll, @function
OSTOSMountQueryAll:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSMountQueryAll

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSMountQueryAll, . - OSTOSMountQueryAll

.globl OSTOSMountCountQuery
.type OSTOSMountCountQuery, @function
OSTOSMountCountQuery:	subi sp, sp, 4
	mov  long [sp + 0], lr

	jal  OSMountCountQuery

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSMountCountQuery, . - OSTOSMountCountQuery

.globl OSTOSMountUpdateFlags
.type OSTOSMountUpdateFlags, @function
OSTOSMountUpdateFlags:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSMountUpdateFlags

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSMountUpdateFlags, . - OSTOSMountUpdateFlags

.globl OSTOSMountGetFilesystemName
.type OSTOSMountGetFilesystemName, @function
OSTOSMountGetFilesystemName:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSMountGetFilesystemName

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSMountGetFilesystemName, . - OSTOSMountGetFilesystemName

.globl OSTOSMountSet
.type OSTOSMountSet, @function
OSTOSMountSet:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSMountSet

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSMountSet, . - OSTOSMountSet

.globl OSTOSFlushModifiedPages
.type OSTOSFlushModifiedPages, @function
OSTOSFlushModifiedPages:	subi sp, sp, 4
	mov  long [sp + 0], lr

	jal  OSFlushModifiedPages

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSFlushModifiedPages, . - OSTOSFlushModifiedPages

.globl OSTOSSectionCreate
.type OSTOSSectionCreate, @function
OSTOSSectionCreate:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3

	jal  OSSectionCreate

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSSectionCreate, . - OSTOSSectionCreate

.globl OSTOSMapView
.type OSTOSMapView, @function
OSTOSMapView:	subi sp, sp, 16
	mov  long [sp + 12], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	mov  t0, long [s17 + 20] # t5
	mov  long [sp + 0], t0

	mov  t0, long [s17 + 24] # a0
	mov  long [sp + 4], t0

	mov  t0, long [s17 + 28] # a1
	mov  long [sp + 8], t0

	jal  OSMapView

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 12]
	addi sp, sp, 16
	jalr zero, lr, 0

.size OSTOSMapView, . - OSTOSMapView

.globl OSTOSUnmapView
.type OSTOSUnmapView, @function
OSTOSUnmapView:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3

	jal  OSUnmapView

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSUnmapView, . - OSTOSUnmapView

.globl OSTOSRemapView
.type OSTOSRemapView, @function
OSTOSRemapView:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	jal  OSRemapView

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSRemapView, . - OSTOSRemapView

.globl OSTOSFlushView
.type OSTOSFlushView, @function
OSTOSFlushView:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3

	jal  OSFlushView

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSFlushView, . - OSTOSFlushView

.globl OSTOSAllocate
.type OSTOSAllocate, @function
OSTOSAllocate:	subi sp, sp, 8
	mov  long [sp + 4], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	mov  t0, long [s17 + 20] # t5
	mov  long [sp + 0], t0

	jal  OSAllocate

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 4]
	addi sp, sp, 8
	jalr zero, lr, 0

.size OSTOSAllocate, . - OSTOSAllocate

.globl OSTOSMemoryQuery
.type OSTOSMemoryQuery, @function
OSTOSMemoryQuery:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSMemoryQuery

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSMemoryQuery, . - OSTOSMemoryQuery

.globl OSTOSWorkingSetPurge
.type OSTOSWorkingSetPurge, @function
OSTOSWorkingSetPurge:	subi sp, sp, 4
	mov  long [sp + 0], lr

	jal  OSWorkingSetPurge

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSWorkingSetPurge, . - OSTOSWorkingSetPurge

.globl OSTOSSynchronizeIcache
.type OSTOSSynchronizeIcache, @function
OSTOSSynchronizeIcache:	subi sp, sp, 4
	mov  long [sp + 0], lr

	jal  OSSynchronizeIcache


	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSSynchronizeIcache, . - OSTOSSynchronizeIcache

.globl OSTOSProcessCreate
.type OSTOSProcessCreate, @function
OSTOSProcessCreate:	subi sp, sp, 8
	mov  long [sp + 4], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	mov  t0, long [s17 + 20] # t5
	mov  long [sp + 0], t0

	jal  OSProcessCreate

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 4]
	addi sp, sp, 8
	jalr zero, lr, 0

.size OSTOSProcessCreate, . - OSTOSProcessCreate

.globl OSTOSProcessSignal
.type OSTOSProcessSignal, @function
OSTOSProcessSignal:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSProcessSignal

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSProcessSignal, . - OSTOSProcessSignal

.globl OSTOSProcessOpenByPID
.type OSTOSProcessOpenByPID, @function
OSTOSProcessOpenByPID:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSProcessOpenByPID

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSProcessOpenByPID, . - OSTOSProcessOpenByPID

.globl OSTOSProcessQuery
.type OSTOSProcessQuery, @function
OSTOSProcessQuery:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSProcessQuery

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSProcessQuery, . - OSTOSProcessQuery

.globl OSTOSProcessQueryByPID
.type OSTOSProcessQueryByPID, @function
OSTOSProcessQueryByPID:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSProcessQueryByPID

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSProcessQueryByPID, . - OSTOSProcessQueryByPID

.globl OSTOSProcessReadStatus
.type OSTOSProcessReadStatus, @function
OSTOSProcessReadStatus:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSProcessReadStatus

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSProcessReadStatus, . - OSTOSProcessReadStatus

.globl OSTOSProcessSetConsoleGroup
.type OSTOSProcessSetConsoleGroup, @function
OSTOSProcessSetConsoleGroup:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSProcessSetConsoleGroup

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSProcessSetConsoleGroup, . - OSTOSProcessSetConsoleGroup

.globl OSTOSProcessBasePrioritySet
.type OSTOSProcessBasePrioritySet, @function
OSTOSProcessBasePrioritySet:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSProcessBasePrioritySet

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSProcessBasePrioritySet, . - OSTOSProcessBasePrioritySet

.globl OSTOSProcessSignalActivation
.type OSTOSProcessSignalActivation, @function
OSTOSProcessSignalActivation:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSProcessSignalActivation

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSProcessSignalActivation, . - OSTOSProcessSignalActivation

.globl OSTOSProcessWaitForActivation
.type OSTOSProcessWaitForActivation, @function
OSTOSProcessWaitForActivation:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSProcessWaitForActivation

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSProcessWaitForActivation, . - OSTOSProcessWaitForActivation

.globl OSTOSProcessExit
.type OSTOSProcessExit, @function
OSTOSProcessExit:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSProcessExit


	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSProcessExit, . - OSTOSProcessExit

.globl OSTOSProcessCountQuery
.type OSTOSProcessCountQuery, @function
OSTOSProcessCountQuery:	subi sp, sp, 4
	mov  long [sp + 0], lr

	jal  OSProcessCountQuery

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSProcessCountQuery, . - OSTOSProcessCountQuery

.globl OSTOSProcessQueryAll
.type OSTOSProcessQueryAll, @function
OSTOSProcessQueryAll:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSProcessQueryAll

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSProcessQueryAll, . - OSTOSProcessQueryAll

.globl OSTOSSetQuota
.type OSTOSSetQuota, @function
OSTOSSetQuota:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSSetQuota

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSSetQuota, . - OSTOSSetQuota

.globl OSTOSQuotaQuery
.type OSTOSQuotaQuery, @function
OSTOSQuotaQuery:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSQuotaQuery

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSQuotaQuery, . - OSTOSQuotaQuery

.globl OSTOSThreadGetExceptionStatus
.type OSTOSThreadGetExceptionStatus, @function
OSTOSThreadGetExceptionStatus:	subi sp, sp, 4
	mov  long [sp + 0], lr

	jal  OSThreadGetExceptionStatus

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSThreadGetExceptionStatus, . - OSTOSThreadGetExceptionStatus

.globl OSTOSThreadSleep
.type OSTOSThreadSleep, @function
OSTOSThreadSleep:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSThreadSleep

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSThreadSleep, . - OSTOSThreadSleep

.globl OSTOSThreadSleepEx
.type OSTOSThreadSleepEx, @function
OSTOSThreadSleepEx:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSThreadSleepEx

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSThreadSleepEx, . - OSTOSThreadSleepEx

.globl OSTOSThreadCreate
.type OSTOSThreadCreate, @function
OSTOSThreadCreate:	subi sp, sp, 12
	mov  long [sp + 8], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	mov  t0, long [s17 + 20] # t5
	mov  long [sp + 0], t0

	mov  t0, long [s17 + 24] # a0
	mov  long [sp + 4], t0

	jal  OSThreadCreate

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 8]
	addi sp, sp, 12
	jalr zero, lr, 0

.size OSTOSThreadCreate, . - OSTOSThreadCreate

.globl OSTOSThreadTerminate
.type OSTOSThreadTerminate, @function
OSTOSThreadTerminate:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSThreadTerminate

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSThreadTerminate, . - OSTOSThreadTerminate

.globl OSTOSThreadSuspend
.type OSTOSThreadSuspend, @function
OSTOSThreadSuspend:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSThreadSuspend

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSThreadSuspend, . - OSTOSThreadSuspend

.globl OSTOSThreadResume
.type OSTOSThreadResume, @function
OSTOSThreadResume:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSThreadResume

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSThreadResume, . - OSTOSThreadResume

.globl OSTOSThreadReadStatus
.type OSTOSThreadReadStatus, @function
OSTOSThreadReadStatus:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSThreadReadStatus

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSThreadReadStatus, . - OSTOSThreadReadStatus

.globl OSTOSThreadQuery
.type OSTOSThreadQuery, @function
OSTOSThreadQuery:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSThreadQuery

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSThreadQuery, . - OSTOSThreadQuery

.globl OSTOSThreadSignal
.type OSTOSThreadSignal, @function
OSTOSThreadSignal:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSThreadSignal

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSThreadSignal, . - OSTOSThreadSignal

.globl OSTOSThreadMaskSignal
.type OSTOSThreadMaskSignal, @function
OSTOSThreadMaskSignal:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSThreadMaskSignal

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSThreadMaskSignal, . - OSTOSThreadMaskSignal

.globl OSTOSThreadDeliverOnWaitSignal
.type OSTOSThreadDeliverOnWaitSignal, @function
OSTOSThreadDeliverOnWaitSignal:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSThreadDeliverOnWaitSignal

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSThreadDeliverOnWaitSignal, . - OSTOSThreadDeliverOnWaitSignal

.globl OSTOSJobCreate
.type OSTOSJobCreate, @function
OSTOSJobCreate:	subi sp, sp, 8
	mov  long [sp + 4], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	mov  t0, long [s17 + 20] # t5
	mov  long [sp + 0], t0

	jal  OSJobCreate

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 4]
	addi sp, sp, 8
	jalr zero, lr, 0

.size OSTOSJobCreate, . - OSTOSJobCreate

.globl OSTOSJobAddProcess
.type OSTOSJobAddProcess, @function
OSTOSJobAddProcess:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSJobAddProcess

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSJobAddProcess, . - OSTOSJobAddProcess

.globl OSTOSJobRemoveProcess
.type OSTOSJobRemoveProcess, @function
OSTOSJobRemoveProcess:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSJobRemoveProcess

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSJobRemoveProcess, . - OSTOSJobRemoveProcess

.globl OSTOSJobSignal
.type OSTOSJobSignal, @function
OSTOSJobSignal:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3

	jal  OSJobSignal

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSJobSignal, . - OSTOSJobSignal

.globl OSTOSSetSystemConsole
.type OSTOSSetSystemConsole, @function
OSTOSSetSystemConsole:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSSetSystemConsole

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSSetSystemConsole, . - OSTOSSetSystemConsole

.globl OSTOSConsoleSignal
.type OSTOSConsoleSignal, @function
OSTOSConsoleSignal:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSConsoleSignal

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSConsoleSignal, . - OSTOSConsoleSignal

.globl OSTOSIsAConsole
.type OSTOSIsAConsole, @function
OSTOSIsAConsole:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1

	jal  OSIsAConsole

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSIsAConsole, . - OSTOSIsAConsole

.globl OSTOSDuplexCreate
.type OSTOSDuplexCreate, @function
OSTOSDuplexCreate:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3

	jal  OSDuplexCreate

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3
	mov  long [s17 + 8], a1 # t2

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSDuplexCreate, . - OSTOSDuplexCreate

.globl OSTOSCheckPermission
.type OSTOSCheckPermission, @function
OSTOSCheckPermission:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSCheckPermission

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSCheckPermission, . - OSTOSCheckPermission

.globl OSTOSGrantPermission
.type OSTOSGrantPermission, @function
OSTOSGrantPermission:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2

	jal  OSGrantPermission

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSGrantPermission, . - OSTOSGrantPermission

.globl OSTOSPortCreate
.type OSTOSPortCreate, @function
OSTOSPortCreate:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	jal  OSPortCreate

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSPortCreate, . - OSTOSPortCreate

.globl OSTOSPortConnectRelative
.type OSTOSPortConnectRelative, @function
OSTOSPortConnectRelative:	subi sp, sp, 8
	mov  long [sp + 4], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	mov  t0, long [s17 + 20] # t5
	mov  long [sp + 0], t0

	jal  OSPortConnectRelative

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 4]
	addi sp, sp, 8
	jalr zero, lr, 0

.size OSTOSPortConnectRelative, . - OSTOSPortConnectRelative

.globl OSTOSPortAccept
.type OSTOSPortAccept, @function
OSTOSPortAccept:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	jal  OSPortAccept

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSPortAccept, . - OSTOSPortAccept

.globl OSTOSPortSendAndWaitReceive
.type OSTOSPortSendAndWaitReceive, @function
OSTOSPortSendAndWaitReceive:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	jal  OSPortSendAndWaitReceive

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSPortSendAndWaitReceive, . - OSTOSPortSendAndWaitReceive

.globl OSTOSPortSendAndWaitReply
.type OSTOSPortSendAndWaitReply, @function
OSTOSPortSendAndWaitReply:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3
	mov  a3, long [s17 + 16] # t4

	jal  OSPortSendAndWaitReply

	mov  long [s17 + 16], a3 # t4

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSPortSendAndWaitReply, . - OSTOSPortSendAndWaitReply

.globl OSTOSPortOpenProcessByClientID
.type OSTOSPortOpenProcessByClientID, @function
OSTOSPortOpenProcessByClientID:	subi sp, sp, 4
	mov  long [sp + 0], lr
	mov  a0, long [s17 + 4] # t1
	mov  a1, long [s17 + 8] # t2
	mov  a2, long [s17 + 12] # t3

	jal  OSPortOpenProcessByClientID

	mov  long [s17 + 16], a3 # t4
	mov  long [s17 + 12], a2 # t3

	mov  lr, long [sp + 0]
	addi sp, sp, 4
	jalr zero, lr, 0

.size OSTOSPortOpenProcessByClientID, . - OSTOSPortOpenProcessByClientID
