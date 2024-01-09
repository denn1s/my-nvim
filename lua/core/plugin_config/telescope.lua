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
-- vim.keymap.set('n', '<Space><Space>', '<cmd>Telescope buffers<cr>', {})
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

local arena = require('arena')
arena.setup({
  -- Maxiumum number of files that the arena window can contain, or `nil` for
  -- an unlimited amount
  max_items = nil,
  -- Always show the enclosing folder for these paths
  always_context = { "mod.rs", "init.lua", "CMakeLists.txt", "index.html" },
  -- When set, ignores the current buffer when listing files in the window.
  ignore_current = false,
  -- Options to apply to the arena buffer.
  -- Format should be `["<OPTION>"] = <VALUE>`
  buf_opts = {
    -- Example. Uncomment to add to your config!
    -- ["relativenumber"] = false,
  },
  -- Filter out buffers per the project they belong to.
  per_project = false,


  window = {
    width = 60,
    height = 10,
    border = "rounded",

    -- Options to apply to the arena window.
    opts = {},
  },

  -- Keybinds for the arena window.
  keybinds = {
      -- Example. Uncomment to add to your config!
      ["<esc>"] = function()
        vim.cmd("echo \"Hello from the arena!\"")
        arena.close()
      end,
      ["x"] = {
        arena.action(function(bufnr)
          vim.cmd("echo \"delete from the arena: ".. bufnr .."\"")
          arena.remove()
        end),
        {
          nowait = true
        }
      }
  },

  -- Config for frecency algorithm.
  algorithm = {
    -- Multiplies the recency by a factor. Must be greater than zero.
    -- A smaller number will mean less of an emphasis on recency!
    recency_factor = 0.5,
    -- Same as `recency_factor`, but for frequency!
    frequency_factor = 1,
  },
})


vim.keymap.set('n', '<Space><Space>', '<cmd>ArenaOpen<cr>', { silent = true })
