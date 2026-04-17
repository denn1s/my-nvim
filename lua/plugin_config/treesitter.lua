local ts = require('nvim-treesitter')
ts.setup({
  install_dir = vim.fn.stdpath('data') .. '/site',
})

-- Install parsers (async, no-op if already installed)
ts.install({
  'cpp', 'lua', 'css', 'javascript', 'diff', 'bash', 'python', 'json',
  'yaml', 'markdown', 'cmake', 'html', 'vim', 'query', 'toml', 'make',
  'gitcommit', 'markdown_inline', 'rust', 'go', 'tsx', 'typescript',
})

-- Enable treesitter highlighting for all filetypes
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
