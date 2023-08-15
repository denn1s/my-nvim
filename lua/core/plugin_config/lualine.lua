require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'dracula',
  },
  sections = {
    lualine_a = {
      {
        'mode',
      }
    },
    lualine_b = {},
    lualine_x = {
      'diff',
      'branch',
    },
    lualine_c = {
      { 'filename', file_status = false, path = 1 },
    },
    lualine_y = {},
  }
}
