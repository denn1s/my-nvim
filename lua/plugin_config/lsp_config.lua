require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "ts_ls",
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

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.offsetEncoding = { "utf-16", "utf-8" }

local on_attach = function(client, bufnr)
  -- Ensure LSP attaches and is ready
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
end

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

-- Use the new vim.lsp.config API (Neovim 0.11+)
vim.lsp.config.lua_ls = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
}

vim.lsp.config.clangd = {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
  },
  filetypes = { "c", "cpp", "h", "hpp", "cxx", "hxx", "objc", "objcpp" },
  root_markers = { "compile_commands.json", ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
}

vim.lsp.config.cssls = {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  root_markers = { "package.json", ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    css = {
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },
}

vim.lsp.config.jsonls = {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_markers = { ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
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
}

vim.lsp.config.eslint = {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte", "astro" },
  root_markers = { ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml", ".eslintrc.yml", ".eslintrc.json", "package.json", ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
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
}

vim.lsp.config.ts_ls = {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_markers = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
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
}

vim.lsp.config.html = {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html", "templ" },
  root_markers = { ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
}

vim.lsp.config.rust_analyzer = {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json", ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      inlayHints = {
        enable = true,
      },
      checkOnSave = true,
      check = {
        command = "clippy",
      },
      diagnostics = {
        disabled = { "unresolved-module", "unresolved-import", "unlinked-file" },
      },
    },
  },
}

vim.lsp.config.gopls = {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    gopls = {
      gofumpt = true,
      analyses = {
        unusedparams = true,
        shadow = true,
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
}

-- Enable LSP servers for the configured filetypes
-- Enable them one by one to help identify any problematic configurations
local servers = { "lua_ls", "clangd", "cssls", "jsonls", "eslint", "ts_ls", "html", "rust_analyzer", "gopls" }
for _, server in ipairs(servers) do
  local ok, err = pcall(vim.lsp.enable, server)
  if not ok then
    vim.notify("Failed to enable " .. server .. ": " .. tostring(err), vim.log.levels.ERROR)
  end
end


