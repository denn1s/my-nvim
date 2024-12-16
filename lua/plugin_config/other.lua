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


local flash = require("flash")
flash.setup({
	labels = "123456789",
	search = {
		multi_window = false,
		wrap = false,
	},
	modes = {
		char = {
			enabled = true,
			autohide = true,
			highlight = { backdrop = false },
			jump = { autojump = true, register = true },
			multi_line = false,
			nohlsearch = true,
		},
		search = {
			enabled = true,
		}
	},
	jump = {
		nohlsearch = true,
		register = true,
	}
})

vim.keymap.set("n", "s", function() flash.jump() end, { desc = "Flash" } )
vim.keymap.set("n", "S", function() flash.jump({ search = { forward = false } }) end, { desc = "Flash Backwards" })

vim.keymap.set("o", "r", function() flash.remote() end, { desc = "Remote Flash" })
vim.keymap.set("o", "R", function() flash.remote({ search = { forward = false } }) end, { desc = "Remote Flash Backwards" })

vim.keymap.set("o", "s", function() flash.treesitter_search() end, { desc = "Treesitter-based selection" })
vim.keymap.set("o", "S", function() flash.treesitter_search({ search = { forward = false } }) end, { desc = "Treesitter-based selection Backwards" })

local sub = require("rip-substitute")
sub.setup {
	prefill = {
		normal = false,
		visual = false,
		startInReplaceLineIfPrefill = false,
	},
	keymaps = {
		-- normal & visual mode
		confirm = "<CR>",
		abort = "<esc>",
		prevSubst = "<Up>",
		nextSubst = "<Down>",
		insertModeConfirm = "<C-CR>", -- (except this one, obviously)
	},
	incrementalPreview = {
		matchHlGroup = "IncSearch",
		rangeBackdrop = {
			enabled = true,
			blend = 10, -- between 0 and 100
		},
	},
	regexOptions = {
		-- pcre2 enables lookarounds and backreferences, but performs slower
		pcre2 = false,
	},
}

vim.keymap.set({"n"}, "<c-r>", function()
	sub.sub()
end, { desc = "Rip Substitute" } )

vim.keymap.set({"x"}, "<c-r>", ":RipSubstitute<cr>", { desc = "Rip Substitute Range" })

