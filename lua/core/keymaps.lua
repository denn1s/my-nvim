vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.api.nvim_set_keymap('n', '<Tab>', '>>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', '<<', { noremap = true })
vim.api.nvim_set_keymap('x', '<Tab>', '>gv', { noremap = true })
vim.api.nvim_set_keymap('x', '<S-Tab>', '<gv', { noremap = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', '<C-D>', { noremap = true })

vim.keymap.set('n', '<leader>c', '<cmd>Switch<CR>')
vim.api.nvim_set_keymap('n', 't', ':NERDTreeFocus<CR>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', 'y', '"+y', {noremap = true})
vim.api.nvim_set_keymap('v', 'y', '"+y', {noremap = true})

