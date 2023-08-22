require('trouble').setup {
  icons = false,
}

vim.keymap.set('n', '<leader>t', '<cmd>TroubleToggle<CR>', { silent = true })
