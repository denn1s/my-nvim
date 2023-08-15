vim.api.nvim_set_keymap('n', '<C-Up>', '4k', {})
vim.api.nvim_set_keymap('n', '<C-Down>', '5j', {})
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
vim.api.nvim_set_keymap('n', '<c-p>', '<cmd>Telescope find_files<cr>', {})
vim.api.nvim_set_keymap('n', '<c-h>', '<cmd>Telescope oldfiles<cr>', {})
vim.api.nvim_set_keymap('n', '<c-s-f>', '<cmd>Telescope current_buffer_fuzzy_find<cr>', {})
vim.api.nvim_set_keymap('n', '<c-f>', '<cmd>Telescope live_grep<cr>', {})
vim.api.nvim_set_keymap('n', '<c-b>', '<cmd>Telescope buffers<cr>', {})
vim.api.nvim_set_keymap('n', '<c-r>', '<cmd>Telescope command_history<cr>', {})
vim.api.nvim_set_keymap('n', '<c-l>', '<cmd>Telescope commands<cr>', {})
vim.api.nvim_set_keymap('n', '<C-d>', ':t.<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>bc', ':bufdo e \\| %bd \\| e#<CR>', {})
vim.api.nvim_set_keymap('n', '<C-x>', ':qa!<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>fp', '<cmd>Telescope find_files<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope oldfiles<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fc', '<cmd>Telescope commands<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope live_grep<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fr', '<cmd>Telescope command_history<cr>', {})

vim.cmd('command! Run !./run.sh')