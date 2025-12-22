extern PS2SetupDPC { device func context -- }
extern PS2WriteByte { device value timeout maxattempts -- ok }
extern PS2Command { device command sbuf snum rbuf rnum -- ok }
extern PS2ReadByte { device -- ok value }
