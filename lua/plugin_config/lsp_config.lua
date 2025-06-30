require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "tsserver",
    "eslint",
    "html",
    "jsonls",
    "lua_ls",
    "clangd",
    "rust_analyzer",
    "gopls",
  },
  automatic_installation = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)
capabilities.offsetEncoding = { "utf-8", "utf-16" }

local default_keys = {
  close = "<escape>",
  edit = "o",
  vsplit = "h",
  split = "v",
}

require("lspsaga").setup({
  symbol_in_winbar = {
    enable = false,
  },
  code_action = {
    keys = {
      quit = "<escape>",
    },
  },
  definition = {
    keys = default_keys,
  },
  finder = {
    default = "def+ref+imp",
    silent = true,
    keys = default_keys,
  },
  floaterm = {
    keys = default_keys,
  },
  lightbulb = {
    virtual_text = false,
  },
  outline = {
    layout = "float",
    keys = {
      toggle_or_jump = "<enter>",
      jump = "o",
      quit = "<escape>",
    },
  },
  ui = {
    devicon = false,
    code_action = "A",
  },
})

vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<cr>", { silent = true })
vim.keymap.set({ "n", "v" }, "<leader>.", "<cmd>Lspsaga code_action<CR>", {
  silent = true,
})
vim.keymap.set({ "n", "v" }, "<leader>P", "<cmd>Lspsaga peek_definition<CR>", {
  silent = true,
})
vim.keymap.set({ "n", "v" }, "<leader>p", "<cmd>Lspsaga peek_type_definition<CR>", {
  silent = true,
})
vim.keymap.set({ "n", "v" }, "<leader>i", "<cmd>Lspsaga finder<CR>", { silent = true })
vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true })
vim.keymap.set("n", "<leader>e", "<cmd>Lspsaga show_buf_diagnostics<CR>", {
  silent = true,
})
vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { silent = true })
vim.keymap.set("n", "<leader>g", vim.lsp.buf.definition, { silent = true })

local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup {
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
          "/usr/share/lua/5.4",
          "/usr/local/share/lua/5.4",
        },
      },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
}

lspconfig.clangd.setup({
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
  filetypes = { "c", "cpp", "h" },
})

lspconfig.cssls.setup({
  capabilities = capabilities,
  settings = {
    css = {
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },
})

lspconfig.jsonls.setup({
  capabilities = capabilities,
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { "package.json" },
          url = "https://json.schemastore.org/package.json",
        },
        {
          fileMatch = { "tsconfig*.json" },
          url = "https://json.schemastore.org/tsconfig.json",
        },
        {
          fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
          url = "https://json.schemastore.org/prettierrc.json",
        },
        {
          fileMatch = { ".eslintrc", ".eslintrc.json" },
          url = "https://json.schemastore.org/eslintrc.json",
        },
        {
          fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
          url = "https://json.schemastore.org/babelrc.json",
        },
      },
    },
  },
})

lspconfig.eslint.setup({
  capabilities = capabilities,
  settings = {
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = "separateLine",
      },
      showDocumentation = {
        enable = true,
      },
    },
    codeActionOnSave = {
      enable = false,
      mode = "all",
    },
    format = true,
    nodePath = "",
    onIgnoredFiles = "off",
    packageManager = "npm",
    quiet = false,
    rulesCustomizations = {},
    run = "onType",
    useESLintClass = false,
    validate = "on",
    workingDirectory = {
      mode = "location",
    },
  },
})

lspconfig.tsserver.setup({
  capabilities = capabilities,
  settings = {
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = false,
        includeInlayEnumMemberValueHints = true,
      },
      suggest = {
        includeCompletionsForModuleExports = true,
      },
    },
  },
})

lspconfig.html.setup({
  capabilities = capabilities,
})

lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = false,
      },
    },
  },
}

lspconfig.gopls.setup({
  capabilities = capabilities,
  settings = {
    gopls = {
      gofumpt = true,
      analyses = {
        unusedparams = true,
        shadow = true,
        fieldalignment = true,
        nilness = true,
        unusedwrite = true,
        useany = true,
      },
      importShortcut = "Definition",
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      codelenses = {
        generate = true,
        gc_details = true,
        regenerate_cgo = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      staticcheck = true,
      matcher = "Fuzzy",
      experimentalPostfixCompletions = true,
      diagnosticsDelay = "500ms",
      symbolMatcher = "fuzzy",
      completeUnimported = true,
      buildFlags = { "-tags=integration" },
      env = {
        GOFLAGS = "-tags=integration",
      },
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
})


