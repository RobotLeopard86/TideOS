term.setTextColor(colors.lime)
term.setBackgroundColor(colors.green)
term.clear()
term.setCursorPos(1, 1)
print("Hi, " .. user_data.username .. "!")
print() 
print("Welcome to your boring, generic desktop!")
print() 
print("You have " .. user_data.permissions .. " permission! Enjoy!")

while true do
    sleep(0.05)
end