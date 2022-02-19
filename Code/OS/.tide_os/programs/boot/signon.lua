local bg = paintutils.loadImage("/.tide_os/assets/images/signon")
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

for _, ufile in ipairs(users) do
    local handle = fs.open("/.tide_os/internalstorage/users/" .. ufile, "r")
    table.insert(unames, handle.readLine())
    handle.close()
end

term.setTextColor(colors.black)
term.setCursorPos((w / 6.5) - 2.5, (h / 6) + 6)

for _, name in ipairs(unames) do
    print(name)
end

while true do
    sleep(0.05)
end