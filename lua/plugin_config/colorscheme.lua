vim.o.termguicolors = true
-- vim.cmd [[ colorscheme dracula ]]

require('github-theme').setup({
  palettes = {
    accent = {
      fg = '#ff0000',
      emphasis = '#00ff00',
      muted = '#0000ff',
      subtle = '#ff00ff',
    },
  }
})

vim.cmd('colorscheme github_dark_default')
