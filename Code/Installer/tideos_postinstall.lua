os.pullEvent = os.pullEventRaw

shell.run("cp /.tide_os/programs/lib/sha.lua /")

local shaLib = require("sha")
local tw, th = term.getSize()

term.setBackgroundColor(colors.lightBlue)
term.clear()
term.setCursorPos((tw / 2) - 12.5, 1)
term.setTextColor(colors.white)
term.setBackgroundColor(colors.blue)
print(" TideOS Post-Install Setup ")

local frame = window.create(term.current(), tw / 8 - 1, th / 8 + 2, (tw - (tw / 8)) - (tw / 8) + 4, (th - (th / 8)) - (th / 8))

local w, h = frame.getSize()

local function getUsername()
    frame.clear()
    frame.setTextColor(colors.black)
    frame.setCursorPos((w / 2) - 4, 1)
    frame.write("Create User")
    frame.setCursorPos(w / 14, 2)
    frame.write("Enter username: ")
    local name = read()

    if string.len(name) > 20 then
        frame.setCursorPos((w / 2) - 10, 1)
        frame.setTextColor(colors.red)
        frame.write("Username Is Too Long")
        sleep(1)
        return getUsername()
    end
    
    if name == "" then
       frame.setCursorPos((w / 2) - 12, 1)
        frame.setTextColor(colors.red)
        frame.write("This Is A Required Field")
        sleep(1)
        return getUsername()
    end

    return name
end

local function getPassword(isForRoot)
    frame.clear()
    frame.setTextColor(colors.black)
    if isForRoot == false then
        frame.setCursorPos((w / 2) - 4, 1)
        frame.write("Create User")
    else
        frame.setCursorPos((w / 2) - 9, 1)
        frame.write("Root User Password")
    end
    frame.setCursorPos(w / 14, 2)
    frame.write("Enter password: ")
    local pass = read("*")

    if string.len(pass) > 18 then
        frame.setCursorPos((w / 2) - 10, 1)
        frame.setTextColor(colors.red)
        frame.write("Password Is Too Long")
        sleep(1)
        return getPassword(isForRoot)
    end
    
    if pass == "" then
       frame.setCursorPos((w / 2) - 12, 1)
        frame.setTextColor(colors.red)
        frame.write("This Is A Required Field")
        sleep(1)
        return getPassword(isForRoot)
    end

    frame.setCursorPos(w / 14, 4)
    frame.write("Confirm password: ")
    local conf = read("*")

    if conf ~= pass then
        frame.setCursorPos((w / 2) - 11, 1)
        frame.setTextColor(colors.red)
        frame.write("Passwords Do Not Match")
        sleep(1)
        return getPassword(isForRoot)
    end

    return pass
end

local function isAdmin()
    frame.clear()
    frame.setTextColor(colors.black)
    frame.setCursorPos((w / 2) - 4, 1)
    frame.write("Create User")
    frame.setCursorPos(w / 14, 2)
    frame.write("Make this user an admin?")
    frame.setCursorPos(w / 14, 4)
    frame.write("Enter = Yes, Backspace = No")

    local makeAdmin = false

    while true do
        local event, key = os.pullEvent("key")
        if keys.getName(key) == keys.getName(keys.enter) then
            makeAdmin = true
            break
        end

        if keys.getName(key) == keys.getName(keys.backspace) then
            break
        end
    end

    return makeAdmin
end

local function isRootOn()
    frame.clear()
    frame.setTextColor(colors.black)
    frame.setCursorPos((w / 2) - 6, 1)
    frame.write("Root Account")
    frame.setCursorPos(w / 14, 2)
    frame.write("Enable root account?")
    frame.setCursorPos(w / 14, 4)
    frame.write("Enter = Yes, Backspace = No")

    local rootOn = false

    while true do
        local event, key = os.pullEvent("key")
        if keys.getName(key) == keys.getName(keys.enter) then
            rootOn = true
            break
        end

        if keys.getName(key) == keys.getName(keys.backspace) then
            break
        end
    end

    return rootOn
end

local function getCompName()
    frame.clear()
    frame.setTextColor(colors.black)
    frame.setCursorPos((w / 2) - 9, 1)
    frame.write("Name Your Computer")
    frame.setCursorPos(w / 14, 2)
    frame.write("Enter name: ")
    local comp = read()

    if string.len(comp) > 23 then
        frame.setCursorPos((w / 2) - 8, 1)
        frame.setTextColor(colors.red)
        frame.write("Name Is Too Long")
        sleep(1)
        return getUsername()
    end

    return comp
end

