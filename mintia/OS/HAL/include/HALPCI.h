struct HALPCIDevice
    2 VendorI
    2 DeviceI
    2 ClassI
    1 RevisionB
    1 InterfaceB
    1 BusB
    1 SlotB
    1 FunctionB
endstruct

fnptr HALPCICallbackF { device -- }

const PCICOMMAND 0x04
const PCICOMMANDIO   0x0001
const PCICOMMANDMEM  0x0002
const PCICOMMANDDMA  0x0004
const PCICOMMANDNIRQ 0x0400

const PCISTATUS 0x06
const PCISTATUSCAPABILITIES 0x0010

extern HALPCIEnumerate { func vendor devid revision class interface -- count }

extern HALPCIGetInterrupt { device -- irq ok }
extern HALPCIGetIOBAR { device idx -- base ok }
extern HALPCIGetMemoryBAR { device idx -- phyaddr size ok }

extern HALPCIInb { port -- value }
extern HALPCIIni { port -- value }
extern HALPCIInl { port -- value }

extern HALPCIOutb { value port -- }
extern HALPCIOuti { value port -- }
extern HALPCIOutl { value port -- }

extern HALPCIReadb { device offset -- value }
extern HALPCIReadi { device offset -- value }
extern HALPCIReadl { device offset -- value }

extern HALPCIWriteb { device offset value -- }
extern HALPCIWritei { device offset value -- }
extern HALPCIWritel { device offset value -- }

extern HALPCIReadRawb { bus slot func offset -- value }
extern HALPCIReadRawi { bus slot func offset -- value }
extern HALPCIReadRawl { bus slot func offset -- value }

extern HALPCIWriteRawb { bus slot func offset value -- }
extern HALPCIWriteRawi { bus slot func offset value -- }
extern HALPCIWriteRawl { bus slot func offset value -- }

fnptr HALPCIEnumerateF { func vendor devid revision class interface -- count }

externptr HALPCIEnumerateFunction
