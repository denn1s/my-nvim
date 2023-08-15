require("core.options")
require("core.keymaps")
require("core.plugins")
require("custom.keybindings")
require("core.plugin_config")

local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end

vim.diagnostic.config({
    virtual_text = false
})
