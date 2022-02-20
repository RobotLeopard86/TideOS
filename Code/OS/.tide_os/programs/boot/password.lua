local args = {...}

local usrf = fs.open("/.tide_os/internalstorage/users/" .. args[1], "r")

local user = usrf.readLine()
local pass = usrf.readLine()
local perm = usrf.readLine()

if pass == "<none>" then
    return
end

usrf.close()

local bg = paintutils.loadImage("/.tide_os/assets/images/password.ccpaint")
term.clear()
paintutils.drawImage(bg, 1, 1)

local w, h = term.getSize()

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

local uin = read("o")