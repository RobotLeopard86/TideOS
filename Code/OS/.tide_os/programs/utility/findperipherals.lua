local args = {...}

if #args ~= 1 then
    printError("Usage: findperipherals <outputFileName>")
end

local names = peripheral.getNames()

local handle = fs.open("/OS/.tide_os/memtransfer/" .. args[1], "w")
for _, nm in ipairs(names) do
    handle.writeLine(nm)
end
handle.close()