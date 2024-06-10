vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

-- use spaces for tabs and whatnot
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.cmd [[ set noswapfile ]]

--Line numbers
vim.wo.number = true
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.signcolumn = "yes"

-- other
vim.opt.backspace = {"indent", "eol,start"}
-- vim.opt.clipboard = {"unnamed", "unnamedplus"}
vim.opt.linebreak = true -- set soft wrapping
vim.opt.showbreak = "↪ "
vim.opt.autoindent = true -- automatically set indent of new line
vim.opt.ttyfast = true -- faster redrawing
vim.opt.scrolloff = 10
vim.opt.wildmenu = true -- enhanced command line completion
vim.opt.smartindent = true

-- nerdtree
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeStatusline = '%#NonText#'
