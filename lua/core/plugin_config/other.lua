 require('multicursors').setup {
  normal_keys = {
    -- to change default lhs of key mapping change the key
    [','] = {
        -- assigning nil to method exits from multi cursor mode
        -- assigning false to method removes the binding
        -- method = N.clear_others,
        -- you can pass :map-arguments here
        opts = { desc = 'Clear others' },
    },
    ['m'] = {
        method = function()
            -- local S = require('multicursors.search')
            local utils = require('multicursors.utils')
            -- S.create_under()
                vim.b.MultiCursorPattern = ''
            local line = vim.api.nvim_get_current_line()
            if not line then
                return
            end

            local cursor = vim.api.nvim_win_get_cursor(0)
            local left = vim.fn.matchstrpos(line:sub(1, cursor[2] + 1), [[\k*$]])
            local right = vim.fn.matchstrpos(line:sub(cursor[2] + 1), [[^\k*]])

            if left == -1 and right == -1 then
                vim.api.nvim_out_write("left -1 and right -1\n")
                return
            end

            local match
            local pattern = left[1] .. right[1]:sub(2)
            if pattern == '' then
                -- no word found under cursor, select character
                vim.api.nvim_out_write("No pattern\n")
                vim.b.MultiCursorPattern = ''
                match = {
                    col = cursor[2],
                    end_col = cursor[2] + 1,
                    row = cursor[1] - 1,
                    end_row = cursor[1] - 1,
                }
                if match.col == 0 then
                    match.end_col = 0
                end
            else
                vim.b.MultiCursorPattern = '\\<' .. pattern .. '\\>'
                match = {
                    row = cursor[1] - 1,
                    end_row = cursor[1] - 1,
                    col = left[2],
                    end_col = right[3] + cursor[2],
                }
            end
            utils.swap_main_to(match, false)
        end,
        opts = { desc = 'Add word' },
    },
  },
  hint_config = false,
}

vim.keymap.set('n', '<leader>m', '<cmd>MCstart<CR>')


local tsj = require('treesj')

local langs = require('treesj.langs')

tsj.setup({
  use_default_keymaps = false,
  check_syntax_error = false,
 max_join_length = 120,
 cursor_behavior = 'hold',
  notify = true,
  dot_repeat = true,
  on_error = nil,
  langs = langs.presets,
})

vim.keymap.set('n', '<leader>b', tsj.toggle)
vim.keymap.set('n', '<leader>B', function()
    tsj.toggle({ split = { recursive = true } })
end)

require("nvim-surround").setup({})


