if pocket then
    printError("ERROR: TideOS cannot be run on a pocket computer!")
end

if term.isColor() then
    printError("ERROR: TideOS requires color!")
end

os.pullEvent = os.pullEventRaw

term.setPaletteColor(colors.lightGray, 0xCCCCCC)
term.setPaletteColor(colors.gray, 0x595959)
term.setPaletteColor(colors.brown, 0xAC7339)
term.setPaletteColor(colors.red, 0xE60000)
term.setPaletteColor(colors.orange, 0xFF8C1A)
term.setPaletteColor(colors.yellow, 0xFFD11A)
term.setPaletteColor(colors.lime, 0x5CD65C)
term.setPaletteColor(colors.green, 0x267326)
term.setPaletteColor(colors.cyan, 0x00CCCC)
term.setPaletteColor(colors.lightBlue, 0x66CCFF)
term.setPaletteColor(colors.blue, 0x007ACC)
term.setPaletteColor(colors.purple, 0x8A00E6)
term.setPaletteColor(colors.magenta, 0xCC00CC)
term.setPaletteColor(colors.pink, 0xFF00BF)
term.clear()
term.setCursorPos(1, 1)
term.setTextColor(colors.lightBlue)
print("TideOS 2022.1.0a1")
term.setTextColor(colors.white)
print()
print("Setting everything up...")
sleep(1)
print("Preparing sign-on screen...")
sleep(1)
print("Let's go!")
sleep(0.5)

shell.run("/.tide_os/programs/multishell_nomenubar.lua")