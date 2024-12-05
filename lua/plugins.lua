local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- {
  --  'dracula/vim',
  --  lazy = false,
  -- },
  {
    'projekt0n/github-nvim-theme',
    lazy = false,
  },
  'nvim-lualine/lualine.nvim',
  'nvim-treesitter/nvim-treesitter',
  -- { "chrisgrieser/nvim-spider", lazy = true },
  'tpope/vim-commentary',
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
  },
  'onsails/lspkind.nvim',
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-calc',
      'saadparwaiz1/cmp_luasnip',
    },
  },
  'hrsh7th/nvim-dansa',
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp"
  },
  {
    "chrisgrieser/nvim-scissors",
    opts = {
      snippetDir = "/home/dennis/.config/nvim/snippets",
    },
  },
  {
    "williamboman/mason.nvim",
    dependencies = { { "williamboman/mason-lspconfig.nvim" } }
  },
  "neovim/nvim-lspconfig",
  "glepnir/lspsaga.nvim",
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    "dzfrias/arena.nvim",
    event = "BufWinEnter",
  },
  "Wansmer/treesj",
  {
    "folke/flash.nvim",
    event = "VeryLazy",
  },
  {
    "chrisgrieser/nvim-rip-substitute",
	  cmd = "RipSubstitute",
    event = "VeryLazy"
  },
  -- go support
  {
    "fatih/vim-go",
    ft = "go",
    build = ":GoUpdateBinaries",
  },
}

local opts = {}

require("lazy").setup(plugins, opts)

