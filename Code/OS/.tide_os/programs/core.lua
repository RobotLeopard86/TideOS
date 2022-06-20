term.clear()

local currentUser = {
    username = "",
    permissions = ""
}

local id = multishell.launch({
    ["shell"] = shell,
    ["multishell"] = multishell,
    ["require_env"] = require_env,
    ["user_data"] = currentUser
}, "/.tide_os/programs/signon.lua")
multishell.setFocus(id)