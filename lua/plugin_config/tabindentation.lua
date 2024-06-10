local dansa = require('dansa')

-- global settings.
dansa.setup({
  -- The offset to specify how much lines to use.
  scan_offset = 100,

  -- The count for cut-off the indent candidate.
  cutoff_count = 5,

  -- The settings for tab-indentation or when it cannot be guessed.
  default = {
    expandtab = true,
    space = {
      shiftwidth = 2,
    },
    tab = {
      shiftwidth = 4,
      badindwent = 2,
      fixme = 1
    }
  }
})

require('nvim-autopairs').setup({
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
    java = false,
  },
  -- fast_wrap = {
  --   map = "<leader>w",
  --   chars = { "{", "[], "%s+", ""),
  --   offset = 0, -- Offset from pattern match
  --   end_key = "$",
  --   keys = "qwertyuiopzxcvbnmasdfghjkl",
  --   check_comma = true,
  --   highlight = "PmenuSel",
  --   highlight_grey = "LineNr",
  -- }
})
