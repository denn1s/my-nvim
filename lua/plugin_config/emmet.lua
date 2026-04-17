-- Emmet configuration for HTML/CSS expansion
-- Main Trigger: <C-e> in Insert and Visual mode

-- Enable Emmet globally
vim.g.user_emmet_install_global = 1

-- Enable in Insert (i), Visual (v), and Normal (n) modes
vim.g.user_emmet_mode = 'inv'

-- Advanced settings
vim.g.user_emmet_settings = {
  variables = {
    lang = 'en',
    charset = 'UTF-8'
  },
  -- React/JSX Support: ensure Emmet uses className and works in JS/TS files
  javascript = {
    extends = 'jsx',
  },
  typescript = {
    extends = 'jsx',
  },
}

-- Insert mode: Expand abbreviation
vim.keymap.set('i', '<C-e>', '<plug>(emmet-expand-abbr)', {
  silent = true,
  desc = 'Emmet: Expand abbreviation'
})

-- Visual mode: Wrap selection with abbreviation
-- Usage: Select text, press <C-e>, then type the abbreviation (e.g., div.container)
vim.keymap.set('v', '<C-e>', '<plug>(emmet-expand-abbr)', {
  silent = true,
  desc = 'Emmet: Wrap with abbreviation'
})
