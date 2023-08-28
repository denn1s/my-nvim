-- vim.api.nvim_set_keymap('n', '<C-Up>', '4k', {})
-- vim.api.nvim_set_keymap('n', '<C-Down>', '5j', {})
vim.api.nvim_set_keymap('n', '<C-S-Up>', '[m', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-S-Down>', ']m', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-Up>', '{', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-Up>', '{', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-Down>', '}', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-Down>', '}', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-S-c>', '"+y', {})
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', {})
vim.api.nvim_set_keymap('n', '<C-Left>', 'b', {})
vim.api.nvim_set_keymap('n', '<C-Right>', 'w', {})
vim.api.nvim_set_keymap('i', '<C-Left>', '<C-o>b', {})
vim.api.nvim_set_keymap('i', '<C-Right>', '<C-o>w', {})
vim.api.nvim_set_keymap('n', '<A-Left>', '<C-w>h', {})
vim.api.nvim_set_keymap('n', '<A-Right>', '<C-w>l', {})
vim.api.nvim_set_keymap('n', '<A-Up>', '<C-w>k', {})
vim.api.nvim_set_keymap('n', '<A-Down>', '<C-w>j', {})
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', {})
vim.api.nvim_set_keymap('n', '<leader><leader>', ':w<CR>', {})
vim.api.nvim_set_keymap('n', '<C-d>', ':t.<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>bc', ':bufdo e \\| %bd \\| e#<CR>', {})
-- vim.api.nvim_set_keymap('n', '<C-x>', ':qa!<CR>', {})
vim.cmd('command! Run !./run.sh')