frame.setPaletteColor(colors.lightGray, 0xCCCCCC)
frame.setPaletteColor(colors.gray, 0x595959)
frame.setPaletteColor(colors.brown, 0xAC7339)
frame.setPaletteColor(colors.red, 0xE60000)
frame.setPaletteColor(colors.orange, 0xFF8C1A)
frame.setPaletteColor(colors.yellow, 0xFFD11A)
frame.setPaletteColor(colors.lime, 0x5CD65C)
frame.setPaletteColor(colors.green, 0x267326)
frame.setPaletteColor(colors.cyan, 0x00CCCC)
frame.setPaletteColor(colors.lightBlue, 0x66CCFF)
frame.setPaletteColor(colors.blue, 0x007ACC)
frame.setPaletteColor(colors.purple, 0x8A00E6)
frame.setPaletteColor(colors.magenta, 0xCC00CC)
frame.setPaletteColor(colors.pink, 0xFF00BF)

term.setBackgroundColor(colors.white)

frame.setBackgroundColor(colors.white)

local username = getUsername()
local password = getPassword(false)
local admin = isAdmin()
local root = isRootOn()
local rootPassword = nil

if root == true then
    rootPassword = getPassword(true)
end

local showPass = false;

local passwordSecret = ""
local rootPasswordSecret = ""

for i = 1, string.len(password), 1 do
    passwordSecret = passwordSecret .. "*"
end

if root == true then
    for i = 1, string.len(rootPassword), 1 do
        rootPasswordSecret = rootPasswordSecret .. "*"
    end
end

local function drawData()
    frame.clear()
    frame.setTextColor(colors.black)
    frame.setCursorPos((w / 2) - 3, 1)
    frame.write("Review")
    frame.setCursorPos(w / 14, 3)
    frame.write("Username: " .. username)
    frame.setCursorPos(w / 14, 4)
    if showPass == true then
        frame.write("Password: " .. password)
    else
        frame.write("Password: " .. passwordSecret)
    end
    frame.setCursorPos(w / 14, 5)
    frame.write("Administrator: " .. tostring(admin))
    frame.setCursorPos(w / 14, 6)
    frame.write("Root Account Enabled: " .. tostring(root))

    if root == true then
        frame.setCursorPos(w / 14, 7)
        if showPass == true then
            frame.write("Root Account Password: " .. rootPassword)
        else
            frame.write("Root Account Password: " .. rootPasswordSecret)
        end
        frame.setCursorPos(w / 14, 9)
        frame.write("Are you sure this info is correct?")
        frame.setCursorPos(w / 14, 10)
        frame.write("Enter = Yes, Backspace = No")
        frame.setCursorPos(w / 14, 11)
        frame.write("Press space to show/hide passwords")
    else
        frame.setCursorPos(w / 14, 8)
        frame.write("Are you sure this info is correct?")
        frame.setCursorPos(w / 14, 9)
        frame.write("Enter = Yes, Backspace = No")
        frame.setCursorPos(w / 14, 11)
        frame.write("Press space to show/hide password")
    end
end

drawData()

local confirmed = false

while true do
    local event, key = os.pullEvent("key")
    if keys.getName(key) == keys.getName(keys.enter) then
        confirmed = true
        break
    end

    if keys.getName(key) == keys.getName(keys.backspace) then
        break
    end

    if keys.getName(key) == keys.getName(keys.space) then
        showPass = not showPass
    end
    drawData()
end

if not confirmed then
    shell.run("/tideos_postinstall.lua")
end

local computer = getCompName()

frame.clear()
frame.setTextColor(colors.black)
frame.setCursorPos((w / 2) - 9, h / 2)
frame.write("Finalizing Details")

fs.delete("/sha.lua")
fs.delete("/tideos_postinstall.lua")

local saltf = fs.open("/.tide_os/internalstorage/salt.txt", "r")
local salt = saltf.readAll()
saltf.close()

local comp = fs.open("/.tide_os/internalstorage/config/computer.tos", "w")
comp.writeLine(computer)
comp.close()

local ok = fs.open("/.tide_os/internalstorage/config/ok.bool", "w")
ok.writeLine("true")
ok.close()

local user = fs.open("/.tide_os/internalstorage/users/0.tos", "w")
user.writeLine(username)

if password == "" then
    user.writeLine("<none>")
else
    user.writeLine(shaLib.sha(password .. salt))
end

if admin then
    user.writeLine("ADMIN")
else
    user.writeLine("REG")
end

user.close()

if root == true then
    local ru = fs.open("/.tide_os/internalstorage/users/root.tos", "w")
    ru.writeLine("ROOT")
    if rootPassword == "" then
        ru.writeLine("<none>")
    else
        ru.writeLine(shaLib.sha(rootPassword .. salt))
    end
    ru.writeLine("SUPERUSER")
    ru.close()
end

local showRoot = fs.open("/.tide_os/internalstorage/config/showroot.bool", "w")

if root then
    showRoot.write("true")
else
    showRoot.write("false")
end

showRoot.close()

frame.setBackgroundColor(colors.lime)
frame.clear()
frame.setTextColor(colors.white)
frame.setCursorPos((w / 2) - 9, h / 2)
frame.write("Done! Rebooting...")
sleep(1)
os.reboot()
