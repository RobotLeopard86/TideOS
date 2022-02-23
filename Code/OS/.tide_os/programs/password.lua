local shaLib = require("lib.sha")

local args = {...}

local w, h = term.getSize()

local usrf = fs.open("/.tide_os/internalstorage/users/" .. args[1], "r")

local user = usrf.readLine()
local pass = usrf.readLine()
local perm = usrf.readLine()

usrf.close()

local function youAreIn()
    term.setBackgroundColor(colors.lime)
    term.clear()
    term.setCursorPos((w / 2) - 5, (h / 2))
    term.setTextColor(colors.white)
    print("Signed In!")
    sleep(0.5)
    term.clear()
    term.setCursorPos((w / 2) - 9, (h / 2))
    print("Loading Desktop...")
    sleep(1)
end

if pass == "<none>" then
    youAreIn()
    return
end

local bg = paintutils.loadImage("/.tide_os/assets/images/password.ccpaint")
term.clear()
paintutils.drawImage(bg, 1, 1)

term.setTextColor(colors.black)
term.setBackgroundColor(colors.lightBlue)

local msg = "Hi there, " .. user

term.setCursorPos((w / 2) - (string.len(msg) / 2), (h / 8))
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
else
    term.setBackgroundColor(colors.red)
    term.clear()
    term.setCursorPos((w / 2) - 9, (h / 3))
    term.setTextColor(colors.white)
    print("Password Incorrect")
    term.setCursorPos((w / 2) - 5, (h / 3) * 2)
    print("Try Again!")
    sleep(1.5)
    shell.run("/.tide_os/programs/boot/password.lua", args[1])
end