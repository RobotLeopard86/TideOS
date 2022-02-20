local args = {...}

local usrf = fs.open("/.tide_os/internalstorage/users/" .. args[1], "r")

local user = usrf.readLine()
local pass = usrf.readLine()
local perm = usrf.readLine()

usrf.close()

local bg = paintutils.loadImage("/.tide_os/assets/images/password.ccpaint")
term.clear()
paintutils.drawImage(bg, 1, 1)

local w, h = term.getSize()

term.setTextColor(colors.blue)
term.setBackgroundColor(colors.lightBlue)
term.setCursorPos((w / 2) - 3.5, (h / 8))
print("welcome")
term.setCursorPos((w / 2) - (string.len(user) / 2), (h / 6) + 2)
print(user)