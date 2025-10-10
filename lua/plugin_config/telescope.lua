-- local trouble = require("trouble.providers.telescope")

require('telescope').setup({
	defaults = {
	  previewer = true,
    layout_strategy = 'flex',
    path_display = { "truncate" },
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
  },
  extensions = {
    bookmarks = {}
  }
})

require('telescope').load_extension('bookmarks')

-- Custom bookmarks telescope picker with simplified display
local function custom_bookmarks_list(opts)
  opts = opts or {}

  local has_telescope, telescope = pcall(require, "telescope")
  if not has_telescope then
    vim.notify("Telescope is required", vim.log.levels.ERROR)
    return
  end

  local finders = require("telescope.finders")
  local pickers = require("telescope.pickers")
  local entry_display = require("telescope.pickers.entry_display")
  local conf = require("telescope.config").values
  local config = require("bookmarks.config").config
  local utils = require("telescope.utils")

  -- Get bookmarks data
  local allmarks = config.cache.data
  local marklist = {}
  for k, ma in pairs(allmarks) do
    for l, v in pairs(ma) do
      table.insert(marklist, {
        filename = k,
        lnum = tonumber(l),
        text = v.a or v.m,
      })
    end
  end

  -- Custom display function
  local display = function(entry)
    local displayer = entry_display.create({
      separator = "▏",
      items = {
        { width = 5 },
        { width = 30 },
        { remaining = true },
      },
    })

    local line_info = { entry.lnum, "TelescopeResultsLineNr" }

    -- Get path relative to current working directory
    local filepath = entry.filename
    local cwd = vim.fn.getcwd()
    local relative_path

    if filepath:sub(1, #cwd) == cwd then
      -- File is in current working directory, show relative path
      relative_path = filepath:sub(#cwd + 2) -- +2 to skip the trailing slash
    else
      -- File is outside cwd, just show filename
      relative_path = vim.fn.fnamemodify(filepath, ":t")
    end

    return displayer({
      line_info,
      entry.text,
      relative_path,
    })
  end

  -- Create picker
  pickers.new(opts, {
    prompt_title = "bookmarks",
    finder = finders.new_table({
      results = marklist,
      entry_maker = function(entry)
        return {
          valid = true,
          value = entry,
          display = display,
          ordinal = entry.filename .. entry.text,
          filename = entry.filename,
          lnum = entry.lnum,
          col = 1,
          text = entry.text,
        }
      end,
    }),
    sorter = conf.generic_sorter(opts),
    previewer = conf.qflist_previewer(opts),
  }):find()
end

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<c-p>', builtin.find_files, {})
vim.keymap.set('n', '<c-h>', builtin.oldfiles, {})
-- vim.keymap.set('n', '<c-s-f>', '<cmd>Telescope current_buffer_fuzzy_find<cr>', {})
vim.keymap.set('n', '<c-g>', '<cmd>Telescope live_grep<cr>', {})
-- vim.keymap.set('n', '<Space><Space>', '<cmd>Telescope buffers<cr>', {})
vim.keymap.set('n', '<c-s-r>', '<cmd>Telescope command_history<cr>', {})
vim.keymap.set('n', '<c-l>', '<cmd>Telescope commands<cr>', {})
-- Find definitions
-- vim.keymap.set('n', '<c-j>', '<cmd>Telescope lsp_definitions<cr>', { silent = true })

-- Find references
-- vim.keymap.set('n', '<c-r>', '<cmd>Telescope lsp_references<cr>', { silent = true })

-- Find implementations
-- vim.keymap.set('n', '<c-i>', '<cmd>Telescope lsp_implementations<cr>', { silent = true })

-- Find symbols
vim.keymap.set('n', '<c-a>', '<cmd>Telescope lsp_document_symbols<cr>', { silent = true })

local arena = require('arena')
arena.setup({
  -- Maxiumum number of files that the arena window can contain, or `nil` for
  -- an unlimited amount
  max_items = nil,
  -- Always show the enclosing folder for these paths
  always_context = { "mod.rs", "init.lua", "CMakeLists.txt", "index.html" },
  -- When set, ignores the current buffer when listing files in the window.
  ignore_current = true,
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
        arena.close()
      end,
      ["x"] = {
        function(bufnr)
          vim.cmd("echo \"delete from the arena: ".. bufnr .."\"")
          arena.remove()
        end,
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

-- Export custom bookmarks function
return {
  custom_bookmarks_list = custom_bookmarks_list
}
