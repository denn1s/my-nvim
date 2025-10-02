-- Helper function to get the appropriate path separator for the OS
local function get_path_sep()
  if jit then
    if jit.os == "Windows" then
      return '\\'
    else
      return '/'
    end
  else
    return package.config:sub(1, 1)
  end
end

-- Ensure that the given directory exists, create it if necessary
local function ensure_directory_exists(dir_path)
  if vim.fn.exists(dir_path) == 0 or vim.fn.isdirectory(dir_path) == 0 then
    -- Create directory recursively, similar to `mkdir -p`
    vim.fn.mkdir(dir_path, "p")
  end
end

-- Generate the path for the bookmark file, scoped to the current project
local function get_bookmark_path()
  local path_sep = get_path_sep()
  local base_filename = vim.fn.getcwd()

  -- Handle Windows paths by replacing ':' with '_'
  if jit and jit.os == 'Windows' then
    base_filename = base_filename:gsub(':', '_')
  end

  -- Define the directory for storing bookmarks
  local bookmark_dir = vim.fn.stdpath('data') .. path_sep .. "nvim_bookmarks"
  -- Ensure the directory exists
  ensure_directory_exists(bookmark_dir)

  -- Return the full path to the bookmark file
  return bookmark_dir .. path_sep .. base_filename:gsub(path_sep, '_') .. '.json'
end

-- Define the path for the bookmark file
local bookmark_file_path = get_bookmark_path()

-- Bookmarks plugin setup
require("bookmarks").setup {
  save_file = bookmark_file_path, -- Save bookmarks in the project-scoped file
  keywords = {
    [" @t"] = "[T]", -- Mark annotation starts with @t, sign as `Todo`
    [" @w"] = "[W]", -- Mark annotation starts with @w, sign as `Warn`
    [" @f"] = "[F]", -- Mark annotation starts with @f, sign as `Fix`
    [" @n"] = "[N]", -- Mark annotation starts with @n, sign as `Note`
  },
  signs = {
    ann = { hl = "BookMarksAnn", text = ">", numhl = "BookMarksAnnNr", linehl = "BookMarksAnnLn" },
  }
}

local bookmarks = require("bookmarks")

vim.keymap.set("n", "mm", function() bookmarks.bookmark_toggle() end, {
  noremap = true,
  silent = true,
  desc = "Toggle bookmark",
})

-- This is a new keymap from the user's post to add annotations
vim.keymap.set("n", "ma", function() bookmarks.bookmark_ann() end, {
  noremap = true,
  silent = true,
  desc = "Add/edit bookmark annotation",
})

vim.keymap.set("n", "mo", function()
  require('telescope').extensions.bookmarks.list()
end, {
  noremap = true,
  silent = true,
  desc = "Show bookmarks",
})

vim.keymap.set("n", "ml", function()
  require('telescope').extensions.bookmarks.list()
end, {
  noremap = true,
  silent = true,
  desc = "Show bookmarks",
})

vim.keymap.set("n", "mc", function() bookmarks.bookmark_clear_all() end, {
  noremap = true,
  silent = true,
  desc = "Clear all bookmarks",
})

vim.keymap.set("n", "mx", function() bookmarks.bookmark_delete_at_line() end, {
  noremap = true,
  silent = true,
  desc = "Delete bookmark at line",
})

vim.keymap.set("n", "mp", function() bookmarks.bookmark_prev() end, {
  noremap = true,
  silent = true,
  desc = "Goto prev bookmark",
})

vim.keymap.set("n", "mn", function() bookmarks.bookmark_next() end, {
  noremap = true,
  silent = true,
  desc = "Goto next bookmark",
})
