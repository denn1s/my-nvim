local tsj = require('treesj')

local langs = require('treesj.langs')

tsj.setup({
  use_default_keymaps = false,
  check_syntax_error = false,
     max_join_length = 120,
     cursor_behavior = 'hold',
  notify = true,
  dot_repeat = true,
  on_error = nil,
  langs = langs.presets,
})

vim.keymap.set('n', '<leader>b', tsj.toggle)
vim.keymap.set('n', '<leader>B', function()
    tsj.toggle({ split = { recursive = true } })
end)


require("nvim-surround").setup({})


