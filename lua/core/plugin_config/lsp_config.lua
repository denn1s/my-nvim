require("mason-lspconfig").setup()

local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)
capabilities.offsetEncoding = {'utf-8', 'utf-16'}

local default_keys = {
  close = '<escape>',
  edit = 'o',
  vsplit = 'h',
  split = 'v'
}

require('lspsaga').setup({
  symbol_in_winbar = {
    enable = false,
  },
  code_action = {
    keys = {
      quit = '<escape>'
    }
  },
  definition = {
    keys = default_keys
  },
  finder = {
    default = 'def+ref+imp',
    silent = true,
    keys = default_keys
  },
  floaterm = {  -- this doesnt work
    keys = default_keys
  },
  lightbulb = {
    virtual_text = false
  },
  outline = {
    layout = 'float',
    keys = {
      toggle_or_jump = '<enter>',
      jump = 'o',
      quit = '<escape>',
    }
  },
  ui = {
    devicon = false,
    code_action = 'A'
  }
})

vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<cr>', { silent = true })
vim.keymap.set({"n","v"}, "<leader>.", "<cmd>Lspsaga code_action<CR>", { silent = true })
vim.keymap.set({"n","v"}, "<leader>p", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
vim.keymap.set({"n","v"}, "<leader>i", "<cmd>Lspsaga finder<CR>", { silent = true })
vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true })
vim.keymap.set('n', '<leader>e', '<cmd>Lspsaga show_buf_diagnostics<CR>', { silent = true })
vim.keymap.set('n', '<leader>o', '<cmd>Lspsaga outline<CR>', { silent = true })

vim.keymap.set('n', '<leader><enter>', '<cmd>Lspsaga term_toggle<CR>')


require("lspconfig").lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
    },
  }
}

require("lspconfig").solargraph.setup {
  capabilities = capabilities,
}

require("lspconfig").pyright.setup {
  capabilities = capabilities,
}

require("lspconfig").clangd.setup({
    cmd = {
        "clangd",
        "--pretty",
        "--header-insertion=iwyu",
        "--background-index",
        "--suggest-missing-includes",
        "--query-driver=/path/to/toolchain/bin/",
        "-j=40",
        "--pch-storage=memory",
        "--clang-tidy",
        "--compile-commands-dir=build",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
})
