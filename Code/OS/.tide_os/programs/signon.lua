local bg = paintutils.loadImage("/.tide_os/assets/images/signon.ccpaint")
term.clear()
paintutils.drawImage(bg, 1, 1)

local w, h = term.getSize()

local compf = fs.open("/.tide_os/internalstorage/config/computer.tos", "r")
local name = compf.readAll()
compf.close()

term.setTextColor(colors.white)
term.setBackgroundColor(colors.blue)
term.setCursorPos(1, 1)
term.write(name .. "                                                                                                                                                                     ")
term.setCursorPos(w - string.len(textutils.formatTime(os.time("local"))), 1)
term.write(textutils.formatTime(os.time("local")))
term.setTextColor(colors.blue)
term.setBackgroundColor(colors.lightBlue)
term.setCursorPos((w / 6.5) - 2.5, (h / 6))
print("Welcome!")
term.setCursorPos((w / 6.5) - 2.5, (h / 6) + 2)
print("Select your username to begin")

local users = fs.list("/.tide_os/internalstorage/users")

local unames = {}

if #unames < 2 then
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

    local sr = fs.open("/.tide_os/internalstorage/config/showroot.bool", "r")

    if sr.readAll() == "false" then
        table.remove(unames, rootUIndex)
    end
end

term.setTextColor(colors.black)
term.setCursorPos((w / 6.5) - 2.5, (h / 6) + 5)

local usrScreenPositions = {}

for _, name in ipairs(unames) do
    local ox, oy = term.getCursorPos()

    local nx = ox + string.len(name)

    if nx >= 40 then
        term.setCursorPos((w / 6.5) - 2.5, oy + 1)
    end

    ox = term.getCursorPos()

    term.write(name)

    local x, y = term.getCursorPos()

    table.insert(usrScreenPositions, {ox, x, y})

    term.setCursorPos(x + 2, y)
end

while true do
    local event, button, x, y = os.pullEvent("mouse_click")

    if button == 1 then
        local posCounter = 0

        for _, usrScreenPos in ipairs(usrScreenPositions) do
            posCounter = posCounter + 1

            if x >= usrScreenPos[1] and x <= usrScreenPos[2] and y == usrScreenPos[3] then
                local id = multishell.launch({
                    ["shell"] = shell,
                    ["multishell"] = multishell,
                    ["require_env"] = require_env,
                    ["user_data"] = user_data
                }, "/.tide_os/programs/password.lua", users[posCounter])
                multishell.setFocus(id)
                
                shell.exit()
            end
        end
    end
end