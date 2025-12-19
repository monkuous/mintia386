local function printhelp()
	print("== gensyscalls.lua ==")
	print("generates syscall stubs and trampolines for MINTIA from a header file.")
	print("usage: gensyscalls.lua [arch] [sysheader] [stubs] [trampolines]")
end

if (#arg < 4) then
	print("argument mismatch")
	printhelp()
	return
end

local arch = arg[1]

local sysheader = io.open(arg[2], "r")

if not sysheader then
	print("failed to open "..arg[2])
	return
end

local stubs

if arg[3] ~= "NO" then
	stubs = io.open(arg[3], "w")

	if not stubs then
		print("failed to open "..arg[3])
		return
	end
end

local trampolines

if arg[4] ~= "NO" then
	trampolines = io.open(arg[4], "w")

	if not trampolines then
		print("failed to open "..arg[4])
		return
	end
end

-- the stubs are for OSDLL.dll to be able to call into the kernel.

-- the trampolines are for the kernel to get the arguments set up properly.
-- they assume the kernel exception handler placed the trapframe in s17.

local function explode(d,p)
    local t, ll
    t={}
    ll=0
    if(#p == 1) then return {p} end
        while true do
            l=string.find(p,d,ll,true) -- find the next d in the string
            if l~=nil then -- if "not not" found then..
                table.insert(t, string.sub(p,ll,l-1)) -- Save it in our array.
                ll=l+1 -- save just after where we found it for searching next time.
            else
                table.insert(t, string.sub(p,ll)) -- Save what's left in our array.
                break -- Break at end, as it should be, according to the lua manual.
            end
        end
    return t
end

local syscalls = {}

local line = sysheader:read("*l")

local sysnumber = 1

while line do
	if line:sub(1,7) == "extern " then
		local syscall = {}

		local linecomp = explode(" ", line)

		syscall.name = linecomp[2]
		syscall.args = {}
		syscall.rets = {}
		syscall.n = sysnumber

		sysnumber = sysnumber + 1

		local i = 4
		local n = 0

		while true do
			if not linecomp[i] then
				error("bad sysheader")
			end

			if linecomp[i] == "--" then
				break
			end

			local sysarg = {}

			sysarg.name = linecomp[i]
			sysarg.n = n

			syscall.args[#syscall.args + 1] = sysarg

			i = i + 1
			n = n + 1
		end

		i = i + 1
		n = 0

		while true do
			if not linecomp[i] then
				error("bad sysheader")
			end

			if linecomp[i] == "}" then
				break
			end

			local sysret = {}

			sysret.name = linecomp[i]
			sysret.n = n

			syscall.rets[#syscall.rets + 1] = sysret

			i = i + 1
		end

		syscalls[#syscalls + 1] = syscall
	end

	line = sysheader:read("*l")
end

local FIRSTREG
local FIRSTSAVED
local LASTREG
local ARGCOUNT
local FIRSTARG
local RETCOUNT

local regnames

if arch == "xr17032" then
	FIRSTREG   = 2
	FIRSTSAVED = 11
	LASTREG    = 27
	ARGCOUNT   = 4
	FIRSTARG   = 7
	RETCOUNT   = 4

	regnames = {
		"t0", "t1", "t2", "t3", "t4", "t5",
		"a0", "a1", "a2", "a3",
		"s0", "s1",
		"s2", "s3",
		"s4", "s5",
		"s6", "s7",
		"s8", "s9",
		"s10", "s11",
		"s12", "s13",
		"s14", "s15",
		"s16",
	}
elseif arch == "i386" then
	FIRSTREG   = 2
	FIRSTSAVED = 4
	LASTREG    = 7

	regnames = {
		"%eax", "%edx", "%ecx", "%esi", "%edi", "%ebx", "%ebp"
	}
else
	print("gensyscalls: unsupported architecture")
	os.exit(1)
end

if stubs then
	stubs:write("# AUTOMATICALLY GENERATED -- DO NOT EDIT\n\n")
	stubs:write(".section \"text\", \"ax\", %progbits\n")
end

if trampolines then
	trampolines:write("# AUTOMATICALLY GENERATED -- DO NOT EDIT\n\n")
	trampolines:write(".section \"PAGE$text\", \"ax\", %progbits\n")
end

if stubs then
	-- generate stubs

	for i = 1, #syscalls do
		local sys = syscalls[i]

		stubs:write(string.format("\n.globl %s\n.type %s, @function\n%s:\n", sys.name, sys.name, sys.name))

		if arch == "xr17032" then
			local savedneeded = math.max(#sys.args, #sys.rets) - FIRSTSAVED + FIRSTREG

			local stackoffset = 0

			if savedneeded > 0 then
				stackoffset = stackoffset + savedneeded*4 + 4

				stubs:write(string.format("\tsubi sp, sp, %d\n", savedneeded*4 + 4))
				stubs:write(string.format("\tmov  long [sp], lr\n"))

				for reg = 0, savedneeded-1 do
					stubs:write(string.format("\tmov  long [sp + %d], %s\n", reg*4 + 4, regnames[reg + FIRSTSAVED]))
				end

				stubs:write("\n")
			end

			local saveoffset = stackoffset
			local regnum = FIRSTREG

			for argn = #sys.args, 1, -1 do
				local sysarg = sys.args[argn]

				if regnum < ARGCOUNT+FIRSTREG then
					stubs:write(string.format("\tadd  %s, %s, zero\n", regnames[regnum], regnames[regnum+FIRSTARG-FIRSTREG]))
				else
					stubs:write(string.format("\tmov  %s, long [sp + %d]\n", regnames[regnum], saveoffset))
					saveoffset = saveoffset + 4
				end

				regnum = regnum + 1
			end

			stubs:write(string.format("\n\taddi  t0, zero, %d\n", sys.n))
			stubs:write("\tsys\n\n")

			regnum = FIRSTREG + RETCOUNT - 1

			for retn = #sys.rets, 1, -1 do
				local sysret = sys.rets[retn]

				if regnum >= FIRSTREG then
					stubs:write(string.format("\tadd  %s, %s, zero\n", regnames[regnum+FIRSTARG-FIRSTREG], regnames[regnum]))
				else
					error(sys.name.." returns via pointer")
				end

				regnum = regnum - 1
			end

			stubs:write("\n")

			if savedneeded > 0 then
				for reg = 0, savedneeded-1 do
					stubs:write(string.format("\tmov  %s, long [sp + %d]\n", regnames[reg + FIRSTSAVED], reg*4 + 4))
				end

				stubs:write(string.format("\taddi sp, sp, %d\n", savedneeded*4 + 4))
			end

			stubs:write("\tjalr zero, lr, 0\n\n")
		elseif arch == "i386" then
			local lastarg = #sys.args - 1
			local lastret = #sys.rets - 1
			local argoffs = 4

			if lastret > 0 then
				argoffs = argoffs + 4
			end

			local lastargreg = lastarg

			if lastargreg > LASTREG - FIRSTREG then
				lastargreg = -1
			end

			local savedneeded = (math.max(lastargreg, lastret) + 1) + FIRSTREG - FIRSTSAVED

			if savedneeded > 0 then
				stubs:write(string.format("\tsub $%d, %%esp\n", savedneeded * 4))
				argoffs = argoffs + savedneeded * 4

				for reg = 0, savedneeded - 1 do
					stubs:write(string.format("\tmov %s, %d(%%esp)\n", regnames[FIRSTSAVED + reg], reg * 4))
				end

				stubs:write("\n")
			end

			if lastarg >= 0 and lastarg <= LASTREG - FIRSTREG then
				for reg = 0, lastarg do
					stubs:write(string.format("\tmov %d(%%esp), %s\n", argoffs + reg * 4, regnames[FIRSTREG + reg]))
				end

				stubs:write("\n")
			elseif lastarg >= 0 then
				stubs:write(string.format("\tlea %d(%%esp), %%edx\n\n", argoffs))
			end

			stubs:write(string.format("\tmov $%d, %%eax\n", sys.n))
			stubs:write("\tint $0x80\n")

			if lastret >= 0 then
				stubs:write("\n")

				stubs:write(string.format("\tmov %d(%%esp), %%eax\n", argoffs - 4))

				for reg = 0, lastret do
					stubs:write(string.format("\tmov %s, %d(%%eax)\n", regnames[FIRSTREG + reg], reg * 4))
				end
			end

			if savedneeded > 0 then
				stubs:write("\n")

				for reg = 0, savedneeded - 1 do
					stubs:write(string.format("\tmov %d(%%esp), %s\n", reg * 4, regnames[FIRSTSAVED + reg]))
				end

				stubs:write(string.format("\tadd $%d, %%esp\n", savedneeded * 4))
			end

			stubs:write("\tret\n")
		end

		if not NATIVEASM then
			stubs:write(string.format(".size %s, . - %s\n", sys.name, sys.name))
		end
	end
end

if trampolines then
	-- generate trampoline table

	trampolines:write(string.format("\n.globl OSCallCount\n.type OSCallCount, @object\nOSCallCount: .long %d\n.size OSCallCount, . - OSCallCount\n", #syscalls))

	trampolines:write("\n.globl OSCallTable\n.type OSCallTable, @object\nOSCallTable:")

	trampolines:write(string.format("\t.long %-48s # 0\n", "0"))

	for i = 1, #syscalls do
		local sys = syscalls[i]

		trampolines:write(string.format("\t.long %-48s # %d\n", "OST"..sys.name, sys.n))
	end

	trampolines:write(".size OSCallTable, . - OSCallTable\n")

	-- generate trampolines

	for i = 1, #syscalls do
		local sys = syscalls[i]

		if NATIVEASM then
			trampolines:write(string.format("OST%s:\n", sys.name))
		else
			trampolines:write(string.format("\n.globl OST%s\n.type OST%s, @function\nOST%s:", sys.name, sys.name, sys.name))
		end

		if arch == "xr17032" then
			local tfoffset = (FIRSTREG-1)*4

			-- move all the arguments from the trapframe to their proper ABI register
			-- or the stack

			local stackneeded = math.max((math.max(#sys.args, #sys.rets) - ARGCOUNT)*4, 0)

			trampolines:write(string.format("\tsubi sp, sp, %d\n", stackneeded + 4))
			trampolines:write(string.format("\tmov  long [sp + %d], lr\n", stackneeded))

			local saveoffset = 0
			local regnum = FIRSTREG

			for argn = #sys.args, 1, -1 do
				local sysarg = sys.args[argn]

				if regnum < ARGCOUNT+FIRSTREG then
					trampolines:write(string.format("\tmov  %s, long [s17 + %d] # %s\n", regnames[regnum+FIRSTARG-FIRSTREG], tfoffset, regnames[tfoffset/4+1]))
				else
					trampolines:write(string.format("\n\tmov  t0, long [s17 + %d] # %s\n", tfoffset, regnames[tfoffset/4+1]))
					trampolines:write(string.format("\tmov  long [sp + %d], t0\n", saveoffset))
					saveoffset = saveoffset + 4
				end

				tfoffset = tfoffset + 4
				regnum = regnum + 1
			end

			trampolines:write(string.format("\n\tjal  %s\n\n", sys.name))

			regnum = FIRSTREG + RETCOUNT - 1

			tfoffset = (regnum-1)*4

			for retn = 1, #sys.rets do
				local sysret = sys.rets[retn]

				if regnum >= FIRSTREG then
					trampolines:write(string.format("\tmov  long [s17 + %d], %s # %s\n", tfoffset, regnames[regnum+FIRSTARG-FIRSTREG], regnames[tfoffset/4+1]))
				else
					error(sys.name.." returns via pointer")
				end

				tfoffset = tfoffset - 4
				regnum = regnum - 1
			end

			trampolines:write("\n")

			trampolines:write(string.format("\tmov  lr, long [sp + %d]\n", stackneeded))
			trampolines:write(string.format("\taddi sp, sp, %d\n", stackneeded + 4))
			trampolines:write("\tjalr zero, lr, 0\n\n")
		elseif arch == "i386" then
			local realargs = #sys.args
			local retsize = 0

			if #sys.rets > 1 then
				realargs = realargs + 1
				retsize = #sys.rets * 4
			end

			local retoffs = realargs * 4
			local framesize = band((retoffs + retsize + 4 + 15), -16) - 4
			trampolines:write(string.format("\tsub $%d, %%esp\n\n", framesize))

			local argoffs = 0

			if #sys.rets > 1 then
				trampolines:write(string.format("\tlea %d(%%esp), %%eax\n", retoffs))
				trampolines:write(string.format("\tmov %%eax, 0(%%esp)\n\n"))
				argoffs = 4
			end

			local lastarg = #sys.args - 1

			if lastarg >= 0 and lastarg <= LASTREG - FIRSTREG then
				for reg = 0, lastarg do
					trampolines:write(string.format("\tmov %d(%%esi), %%eax # %s\n", (reg + FIRSTREG - 1) * 4), regnames[reg + FIRSTREG])
					trampolines:write(string.format("\tmov %%eax, %d(%%esp)\n", argoffs))
					argoffs = argoffs + 4
				end

				trampolines:write("\n")
			elseif lastarg >= 0 then
				trampolines:write("\tsub $16, %esp\n")
				trampolines:write(string.format("\tmov $%d, 0(%%esp)\n", (lastarg + 1) * 4))
				trampolines:write("\tmov 4(%esi), %eax # %edx\n")
				trampolines:write("\tmov %eax, 4(%esp)\n")
				trampolines:write(string.format("\tlea %d(%%esp), %eax\n", argoffs + 16))
				trampolines:write("\tmov %eax, 8(%esp)\n")
				trampolines:write("\tcall KeSafeCopyIn\n")
				trampolines:write("\tadd $16, %esp\n")
				trampolines:write("\ttest %eax, %eax\n")
				trampolines:write("\tjnz 1f\n\n")
			end

			trampolines:write(string.format("\tcall %s\n\n", sys.name))

			local lastret = #sys.rets - 1

			if lastret == 0 then
				trampolines:write("\tmov %eax, 0(%esi) # %eax\n\n")
			elseif lastret > 0 then
				for reg = 0, lastret do
					trampolines:write(string.format("\tmov %d(%%esp), %%eax\n", retoffs + reg * 4))
					trampolines:write(string.format("\tmov %%eax, %d(%%esi) # %s\n", (reg + FIRSTREG - 1) * 4, regnames[reg + FIRSTREG]))
				end

				trampolines:write("\n")
			end

			trampolines:write(string.format("\tadd $%d, %%esp\n", framesize))
			trampolines:write("\tret\n")

			if lastarg > LASTREG - FIRSTREG then
				local statusindex = 0

				while statusindex < #sys.rets do
					if sys.rets[statusindex + 1].name == "ok" then
						break
					end
				end

				if statusindex >= #sys.rets then
					error(sys.name..": too many parameters for status-less syscall")
				end

				trampolines:write(string.format("\n1:\tmov %%eax, %d(%%esi) # %s\n", (FIRSTREG + statusindex - 1) * 4), regnames[FIRSTREG + statusindex])
				trampolines:write(string.format("\n\tadd $%d, %%esp\n", framesize))
				trampolines:write("\tret\n")
			end
		end

		if not NATIVEASM then
			trampolines:write(string.format(".size OST%s, . - OST%s\n", sys.name, sys.name))
		end
	end
end
