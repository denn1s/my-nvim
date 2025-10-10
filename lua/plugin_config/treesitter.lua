require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "cpp", "lua", "css", "javascript", "diff", "bash", "python", "json",
    "yaml", "markdown", "cmake", "html", "vim", "query", "toml", "make", "gitcommit", "markdown_inline", "rust"
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "rust" },
  },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
    },
  },
  -- rainbow = { enable = true, extended_mode = true },
  context_commentstring = { enable = true, enable_autocmd = false },
  -- autotag = { enable = true },
  -- playground = { enable = true },
}
