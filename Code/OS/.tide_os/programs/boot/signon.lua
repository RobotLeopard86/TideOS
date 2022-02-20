local bg = paintutils.loadImage("/.tide_os/assets/images/signon.ccpaint")
term.clear()
paintutils.drawImage(bg, 1, 1)

local w, h = term.getSize()

term.setTextColor(colors.blue)
term.setBackgroundColor(colors.lightBlue)
term.setCursorPos((w / 6.5) - 2.5, (h / 6))
print("Welcome!")
term.setCursorPos((w / 6.5) - 2.5, (h / 6) + 2)
print("Select your username to begin.")

local users = fs.list("/.tide_os/internalstorage/users")

local unames = {}

local unameRetrieveCounter = 1
local rootUIndex = 1

for _, ufile in ipairs(users) do
    local handle = fs.open("/.tide_os/internalstorage/users/" .. ufile, "r")
    table.insert(unames, handle.readLine())
    handle.close()

    if ufile == "root.tos" then
        rootUIndex = unameRetrieveCounter
    end

    unameRetrieveCounter = unameRetrieveCounter + 1
end

term.setTextColor(colors.black)
term.setCursorPos((w / 6.5) - 2.5, (h / 6) + 4)

local sr = fs.open("/.tide_os/internalstorage/config/showroot.bool", "r")

if sr.readAll() == "false" then
    table.remove(unames, rootUIndex)
end

local usrScreenPositions = {}

for _, name in ipairs(unames) do
    local ox, oy = term.getCursorPos()

    term.write(name)
    
    local x, y = term.getCursorPos()

    table.insert(usrScreenPositions, {ox, x})

    term.setCursorPos(x + 2, y)

    x, y = term.getCursorPos()

    if x >= 40 then
        term.setCursorPos((w / 6.5) - 2.5, y + 1)
    end
end

while true do
    sleep(0.05)
end