vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.api.nvim_set_keymap('n', '<Tab>', '>>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', '<<', { noremap = true })
vim.api.nvim_set_keymap('x', '<Tab>', '>gv', { noremap = true })
vim.api.nvim_set_keymap('x', '<S-Tab>', '<gv', { noremap = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', '<C-D>', { noremap = true })

vim.keymap.set('n', '<leader>c', '<cmd>Switch<CR>')
