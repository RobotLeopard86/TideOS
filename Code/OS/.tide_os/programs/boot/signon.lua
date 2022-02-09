local bg = paintutils.loadImage("/.tide_os/assets/images/signon")
term.clear()
paintutils.drawImage(bg, 1, 1)

local w, h = term.getSize()

term.setTextColor(colors.blue)
term.setCursorPos((w / 3) - 3.5, (h / 4))

print("Welcome")

while true do
    sleep(0.05)
end