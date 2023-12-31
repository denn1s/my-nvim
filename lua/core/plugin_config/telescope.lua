-- local trouble = require("trouble.providers.telescope")

require('telescope').setup({
	defaults = {
	  previewer = true,
    layout_strategy = 'flex',
    -- mappings = {
    --   n = { ["<leader>t"] = trouble.open_with_trouble },
    -- },
    file_ignore_patterns = {
      "build",
      "node_modules",
      "node%_modules/.*",
      "build/.*"
    },
    wrap_results = true,
    sorting_strategy = "ascending",
		-- path_display = { "smart" },
  },
  preview_cutoff = 1,
  pickers = {
    oldfiles = {
      initial_mode = "normal"
    },
    live_grep = {
      wrap_results = false
    }
  }
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<c-p>', builtin.find_files, {})
vim.keymap.set('n', '<c-h>', builtin.oldfiles, {})
vim.keymap.set('n', '<c-s-f>', '<cmd>Telescope current_buffer_fuzzy_find<cr>', {})
vim.keymap.set('n', '<c-f>', '<cmd>Telescope live_grep<cr>', {})
vim.keymap.set('n', '<Space><Space>', '<cmd>Telescope buffers<cr>', {})
vim.keymap.set('n', '<c-s-r>', '<cmd>Telescope command_history<cr>', {})
vim.keymap.set('n', '<c-l>', '<cmd>Telescope commands<cr>', {})
-- Find definitions
vim.keymap.set('n', '<leader>g', '<cmd>Telescope lsp_definitions<cr>', { silent = true })

-- Find references
vim.keymap.set('n', '<leader>r', '<cmd>Telescope lsp_references<cr>', { silent = true })

-- Find implementations
vim.keymap.set('n', '<leader>i', '<cmd>Telescope lsp_implementations<cr>', { silent = true })

-- Find symbols
vim.keymap.set('n', '<leader>s', '<cmd>Telescope lsp_document_symbols<cr>', { silent = true })


