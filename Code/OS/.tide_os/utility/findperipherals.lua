local function genObject()
    local result = {
        side = "",
        type = "",
        methods = nil
    }

    return result
end

local names = peripheral.getNames()
local wraps = {}

for _, n in ipairs(names) do
    table.insert(wraps, peripheral.wrap(n))
end

local finished = {}

for _, p in ipairs(wraps) do
    local base = genObject()
    base.side = peripheral.getName(p)
    base.type = peripheral.getType(p)
    base.methods = p

    table.insert(finished, base)
end

return finished