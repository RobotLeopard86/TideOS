if pocket then
    printError("ERROR: TideOS cannot be installed on a pocket computer!")
end

if term.isColor() then
    printError("ERROR: TideOS requires color!")
end

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
print("TideOS 2022.1.0a1 Shell")
term.setTextColor(colors.white)
print()
print("Loading TideOS 2022.1.0a1 Installer...")
sleep(1)
print("Preparing everything...")
sleep(1)
print("Let's go!")
sleep(0.5)
term.setBackgroundColor(colors.lightBlue)
term.clear()

local w, h = term.getSize()

term.setCursorPos((w / 2) - 17, 1)
term.setTextColor(colors.white)
term.setBackgroundColor(colors.blue)
print(" Welcome to the TideOS Installer! ")
term.setBackgroundColor(colors.lightBlue)
term.setTextColor(colors.black)
term.setCursorPos(1, 3)
textutils.slowPrint("Hey there! Thanks for choosing TideOS!");
term.setCursorPos(1, 6)
print("Before we get started, there are a few things you should know about the installer:")
print()
print("#1 The TideOS installer downloads its files from GitHub. If you don't have a real-world internet connection, the installation will fail.")
print()
print("#2 TideOS is designed with CC: Tweaked in mind. TideOS may not work properly on the original ComputerCraft or CC: Restiched, or any other version of ComputerCraft.")
print()
print("With this in mind, press enter to continue.")

while true do
    local event, key = os.pullEvent("key")
    if keys.getName(key) == keys.getName(keys.enter) then
        break
    end
end

term.clear()
term.setCursorPos((w / 2) - 9, 1)
term.setTextColor(colors.white)
term.setBackgroundColor(colors.blue)
print(" TideOS Installer ")
term.setBackgroundColor(colors.lightBlue)
term.setTextColor(colors.red)
term.setCursorPos(1, 3)
print("WARNING: The TideOS installer will COMPLETELY WIPE your computer in order to ensure the best experience. Please exit the installer and move files to a backup disk if you want to keep them. Press enter to continue.")

while true do
    local event, key = os.pullEvent("key")
    if keys.getName(key) == keys.getName(keys.enter) then
        break
    end
end

term.setTextColor(colors.black)
print()
print("Okay then. Let's go!")

term.setTextColor(colors.blue)
term.setBackgroundColor(colors.black)
term.setCursorPos(1, 1)
term.clear()
print("Testing file downloads...")
if http.get("https://raw.githubusercontent.com/RobotLeopard86/TideOS/main/Code/Installer/filedownloadtest.txt").readAll() == "Test succeeded!" then
    print("File downloads are working!")
else
    printError("File downloads aren't working. :(")
    sleep(1)
    os.shutdown()
end

local fileRoot = "https://raw.githubusercontent.com/RobotLeopard86/TideOS/main/Code/OS/.tide_os"

print()
print("Wiping computer...")
fs.delete("/")
print("Computer wiped!")
print("Downloading master file record...")
local mfrd = fs.open("/OS/masterfilerecord.txt", "w")
mfrd.write(http.get("https://raw.githubusercontent.com/RobotLeopard86/TideOS/main/Code/Installer/masterfilerecord.txt").readAll())
mfrd.close()

print("Downloading file startup.lua...")
local s = fs.open("/startup.lua", "w")
s.write(http.get("https://raw.githubusercontent.com/RobotLeopard86/TideOS/main/Code/OS/startup.lua").readAll())
s.close()

local mfr = fs.open("/masterfilerecord.txt", "r")

while true do
    local file = mfr.readLine()
    if file == nil then
        break
    end

    print("Downloading file " .. file .. "...")
    local writer = fs.open("/.tide_os" .. file, "w")
    writer.write(http.get(fileRoot .. file).readAll())
    writer.close()
end

mfr.close()
fs.delete("/masterfilerecord.txt")
term.setTextColor(colors.lime)
print("Installation complete! Rebooting...")
sleep(1.5)
os.reboot()