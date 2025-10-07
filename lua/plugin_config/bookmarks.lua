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
  -- NOTE: We no longer create the directory here. It will be created on demand.

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

-- Wrapper function to ensure bookmark directory exists before performing an action
local function ensure_dir_and_run(action)
  return function()
    local bookmark_dir = vim.fn.fnamemodify(bookmark_file_path, ":h")
    ensure_directory_exists(bookmark_dir)
    action()
  end
end

vim.keymap.set("n", "bb", ensure_dir_and_run(bookmarks.bookmark_toggle), {
  noremap = true,
  silent = true,
  desc = "Toggle bookmark",
})

vim.keymap.set("n", "ba", ensure_dir_and_run(bookmarks.bookmark_ann), {
  noremap = true,
  silent = true,
  desc = "Add/edit bookmark annotation",
})

vim.keymap.set("n", "bo", function()
  require('telescope').extensions.bookmarks.list()
end, {
  noremap = true,
  silent = true,
  desc = "Show bookmarks",
})

vim.keymap.set("n", "bl", function()
  require('telescope').extensions.bookmarks.list()
end, {
  noremap = true,
  silent = true,
  desc = "Show bookmarks",
})

vim.keymap.set("n", "bc", function() bookmarks.bookmark_clear_all() end, {
  noremap = true,
  silent = true,
  desc = "Clear all bookmarks",
})

vim.keymap.set("n", "bx", function() bookmarks.bookmark_delete_at_line() end, {
  noremap = true,
  silent = true,
  desc = "Delete bookmark at line",
})

vim.keymap.set("n", "bp", function() bookmarks.bookmark_prev() end, {
  noremap = true,
  silent = true,
  desc = "Goto prev bookmark",
})

vim.keymap.set("n", "bn", function() bookmarks.bookmark_next() end, {
  noremap = true,
  silent = true,
  desc = "Goto next bookmark",
})