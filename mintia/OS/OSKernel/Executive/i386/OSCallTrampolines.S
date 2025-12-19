# AUTOMATICALLY GENERATED -- DO NOT EDIT

.section "PAGE$text", "ax", %progbits

.globl OSCallCount
.type OSCallCount, @object
OSCallCount: .long 123
.size OSCallCount, . - OSCallCount

.globl OSCallTable
.type OSCallTable, @object
OSCallTable:
	.long 0                                                # 0
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
OSTOSConsolePutCharacter:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)

	call OSConsolePutCharacter

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSConsolePutCharacter, . - OSTOSConsolePutCharacter

.globl OSTOSSystemAbort
.type OSTOSSystemAbort, @function
OSTOSSystemAbort:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 8(%esp)

	call OSSystemAbort

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSSystemAbort, . - OSTOSSystemAbort

.globl OSTOSGetBootFlags
.type OSTOSGetBootFlags, @function
OSTOSGetBootFlags:
	sub $12, %esp

	lea 4(%esp), %eax
	mov %eax, 0(%esp)

	call OSGetBootFlags

	mov 0(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 4(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $8, %esp
	ret
.size OSTOSGetBootFlags, . - OSTOSGetBootFlags

.globl OSTOSContinue
.type OSTOSContinue, @function
OSTOSContinue:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 8(%esp)

	call OSContinue

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSContinue, . - OSTOSContinue

.globl OSTOSQueryTime
.type OSTOSQueryTime, @function
OSTOSQueryTime:
	sub $12, %esp

	lea 4(%esp), %eax
	mov %eax, 0(%esp)

	call OSQueryTime

	mov 0(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 4(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $8, %esp
	ret
.size OSTOSQueryTime, . - OSTOSQueryTime

.globl OSTOSQueryUptime
.type OSTOSQueryUptime, @function
OSTOSQueryUptime:
	sub $12, %esp

	lea 4(%esp), %eax
	mov %eax, 0(%esp)

	call OSQueryUptime

	mov 0(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 4(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $8, %esp
	ret
.size OSTOSQueryUptime, . - OSTOSQueryUptime

.globl OSTOSTimeZoneGet
.type OSTOSTimeZoneGet, @function
OSTOSTimeZoneGet:
	sub $12, %esp

	lea 4(%esp), %eax
	mov %eax, 0(%esp)

	call OSTimeZoneGet

	mov 0(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 4(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $8, %esp
	ret
.size OSTOSTimeZoneGet, . - OSTOSTimeZoneGet

.globl OSTOSTimeZoneSet
.type OSTOSTimeZoneSet, @function
OSTOSTimeZoneSet:
	sub $28, %esp

	lea 8(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)

	call OSTimeZoneSet

	mov 4(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 8(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSTimeZoneSet, . - OSTOSTimeZoneSet

.globl OSTOSTimeSet
.type OSTOSTimeSet, @function
OSTOSTimeSet:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSTimeSet

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSTimeSet, . - OSTOSTimeSet

.globl OSTOSShutdownSystem
.type OSTOSShutdownSystem, @function
OSTOSShutdownSystem:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)

	call OSShutdownSystem

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSShutdownSystem, . - OSTOSShutdownSystem

.globl OSTOSVersion
.type OSTOSVersion, @function
OSTOSVersion:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)

	call OSVersion

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSVersion, . - OSTOSVersion

.globl OSTOSEventCreate
.type OSTOSEventCreate, @function
OSTOSEventCreate:
	sub $28, %esp

	lea 20(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 12(%esp)
	mov 16(%esi), %eax # %edi
	mov %eax, 16(%esp)

	call OSEventCreate

	mov 16(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 20(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSEventCreate, . - OSTOSEventCreate

.globl OSTOSEventReset
.type OSTOSEventReset, @function
OSTOSEventReset:
	sub $28, %esp

	lea 8(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)

	call OSEventReset

	mov 4(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 8(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSEventReset, . - OSTOSEventReset

.globl OSTOSEventSignal
.type OSTOSEventSignal, @function
OSTOSEventSignal:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)

	call OSEventSignal

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSEventSignal, . - OSTOSEventSignal

.globl OSTOSEventPulse
.type OSTOSEventPulse, @function
OSTOSEventPulse:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)

	call OSEventPulse

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSEventPulse, . - OSTOSEventPulse

.globl OSTOSEventReadState
.type OSTOSEventReadState, @function
OSTOSEventReadState:
	sub $28, %esp

	lea 8(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)

	call OSEventReadState

	mov 4(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 8(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSEventReadState, . - OSTOSEventReadState

.globl OSTOSSemaphoreCreate
.type OSTOSSemaphoreCreate, @function
OSTOSSemaphoreCreate:
	sub $28, %esp

	lea 16(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 12(%esp)

	call OSSemaphoreCreate

	mov 12(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 16(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSSemaphoreCreate, . - OSTOSSemaphoreCreate

.globl OSTOSSemaphoreRelease
.type OSTOSSemaphoreRelease, @function
OSTOSSemaphoreRelease:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSSemaphoreRelease

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSSemaphoreRelease, . - OSTOSSemaphoreRelease

.globl OSTOSSemaphoreReadState
.type OSTOSSemaphoreReadState, @function
OSTOSSemaphoreReadState:
	sub $28, %esp

	lea 8(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)

	call OSSemaphoreReadState

	mov 4(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 8(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSSemaphoreReadState, . - OSTOSSemaphoreReadState

.globl OSTOSMutexCreate
.type OSTOSMutexCreate, @function
OSTOSMutexCreate:
	sub $28, %esp

	lea 12(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)

	call OSMutexCreate

	mov 8(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 12(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSMutexCreate, . - OSTOSMutexCreate

.globl OSTOSMutexRelease
.type OSTOSMutexRelease, @function
OSTOSMutexRelease:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)

	call OSMutexRelease

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSMutexRelease, . - OSTOSMutexRelease

.globl OSTOSMutexReadState
.type OSTOSMutexReadState, @function
OSTOSMutexReadState:
	sub $28, %esp

	lea 8(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)

	call OSMutexReadState

	mov 4(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 8(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSMutexReadState, . - OSTOSMutexReadState

.globl OSTOSTimerCreate
.type OSTOSTimerCreate, @function
OSTOSTimerCreate:
	sub $28, %esp

	lea 12(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)

	call OSTimerCreate

	mov 8(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 12(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSTimerCreate, . - OSTOSTimerCreate

.globl OSTOSTimerReset
.type OSTOSTimerReset, @function
OSTOSTimerReset:
	sub $28, %esp

	lea 8(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)

	call OSTimerReset

	mov 4(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 8(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSTimerReset, . - OSTOSTimerReset

.globl OSTOSTimerEnqueue
.type OSTOSTimerEnqueue, @function
OSTOSTimerEnqueue:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSTimerEnqueue

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSTimerEnqueue, . - OSTOSTimerEnqueue

.globl OSTOSTimerDequeue
.type OSTOSTimerDequeue, @function
OSTOSTimerDequeue:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)

	call OSTimerDequeue

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSTimerDequeue, . - OSTOSTimerDequeue

.globl OSTOSTimerReadState
.type OSTOSTimerReadState, @function
OSTOSTimerReadState:
	sub $28, %esp

	lea 8(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)

	call OSTimerReadState

	mov 4(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 8(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSTimerReadState, . - OSTOSTimerReadState

.globl OSTOSGetStatistics
.type OSTOSGetStatistics, @function
OSTOSGetStatistics:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)

	call OSGetStatistics

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSGetStatistics, . - OSTOSGetStatistics

.globl OSTOSNvramVariableQuery
.type OSTOSNvramVariableQuery, @function
OSTOSNvramVariableQuery:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)

	call OSNvramVariableQuery

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSNvramVariableQuery, . - OSTOSNvramVariableQuery

.globl OSTOSNvramVariableSet
.type OSTOSNvramVariableSet, @function
OSTOSNvramVariableSet:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSNvramVariableSet

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSNvramVariableSet, . - OSTOSNvramVariableSet

.globl OSTOSNvramVariableRead
.type OSTOSNvramVariableRead, @function
OSTOSNvramVariableRead:
	sub $28, %esp

	lea 12(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)

	call OSNvramVariableRead

	mov 8(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 12(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSNvramVariableRead, . - OSTOSNvramVariableRead

.globl OSTOSIsComputerOn
.type OSTOSIsComputerOn, @function
OSTOSIsComputerOn:
	sub $12, %esp

	lea 4(%esp), %eax
	mov %eax, 0(%esp)

	call OSIsComputerOn

	mov 0(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 4(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $8, %esp
	ret
.size OSTOSIsComputerOn, . - OSTOSIsComputerOn

.globl OSTOSIsComputerOnFire
.type OSTOSIsComputerOnFire, @function
OSTOSIsComputerOnFire:
	sub $12, %esp

	lea 4(%esp), %eax
	mov %eax, 0(%esp)

	call OSIsComputerOnFire

	mov 0(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 4(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $8, %esp
	ret
.size OSTOSIsComputerOnFire, . - OSTOSIsComputerOnFire

.globl OSTOSOpenRelative
.type OSTOSOpenRelative, @function
OSTOSOpenRelative:
	sub $44, %esp

	lea 28(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 12(%esp)
	mov 16(%esi), %eax # %edi
	mov %eax, 16(%esp)
	mov 20(%esi), %eax # %ebx
	mov %eax, 20(%esp)
	mov 24(%esi), %eax # %ebp
	mov %eax, 24(%esp)

	call OSOpenRelative

	mov 24(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 28(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $40, %esp
	ret
.size OSTOSOpenRelative, . - OSTOSOpenRelative

.globl OSTOSClose
.type OSTOSClose, @function
OSTOSClose:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)

	call OSClose

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSClose, . - OSTOSClose

.globl OSTOSQuery
.type OSTOSQuery, @function
OSTOSQuery:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSQuery

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSQuery, . - OSTOSQuery

.globl OSTOSWaitForMultipleObjects
.type OSTOSWaitForMultipleObjects, @function
OSTOSWaitForMultipleObjects:
	sub $28, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 8(%esp)
	mov 16(%esi), %eax # %edi
	mov %eax, 12(%esp)
	mov 20(%esi), %eax # %ebx
	mov %eax, 16(%esp)

	call OSWaitForMultipleObjects

	mov %eax, 0(%esi) # %eax

	add $28, %esp
	ret
.size OSTOSWaitForMultipleObjects, . - OSTOSWaitForMultipleObjects

.globl OSTOSWaitForObject
.type OSTOSWaitForObject, @function
OSTOSWaitForObject:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 8(%esp)

	call OSWaitForObject

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSWaitForObject, . - OSTOSWaitForObject

.globl OSTOSHandleDuplicate
.type OSTOSHandleDuplicate, @function
OSTOSHandleDuplicate:
	sub $28, %esp

	lea 20(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 12(%esp)
	mov 16(%esi), %eax # %edi
	mov %eax, 16(%esp)

	call OSHandleDuplicate

	mov 16(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 20(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSHandleDuplicate, . - OSTOSHandleDuplicate

.globl OSTOSObjectDirectoryCountQuery
.type OSTOSObjectDirectoryCountQuery, @function
OSTOSObjectDirectoryCountQuery:
	sub $28, %esp

	lea 8(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)

	call OSObjectDirectoryCountQuery

	mov 4(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 8(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSObjectDirectoryCountQuery, . - OSTOSObjectDirectoryCountQuery

.globl OSTOSObjectDirectoryQueryAll
.type OSTOSObjectDirectoryQueryAll, @function
OSTOSObjectDirectoryQueryAll:
	sub $28, %esp

	lea 16(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 12(%esp)

	call OSObjectDirectoryQueryAll

	mov 12(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 16(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSObjectDirectoryQueryAll, . - OSTOSObjectDirectoryQueryAll

.globl OSTOSObjectDirectoryCreate
.type OSTOSObjectDirectoryCreate, @function
OSTOSObjectDirectoryCreate:
	sub $28, %esp

	lea 12(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)

	call OSObjectDirectoryCreate

	mov 8(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 12(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSObjectDirectoryCreate, . - OSTOSObjectDirectoryCreate

.globl OSTOSObjectDirectoryInsert
.type OSTOSObjectDirectoryInsert, @function
OSTOSObjectDirectoryInsert:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSObjectDirectoryInsert

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSObjectDirectoryInsert, . - OSTOSObjectDirectoryInsert

.globl OSTOSObjectDirectoryRemove
.type OSTOSObjectDirectoryRemove, @function
OSTOSObjectDirectoryRemove:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)

	call OSObjectDirectoryRemove

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSObjectDirectoryRemove, . - OSTOSObjectDirectoryRemove

.globl OSTOSSetSecurity
.type OSTOSSetSecurity, @function
OSTOSSetSecurity:
	sub $28, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 8(%esp)
	mov 16(%esi), %eax # %edi
	mov %eax, 12(%esp)

	call OSSetSecurity

	mov %eax, 0(%esi) # %eax

	add $28, %esp
	ret
.size OSTOSSetSecurity, . - OSTOSSetSecurity

.globl OSTSysCreateRelative
.type OSTSysCreateRelative, @function
OSTSysCreateRelative:
	sub $44, %esp

	lea 28(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 12(%esp)
	mov 16(%esi), %eax # %edi
	mov %eax, 16(%esp)
	mov 20(%esi), %eax # %ebx
	mov %eax, 20(%esp)
	mov 24(%esi), %eax # %ebp
	mov %eax, 24(%esp)

	call SysCreateRelative

	mov 24(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 28(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $40, %esp
	ret
.size OSTSysCreateRelative, . - OSTSysCreateRelative

.globl OSTOSFileQuery
.type OSTOSFileQuery, @function
OSTOSFileQuery:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSFileQuery

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSFileQuery, . - OSTOSFileQuery

.globl OSTOSFileTruncate
.type OSTOSFileTruncate, @function
OSTOSFileTruncate:
	sub $28, %esp

	lea 16(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 12(%esp)

	call OSFileTruncate

	mov 12(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 16(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSFileTruncate, . - OSTOSFileTruncate

.globl OSTOSFileSeek
.type OSTOSFileSeek, @function
OSTOSFileSeek:
	sub $28, %esp

	lea 16(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 12(%esp)

	call OSFileSeek

	mov 12(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 16(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSFileSeek, . - OSTOSFileSeek

.globl OSTOSFileRead
.type OSTOSFileRead, @function
OSTOSFileRead:
	sub $44, %esp

	lea 24(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 12(%esp)
	mov 16(%esi), %eax # %edi
	mov %eax, 16(%esp)
	mov 20(%esi), %eax # %ebx
	mov %eax, 20(%esp)

	call OSFileRead

	mov 20(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 24(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $40, %esp
	ret
.size OSTOSFileRead, . - OSTOSFileRead

.globl OSTOSFileWrite
.type OSTOSFileWrite, @function
OSTOSFileWrite:
	sub $28, %esp

	lea 20(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 12(%esp)
	mov 16(%esi), %eax # %edi
	mov %eax, 16(%esp)

	call OSFileWrite

	mov 16(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 20(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSFileWrite, . - OSTOSFileWrite

.globl OSTOSFileFlush
.type OSTOSFileFlush, @function
OSTOSFileFlush:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSFileFlush

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSFileFlush, . - OSTOSFileFlush

.globl OSTOSFileSetInformation
.type OSTOSFileSetInformation, @function
OSTOSFileSetInformation:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSFileSetInformation

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSFileSetInformation, . - OSTOSFileSetInformation

.globl OSTOSFileReadAsync
.type OSTOSFileReadAsync, @function
OSTOSFileReadAsync:
	sub $28, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 8(%esp)
	mov 16(%esi), %eax # %edi
	mov %eax, 12(%esp)
	mov 20(%esi), %eax # %ebx
	mov %eax, 16(%esp)
	mov 24(%esi), %eax # %ebp
	mov %eax, 20(%esp)

	call OSFileReadAsync

	mov %eax, 0(%esi) # %eax

	add $28, %esp
	ret
.size OSTOSFileReadAsync, . - OSTOSFileReadAsync

.globl OSTOSFileWriteAsync
.type OSTOSFileWriteAsync, @function
OSTOSFileWriteAsync:
	sub $28, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 8(%esp)
	mov 16(%esi), %eax # %edi
	mov %eax, 12(%esp)
	mov 20(%esi), %eax # %ebx
	mov %eax, 16(%esp)
	mov 24(%esi), %eax # %ebp
	mov %eax, 20(%esp)

	call OSFileWriteAsync

	mov %eax, 0(%esi) # %eax

	add $28, %esp
	ret
.size OSTOSFileWriteAsync, . - OSTOSFileWriteAsync

.globl OSTOSFileCancelIO
.type OSTOSFileCancelIO, @function
OSTOSFileCancelIO:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSFileCancelIO

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSFileCancelIO, . - OSTOSFileCancelIO

.globl OSTOSDirectoryRename
.type OSTOSDirectoryRename, @function
OSTOSDirectoryRename:
	sub $28, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 8(%esp)
	mov 16(%esi), %eax # %edi
	mov %eax, 12(%esp)

	call OSDirectoryRename

	mov %eax, 0(%esi) # %eax

	add $28, %esp
	ret
.size OSTOSDirectoryRename, . - OSTOSDirectoryRename

.globl OSTOSDirectoryUnlink
.type OSTOSDirectoryUnlink, @function
OSTOSDirectoryUnlink:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSDirectoryUnlink

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSDirectoryUnlink, . - OSTOSDirectoryUnlink

.globl OSTOSDirectoryRead
.type OSTOSDirectoryRead, @function
OSTOSDirectoryRead:
	sub $28, %esp

	lea 16(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 12(%esp)

	call OSDirectoryRead

	mov 12(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 16(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSDirectoryRead, . - OSTOSDirectoryRead

.globl OSTOSPageFileCreateRelative
.type OSTOSPageFileCreateRelative, @function
OSTOSPageFileCreateRelative:
	sub $28, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 8(%esp)
	mov 16(%esi), %eax # %edi
	mov %eax, 12(%esp)
	mov 20(%esi), %eax # %ebx
	mov %eax, 16(%esp)

	call OSPageFileCreateRelative

	mov %eax, 0(%esi) # %eax

	add $28, %esp
	ret
.size OSTOSPageFileCreateRelative, . - OSTOSPageFileCreateRelative

.globl OSTOSPageFileQuery
.type OSTOSPageFileQuery, @function
OSTOSPageFileQuery:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSPageFileQuery

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSPageFileQuery, . - OSTOSPageFileQuery

.globl OSTOSIOControl
.type OSTOSIOControl, @function
OSTOSIOControl:
	sub $28, %esp

	lea 16(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 12(%esp)

	call OSIOControl

	mov 12(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 16(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSIOControl, . - OSTOSIOControl

.globl OSTOSGetBootDevicePath
.type OSTOSGetBootDevicePath, @function
OSTOSGetBootDevicePath:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)

	call OSGetBootDevicePath

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSGetBootDevicePath, . - OSTOSGetBootDevicePath

.globl OSTOSFilesystemMount
.type OSTOSFilesystemMount, @function
OSTOSFilesystemMount:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 8(%esp)

	call OSFilesystemMount

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSFilesystemMount, . - OSTOSFilesystemMount

.globl OSTOSFilesystemUnmount
.type OSTOSFilesystemUnmount, @function
OSTOSFilesystemUnmount:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)

	call OSFilesystemUnmount

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSFilesystemUnmount, . - OSTOSFilesystemUnmount

.globl OSTOSMountQueryAll
.type OSTOSMountQueryAll, @function
OSTOSMountQueryAll:
	sub $28, %esp

	lea 12(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)

	call OSMountQueryAll

	mov 8(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 12(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSMountQueryAll, . - OSTOSMountQueryAll

.globl OSTOSMountCountQuery
.type OSTOSMountCountQuery, @function
OSTOSMountCountQuery:
	sub $12, %esp

	lea 4(%esp), %eax
	mov %eax, 0(%esp)

	call OSMountCountQuery

	mov 0(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 4(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $8, %esp
	ret
.size OSTOSMountCountQuery, . - OSTOSMountCountQuery

.globl OSTOSMountUpdateFlags
.type OSTOSMountUpdateFlags, @function
OSTOSMountUpdateFlags:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSMountUpdateFlags

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSMountUpdateFlags, . - OSTOSMountUpdateFlags

.globl OSTOSMountGetFilesystemName
.type OSTOSMountGetFilesystemName, @function
OSTOSMountGetFilesystemName:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSMountGetFilesystemName

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSMountGetFilesystemName, . - OSTOSMountGetFilesystemName

.globl OSTOSMountSet
.type OSTOSMountSet, @function
OSTOSMountSet:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSMountSet

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSMountSet, . - OSTOSMountSet

.globl OSTOSFlushModifiedPages
.type OSTOSFlushModifiedPages, @function
OSTOSFlushModifiedPages:
	sub $12, %esp

	call OSFlushModifiedPages

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSFlushModifiedPages, . - OSTOSFlushModifiedPages

.globl OSTOSSectionCreate
.type OSTOSSectionCreate, @function
OSTOSSectionCreate:
	sub $28, %esp

	lea 16(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 12(%esp)

	call OSSectionCreate

	mov 12(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 16(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSSectionCreate, . - OSTOSSectionCreate

.globl OSTOSMapView
.type OSTOSMapView, @function
OSTOSMapView:
	sub $44, %esp

	lea 32(%esp), %eax
	mov %eax, 0(%esp)

	sub $16, %esp
	mov $28, 0(%esp)
	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	lea 20(%esp), %eax
	mov %eax, 8(%esp)
	call KeSafeCopyIn
	add $16, %esp
	test %eax, %eax
	jnz 1f

	call OSMapView

	mov 28(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 32(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $40, %esp
	ret

1:	mov %eax, 8(%esi) # %ecx

	add $44, %esp
	ret
.size OSTOSMapView, . - OSTOSMapView

.globl OSTOSUnmapView
.type OSTOSUnmapView, @function
OSTOSUnmapView:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 8(%esp)

	call OSUnmapView

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSUnmapView, . - OSTOSUnmapView

.globl OSTOSRemapView
.type OSTOSRemapView, @function
OSTOSRemapView:
	sub $28, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 8(%esp)
	mov 16(%esi), %eax # %edi
	mov %eax, 12(%esp)

	call OSRemapView

	mov %eax, 0(%esi) # %eax

	add $28, %esp
	ret
.size OSTOSRemapView, . - OSTOSRemapView

.globl OSTOSFlushView
.type OSTOSFlushView, @function
OSTOSFlushView:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 8(%esp)

	call OSFlushView

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSFlushView, . - OSTOSFlushView

.globl OSTOSAllocate
.type OSTOSAllocate, @function
OSTOSAllocate:
	sub $44, %esp

	lea 24(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 12(%esp)
	mov 16(%esi), %eax # %edi
	mov %eax, 16(%esp)
	mov 20(%esi), %eax # %ebx
	mov %eax, 20(%esp)

	call OSAllocate

	mov 20(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 24(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $40, %esp
	ret
.size OSTOSAllocate, . - OSTOSAllocate

.globl OSTOSMemoryQuery
.type OSTOSMemoryQuery, @function
OSTOSMemoryQuery:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)

	call OSMemoryQuery

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSMemoryQuery, . - OSTOSMemoryQuery

.globl OSTOSWorkingSetPurge
.type OSTOSWorkingSetPurge, @function
OSTOSWorkingSetPurge:
	sub $12, %esp

	call OSWorkingSetPurge

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSWorkingSetPurge, . - OSTOSWorkingSetPurge

.globl OSTOSSynchronizeIcache
.type OSTOSSynchronizeIcache, @function
OSTOSSynchronizeIcache:
	sub $12, %esp

	call OSSynchronizeIcache

	add $12, %esp
	ret
.size OSTOSSynchronizeIcache, . - OSTOSSynchronizeIcache

.globl OSTOSProcessCreate
.type OSTOSProcessCreate, @function
OSTOSProcessCreate:
	sub $44, %esp

	lea 24(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 12(%esp)
	mov 16(%esi), %eax # %edi
	mov %eax, 16(%esp)
	mov 20(%esi), %eax # %ebx
	mov %eax, 20(%esp)

	call OSProcessCreate

	mov 20(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 24(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $40, %esp
	ret
.size OSTOSProcessCreate, . - OSTOSProcessCreate

.globl OSTOSProcessSignal
.type OSTOSProcessSignal, @function
OSTOSProcessSignal:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSProcessSignal

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSProcessSignal, . - OSTOSProcessSignal

.globl OSTOSProcessOpenByPID
.type OSTOSProcessOpenByPID, @function
OSTOSProcessOpenByPID:
	sub $28, %esp

	lea 12(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)

	call OSProcessOpenByPID

	mov 8(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 12(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSProcessOpenByPID, . - OSTOSProcessOpenByPID

.globl OSTOSProcessQuery
.type OSTOSProcessQuery, @function
OSTOSProcessQuery:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSProcessQuery

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSProcessQuery, . - OSTOSProcessQuery

.globl OSTOSProcessQueryByPID
.type OSTOSProcessQueryByPID, @function
OSTOSProcessQueryByPID:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSProcessQueryByPID

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSProcessQueryByPID, . - OSTOSProcessQueryByPID

.globl OSTOSProcessReadStatus
.type OSTOSProcessReadStatus, @function
OSTOSProcessReadStatus:
	sub $28, %esp

	lea 8(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)

	call OSProcessReadStatus

	mov 4(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 8(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSProcessReadStatus, . - OSTOSProcessReadStatus

.globl OSTOSProcessSetConsoleGroup
.type OSTOSProcessSetConsoleGroup, @function
OSTOSProcessSetConsoleGroup:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSProcessSetConsoleGroup

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSProcessSetConsoleGroup, . - OSTOSProcessSetConsoleGroup

.globl OSTOSProcessBasePrioritySet
.type OSTOSProcessBasePrioritySet, @function
OSTOSProcessBasePrioritySet:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSProcessBasePrioritySet

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSProcessBasePrioritySet, . - OSTOSProcessBasePrioritySet

.globl OSTOSProcessSignalActivation
.type OSTOSProcessSignalActivation, @function
OSTOSProcessSignalActivation:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)

	call OSProcessSignalActivation

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSProcessSignalActivation, . - OSTOSProcessSignalActivation

.globl OSTOSProcessWaitForActivation
.type OSTOSProcessWaitForActivation, @function
OSTOSProcessWaitForActivation:
	sub $28, %esp

	lea 12(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)

	call OSProcessWaitForActivation

	mov 8(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 12(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSProcessWaitForActivation, . - OSTOSProcessWaitForActivation

.globl OSTOSProcessExit
.type OSTOSProcessExit, @function
OSTOSProcessExit:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)

	call OSProcessExit

	add $12, %esp
	ret
.size OSTOSProcessExit, . - OSTOSProcessExit

.globl OSTOSProcessCountQuery
.type OSTOSProcessCountQuery, @function
OSTOSProcessCountQuery:
	sub $12, %esp

	lea 4(%esp), %eax
	mov %eax, 0(%esp)

	call OSProcessCountQuery

	mov 0(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 4(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $8, %esp
	ret
.size OSTOSProcessCountQuery, . - OSTOSProcessCountQuery

.globl OSTOSProcessQueryAll
.type OSTOSProcessQueryAll, @function
OSTOSProcessQueryAll:
	sub $28, %esp

	lea 12(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)

	call OSProcessQueryAll

	mov 8(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 12(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSProcessQueryAll, . - OSTOSProcessQueryAll

.globl OSTOSSetQuota
.type OSTOSSetQuota, @function
OSTOSSetQuota:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSSetQuota

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSSetQuota, . - OSTOSSetQuota

.globl OSTOSQuotaQuery
.type OSTOSQuotaQuery, @function
OSTOSQuotaQuery:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSQuotaQuery

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSQuotaQuery, . - OSTOSQuotaQuery

.globl OSTOSThreadGetExceptionStatus
.type OSTOSThreadGetExceptionStatus, @function
OSTOSThreadGetExceptionStatus:
	sub $12, %esp

	call OSThreadGetExceptionStatus

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSThreadGetExceptionStatus, . - OSTOSThreadGetExceptionStatus

.globl OSTOSThreadSleep
.type OSTOSThreadSleep, @function
OSTOSThreadSleep:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)

	call OSThreadSleep

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSThreadSleep, . - OSTOSThreadSleep

.globl OSTOSThreadSleepEx
.type OSTOSThreadSleepEx, @function
OSTOSThreadSleepEx:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSThreadSleepEx

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSThreadSleepEx, . - OSTOSThreadSleepEx

.globl OSTOSThreadCreate
.type OSTOSThreadCreate, @function
OSTOSThreadCreate:
	sub $44, %esp

	lea 28(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 12(%esp)
	mov 16(%esi), %eax # %edi
	mov %eax, 16(%esp)
	mov 20(%esi), %eax # %ebx
	mov %eax, 20(%esp)
	mov 24(%esi), %eax # %ebp
	mov %eax, 24(%esp)

	call OSThreadCreate

	mov 24(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 28(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $40, %esp
	ret
.size OSTOSThreadCreate, . - OSTOSThreadCreate

.globl OSTOSThreadTerminate
.type OSTOSThreadTerminate, @function
OSTOSThreadTerminate:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSThreadTerminate

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSThreadTerminate, . - OSTOSThreadTerminate

.globl OSTOSThreadSuspend
.type OSTOSThreadSuspend, @function
OSTOSThreadSuspend:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)

	call OSThreadSuspend

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSThreadSuspend, . - OSTOSThreadSuspend

.globl OSTOSThreadResume
.type OSTOSThreadResume, @function
OSTOSThreadResume:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)

	call OSThreadResume

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSThreadResume, . - OSTOSThreadResume

.globl OSTOSThreadReadStatus
.type OSTOSThreadReadStatus, @function
OSTOSThreadReadStatus:
	sub $28, %esp

	lea 8(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)

	call OSThreadReadStatus

	mov 4(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 8(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSThreadReadStatus, . - OSTOSThreadReadStatus

.globl OSTOSThreadQuery
.type OSTOSThreadQuery, @function
OSTOSThreadQuery:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSThreadQuery

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSThreadQuery, . - OSTOSThreadQuery

.globl OSTOSThreadSignal
.type OSTOSThreadSignal, @function
OSTOSThreadSignal:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSThreadSignal

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSThreadSignal, . - OSTOSThreadSignal

.globl OSTOSThreadMaskSignal
.type OSTOSThreadMaskSignal, @function
OSTOSThreadMaskSignal:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSThreadMaskSignal

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSThreadMaskSignal, . - OSTOSThreadMaskSignal

.globl OSTOSThreadDeliverOnWaitSignal
.type OSTOSThreadDeliverOnWaitSignal, @function
OSTOSThreadDeliverOnWaitSignal:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSThreadDeliverOnWaitSignal

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSThreadDeliverOnWaitSignal, . - OSTOSThreadDeliverOnWaitSignal

.globl OSTOSJobCreate
.type OSTOSJobCreate, @function
OSTOSJobCreate:
	sub $44, %esp

	lea 24(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 12(%esp)
	mov 16(%esi), %eax # %edi
	mov %eax, 16(%esp)
	mov 20(%esi), %eax # %ebx
	mov %eax, 20(%esp)

	call OSJobCreate

	mov 20(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 24(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $40, %esp
	ret
.size OSTOSJobCreate, . - OSTOSJobCreate

.globl OSTOSJobAddProcess
.type OSTOSJobAddProcess, @function
OSTOSJobAddProcess:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSJobAddProcess

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSJobAddProcess, . - OSTOSJobAddProcess

.globl OSTOSJobRemoveProcess
.type OSTOSJobRemoveProcess, @function
OSTOSJobRemoveProcess:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)

	call OSJobRemoveProcess

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSJobRemoveProcess, . - OSTOSJobRemoveProcess

.globl OSTOSJobSignal
.type OSTOSJobSignal, @function
OSTOSJobSignal:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 8(%esp)

	call OSJobSignal

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSJobSignal, . - OSTOSJobSignal

.globl OSTOSSetSystemConsole
.type OSTOSSetSystemConsole, @function
OSTOSSetSystemConsole:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)

	call OSSetSystemConsole

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSSetSystemConsole, . - OSTOSSetSystemConsole

.globl OSTOSConsoleSignal
.type OSTOSConsoleSignal, @function
OSTOSConsoleSignal:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSConsoleSignal

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSConsoleSignal, . - OSTOSConsoleSignal

.globl OSTOSIsAConsole
.type OSTOSIsAConsole, @function
OSTOSIsAConsole:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)

	call OSIsAConsole

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSIsAConsole, . - OSTOSIsAConsole

.globl OSTOSDuplexCreate
.type OSTOSDuplexCreate, @function
OSTOSDuplexCreate:
	sub $28, %esp

	lea 16(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 12(%esp)

	call OSDuplexCreate

	mov 12(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 16(%esp), %eax
	mov %eax, 8(%esi) # %ecx
	mov 20(%esp), %eax
	mov %eax, 12(%esi) # %esi

	add $24, %esp
	ret
.size OSTOSDuplexCreate, . - OSTOSDuplexCreate

.globl OSTOSCheckPermission
.type OSTOSCheckPermission, @function
OSTOSCheckPermission:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSCheckPermission

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSCheckPermission, . - OSTOSCheckPermission

.globl OSTOSGrantPermission
.type OSTOSGrantPermission, @function
OSTOSGrantPermission:
	sub $12, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)

	call OSGrantPermission

	mov %eax, 0(%esi) # %eax

	add $12, %esp
	ret
.size OSTOSGrantPermission, . - OSTOSGrantPermission

.globl OSTOSPortCreate
.type OSTOSPortCreate, @function
OSTOSPortCreate:
	sub $28, %esp

	lea 20(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 12(%esp)
	mov 16(%esi), %eax # %edi
	mov %eax, 16(%esp)

	call OSPortCreate

	mov 16(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 20(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSPortCreate, . - OSTOSPortCreate

.globl OSTOSPortConnectRelative
.type OSTOSPortConnectRelative, @function
OSTOSPortConnectRelative:
	sub $44, %esp

	lea 24(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 12(%esp)
	mov 16(%esi), %eax # %edi
	mov %eax, 16(%esp)
	mov 20(%esi), %eax # %ebx
	mov %eax, 20(%esp)

	call OSPortConnectRelative

	mov 20(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 24(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $40, %esp
	ret
.size OSTOSPortConnectRelative, . - OSTOSPortConnectRelative

.globl OSTOSPortAccept
.type OSTOSPortAccept, @function
OSTOSPortAccept:
	sub $28, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 8(%esp)
	mov 16(%esi), %eax # %edi
	mov %eax, 12(%esp)

	call OSPortAccept

	mov %eax, 0(%esi) # %eax

	add $28, %esp
	ret
.size OSTOSPortAccept, . - OSTOSPortAccept

.globl OSTOSPortSendAndWaitReceive
.type OSTOSPortSendAndWaitReceive, @function
OSTOSPortSendAndWaitReceive:
	sub $28, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 8(%esp)
	mov 16(%esi), %eax # %edi
	mov %eax, 12(%esp)

	call OSPortSendAndWaitReceive

	mov %eax, 0(%esi) # %eax

	add $28, %esp
	ret
.size OSTOSPortSendAndWaitReceive, . - OSTOSPortSendAndWaitReceive

.globl OSTOSPortSendAndWaitReply
.type OSTOSPortSendAndWaitReply, @function
OSTOSPortSendAndWaitReply:
	sub $28, %esp

	mov 4(%esi), %eax # %edx
	mov %eax, 0(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 4(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 8(%esp)
	mov 16(%esi), %eax # %edi
	mov %eax, 12(%esp)

	call OSPortSendAndWaitReply

	mov %eax, 0(%esi) # %eax

	add $28, %esp
	ret
.size OSTOSPortSendAndWaitReply, . - OSTOSPortSendAndWaitReply

.globl OSTOSPortOpenProcessByClientID
.type OSTOSPortOpenProcessByClientID, @function
OSTOSPortOpenProcessByClientID:
	sub $28, %esp

	lea 16(%esp), %eax
	mov %eax, 0(%esp)

	mov 4(%esi), %eax # %edx
	mov %eax, 4(%esp)
	mov 8(%esi), %eax # %ecx
	mov %eax, 8(%esp)
	mov 12(%esi), %eax # %esi
	mov %eax, 12(%esp)

	call OSPortOpenProcessByClientID

	mov 12(%esp), %eax
	mov %eax, 4(%esi) # %edx
	mov 16(%esp), %eax
	mov %eax, 8(%esi) # %ecx

	add $24, %esp
	ret
.size OSTOSPortOpenProcessByClientID, . - OSTOSPortOpenProcessByClientID
