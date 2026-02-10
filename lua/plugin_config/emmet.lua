-- Emmet configuration for HTML/CSS expansion
-- Trigger: <C-y>, (Ctrl+y followed by comma) - this is the standard Emmet trigger
-- Example: div.container>ul>li*3 then <C-y>, expands to full HTML

-- Enable Emmet globally (it will only work in supported filetypes)
vim.g.user_emmet_install_global = 1

-- Only enable for specific file types
vim.g.user_emmet_mode = 'inv' -- enable in insert, visual, and normal modes

-- Simple settings - just set the language variable
vim.g.user_emmet_settings = {
  variables = {
    lang = 'en',
    charset = 'UTF-8'
  }
}

-- Note: The default trigger is <C-y>, (Ctrl+y then comma)
-- This works in INSERT mode for all HTML, CSS, and JSX/TSX files

-- Alternative keybinding: <C-e> for quick expansion (single key, no comma needed)
vim.keymap.set('i', '<C-e>', '<plug>(emmet-expand-abbr)', {
  silent = true,
  desc = 'Emmet: Expand abbreviation'
})
