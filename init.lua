require("options")
require("keymaps")
require("plugins")
require("plugin_config")

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

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost",
  { callback = function() vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 100 }) end })

-- Disable diagnostics in node_modules (0 is current buffer only)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })

-- -- Create an augroup for the detached terminal command
-- local augroup = vim.api.nvim_create_augroup("DetachedTerminal", { clear = true })

-- -- Create an autocommand to run the detached terminal command
-- vim.api.nvim_create_autocmd("VimLeavePre", {
--   group = augroup,
--   callback = function()
--     vim.cmd("silent !alacritty --working-directory=" .. vim.fn.getcwd() .. " &")
--   end
-- })

-- sets up nerdtree
vim.api.nvim_exec([[
  autocmd FileType nerdtree nmap <buffer> t :q<CR>
]], false)
