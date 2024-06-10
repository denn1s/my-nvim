-- Clear search highlights
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Indent/Unindent in normal and visual modes
vim.keymap.set('n', '<Tab>', '>>', { noremap = true, desc = 'Indent line' })
vim.keymap.set('n', '<S-Tab>', '<<', { noremap = true, desc = 'Unindent line' })
vim.keymap.set('x', '<Tab>', '>gv', { noremap = true, desc = 'Indent selected lines' })
vim.keymap.set('x', '<S-Tab>', '<gv', { noremap = true, desc = 'Unindent selected lines' })
vim.keymap.set('i', '<S-Tab>', '<C-D>', { noremap = true, desc = 'Unindent in insert mode' })
vim.keymap.set('n', '<leader>=', 'gg=G', { noremap = true, silent = true })

-- Switch between two files
vim.keymap.set('n', '<leader>c', '<cmd>Switch<CR>', { desc = 'Switch between two files' })

-- Focus NERDTree
vim.keymap.set('n', 't', ':NERDTreeFocus<CR>', { noremap = true, silent = true, desc = 'Focus NERDTree' })

-- Copy to system clipboard
vim.keymap.set('n', 'y', '"+y', { noremap = true, desc = 'Copy to system clipboard' })
vim.keymap.set('v', 'y', '"+y', { noremap = true, desc = 'Copy to system clipboard' })

-- Move between functions
vim.keymap.set('n', '<C-S-Up>', '[m', { noremap = true, desc = 'Move to previous function' })
vim.keymap.set('n', '<C-S-Down>', ']m', { noremap = true, desc = 'Move to next function' })
vim.keymap.set('n', '<C-Up>', '{', { noremap = true, desc = 'Move to previous paragraph' })
vim.keymap.set('v', '<C-Up>', '{', { noremap = true, desc = 'Move to previous paragraph' })
vim.keymap.set('n', '<C-Down>', '}', { noremap = true, desc = 'Move to next paragraph' })
vim.keymap.set('v', '<C-Down>', '}', { noremap = true, desc = 'Move to next paragraph' })

-- Copy to system clipboard in visual mode
vim.keymap.set('v', '<C-S-c>', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Copy to system clipboard' })

-- Move by words in normal and insert modes
vim.keymap.set('n', '<C-Left>', 'b', { desc = 'Move back one word' })
vim.keymap.set('n', '<C-Right>', 'w', { desc = 'Move forward one word' })
vim.keymap.set('i', '<C-Left>', '<C-o>b', { desc = 'Move back one word in insert mode' })
vim.keymap.set('i', '<C-Right>', '<C-o>w', { desc = 'Move forward one word in insert mode' })

-- Navigate between buffers
vim.keymap.set('n', '<A-Left>', ':bprevious<CR>', { desc = 'Go to previous buffer' })
vim.keymap.set('n', '<A-Right>', ':bnext<CR>', { desc = 'Go to next buffer' })
-- vim.keymap.set('n', '<A-Up>', '<C-w>W', { desc = 'Go to previous window' })
-- vim.keymap.set('n', '<A-Down>', '<C-w>w', { desc = 'Go to next window' })

-- Move lines arround
vim.keymap.set('n', '<A-Up>', ':m .-2<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', '<A-Down>', ':m .+1<CR>==', { noremap = true, silent = true })
vim.keymap.set('i', '<A-Up>', '<Esc>:m .-2<CR>==gi', { noremap = true, silent = true })
vim.keymap.set('i', '<A-Down>', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true })
vim.keymap.set('v', '<A-Up>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', '<A-Down>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Open new line without entering insert
vim.keymap.set('n', '<A-o>', 'o<Esc>k', { noremap = true, silent = true })
vim.keymap.set('n', '<A-S-o>', 'O<Esc>j', { noremap = true, silent = true })

-- Duplicate line
vim.keymap.set('n', '<C-d>', ':t.<CR>', { desc = 'Duplicate line' })
vim.keymap.set('v', '<C-d>', 'y:put!<CR>', { noremap = true, silent = true, desc = 'Duplicate selected lines' })

-- Save file
vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('i', '<C-s>', '<esc>:w<CR>', { desc = 'Save file in insert mode' })
