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
  'wbthomason/packer.nvim',
  -- 'ellisonleao/gruvbox.nvim',
  -- 'rebelot/kanagawa.nvim',
  {
    'dracula/vim',
    lazy = false,
  },
  'nvim-lualine/lualine.nvim',
  'nvim-treesitter/nvim-treesitter',
  -- 'chrisgrieser/nvim-spider',
  -- 'bluz71/vim-nightfly-colors',
  -- 'tpope/vim-fugitive',
  'tpope/vim-commentary',
  -- 'nvim-tree/nvim-web-devicons',
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
  },
  -- completion
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
  'L3MON4D3/LuaSnip',
  'onsails/lspkind-nvim',
  "rafamadriz/friendly-snippets",
  -- "github/copilot.vim",
  "zbirenbaum/copilot.lua",
  "zbirenbaum/copilot-cmp",
  "folke/trouble.nvim",
  "williamboman/mason.nvim",
  "neovim/nvim-lspconfig",
  "williamboman/mason-lspconfig.nvim",
  "glepnir/lspsaga.nvim",
  {
	  'nvim-telescope/telescope.nvim',
	  tag = '0.1.0',
	  dependencies = { {'nvim-lua/plenary.nvim'} }
  },
  -- other utils
  "AndrewRadev/switch.vim",
  "Wansmer/treesj",
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
        'smoka7/hydra.nvim',
    },
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
  }
}

local opts = {}

require("lazy").setup(plugins, opts)
