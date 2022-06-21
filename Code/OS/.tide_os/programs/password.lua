local shaLib = require_env.require("sha")

local args = {...}

local w, h = term.getSize()

local usrf = fs.open("/.tide_os/internalstorage/users/" .. args[1], "r")

local user = usrf.readLine()
local pass = usrf.readLine()
local perm = usrf.readLine()

usrf.close()

local function launchDesktop()
    user_data.username = user
    user_data.permissions = perm

    local id = multishell.launch({
        ["shell"] = shell,
        ["multishell"] = multishell,
        ["require_env"] = require_env,
        ["user_data"] = user_data
    }, "/.tide_os/programs/desktopmanager.lua")
    multishell.setFocus(id)

    shell.exit()
    return
end

local function youAreIn()
    term.setBackgroundColor(colors.lightBlue)
    term.setCursorPos((w / 2) - 14, (h / 6) + 1)
    term.setTextColor(colors.green)
    print("          Welcome!          ")
    term.setCursorPos((w / 2) - 5, (h / 3) * 2)
    sleep(1)
    launchDesktop()
end

local bg = paintutils.loadImage("/.tide_os/assets/images/password.ccpaint")

local function getPassword()
    
    term.clear()
    paintutils.drawImage(bg, 1, 1)

    term.setTextColor(colors.black)
    term.setBackgroundColor(colors.lightBlue)

    local msg = "Hi there, " .. user
    term.setCursorPos((w / 2) - (string.len(msg) / 2), (h / 6))
    print(msg)

    term.setCursorPos((w / 2) - 13, (h / 6) + 1)
    print("Please Enter Your Password")

    term.setCursorPos((w / 2) - 15, (h / 6) + 4)
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.blue)
    print("                              ")

    term.setCursorPos((w / 2) - 15, (h / 6) + 4)

    local uin = read("*")

    local saltf = fs.open("/.tide_os/internalstorage/salt.txt", "r")
    local salt = saltf.readAll()
    saltf.close()

    local uinSalted = uin .. salt

    local uinHashed = shaLib.sha(uinSalted)

    if uinHashed == pass then
        youAreIn()
        shell.exit()
        return
    else
        term.setBackgroundColor(colors.lightBlue)
        term.setCursorPos((w / 2) - 13, (h / 6) + 1)
        term.setTextColor(colors.red)
        print("    Password Incorrect    ")
        term.setCursorPos((w / 2) - 5, (h / 3) * 2)
        sleep(0.5)
        getPassword()
    end
end

getPassword()
