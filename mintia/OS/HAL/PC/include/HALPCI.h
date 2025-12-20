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

extern HALPCIEnumerate { func vendor devid revision class interface -- count }

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
