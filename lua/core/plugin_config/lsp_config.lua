require("mason-lspconfig").setup()

local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)
capabilities.offsetEncoding = {'utf-8', 'utf-16'}

local default_keys = {
  close = '<escape>',
  edit = '<enter>',
  vsplit = 'h',
  split = 'v'
}

require('lspsaga').setup({
  symbol_in_winbar = {
    enable = false,
  },
  code_action = {
    keys = {
      quit = '<escape>',
    },
  },
  definition = {
    keys = {
      close = '<escape>',
      edit = '<enter>',
      vsplit = 'h',
      split = 'v'
    }
  },
  finder = {
    default = 'def+ref+imp',
    silent = true,
    keys = {
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

require("lspconfig").lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
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

require("lspconfig").clangd.setup {
  capabilities = capabilities,
}

