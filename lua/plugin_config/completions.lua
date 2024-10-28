local cmp = require("cmp")
local types = require("cmp.types")
local str = require("cmp.utils.str")

local t = function(s)
	return vim.api.nvim_replace_termcodes(s, true, true, true)
end

local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "/home/dennis/.config/nvim/snippets" } })

luasnip.config.setup({
	region_check_events = "CursorMoved",
	delete_check_events = "TextChanged",
})

-- vim.keymap.set({"i"}, "<C-K>", function() luasnip.expand() end, {silent = true})
vim.keymap.set("n", "<leader>se", function() require("scissors").editSnippet() end)
vim.keymap.set({ "n", "x" }, "<leader>sa", function() require("scissors").addNewSnippet() end)

vim.keymap.set({"i"}, "<Tab>", function ()
	if luasnip.jumpable(1) then
		luasnip.jump(1)
	else
		return "\t"
	end
end, {expr = true, noremap = true})

vim.keymap.set({"i"}, "<S-Tab>", function ()
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	else
		return "\t"
	end
end, {expr = true, noremap = true})

local lspkind = require("lspkind")

cmp.setup({
	window = {
		completion = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			scrollbar = "║"
		},
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			scrollbar = "║",
		},
	},
	formatting = {
		fields = {
			cmp.ItemField.Kind,
			cmp.ItemField.Abbr,
			-- cmp.ItemField.Menu,
		},
		--[[
		format = lspkind.cmp_format({
			mode = 'symbol',
			maxwidth = 100,
			ellipsis_char = '...',
			show_labelDetails = true,
			before = function (entry, item)
				local menu_icon = {
					nvim_lsp = "NLSP",
					nvim_lua = "NLUA",
					luasnip  = "LSNP",
					buffer   = "BUFF",
					path     = "PATH",
				}
				item.menu = menu_icon[entry.source.name]
				local fixed_width = 200
				local content = item.abbr
				if fixed_width then
					vim.o.pumwidth = fixed_width
				end
				if #content > fixed_width then
					item.abbr = vim.fn.strcharpart(content, 0, fixed_width - 3)
				else
					item.abbr = content .. (" "):rep(fixed_width - #content)
				end
				return item
			end
		})
		--]]
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	mapping = {
		["<C-Down>"] = cmp.mapping(
			cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
			{ "i", "s", "c" }
		),
		["<C-Up>"] = cmp.mapping(
			cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
			{ "i", "s", "c" }
		),
		["<C-Right>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_jumpable() then
				vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
			else
				fallback()
			end
			end, {
				"i",
				"s",
		}),
		["<C-Left>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
			else
				fallback()
			end
			end, {
				"i",
				"s",
		}),
		["<Tab>"] = vim.schedule_wrap(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<C-s>'] = cmp.mapping.confirm({ select = true }),
	},
	-- You should specify your *installed* sources.
	sources = {
		{ name = "calc", max_item_count = 1, priority = 2000 },
		{ name = "luasnip", keyword_length = 2, max_item_count = 2, priority = 1500 },
		{ name = "nvim_lsp", keyword_length = 3, max_item_count = 3, priority = 1000 },
		{ name = "nvim_lsp_signature_help" },
		{ name = "path", keyword_length = 5, max_item_count = 2, priority = 300 },
		-- { name = "buffer", keyword_length = 5, max_item_count = 3, priority = 200 },
	},

	experimental = {
		ghost_text = false,
	},
})

require("cmp").setup.cmdline(":", {
	sources = {
		{ name = "cmdline", keyword_length = 2 },
	},
})


