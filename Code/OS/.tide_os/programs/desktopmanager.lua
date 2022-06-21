term.setTextColor(colors.lime)
term.setBackgroundColor(colors.green)
term.clear()
term.setCursorPos(1, 1)

sleep(0.1)

multishell.kill(multishell.getByTitle("signon.lua"))

print("Hi, " .. user_data.username .. "!")
print() 
print("Welcome to your boring, generic desktop!")
print() 
print("You have " .. user_data.permissions .. " permission! Enjoy!")
print()
print("There are " .. multishell.getCount() .. " tabs open:")

local tabs = multishell.getTitles()

for _, tab in ipairs(tabs) do
    print(tab)
end

while true do
    sleep(0.05)
end
