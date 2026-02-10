local cmp = require("cmp")
local luasnip = require("luasnip")

local t = function(s)
	return vim.api.nvim_replace_termcodes(s, true, true, true)
end

local has_words_before = function()
	if vim.bo[0].buftype == "prompt" then return false end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

require("luasnip.loaders.from_vscode").lazy_load({ paths = { "/home/dennis/.config/nvim/snippets" } })

luasnip.config.setup({
	region_check_events = "CursorMoved",
	delete_check_events = "TextChanged",
})

vim.keymap.set("n", "<leader>se", function() require("scissors").editSnippet() end)
vim.keymap.set({ "n", "x" }, "<leader>sa", function() require("scissors").addNewSnippet() end)

vim.keymap.set({"i", "s"}, "<C-n>", function ()
	if luasnip.jumpable(1) then
		luasnip.jump(1)
	else
		return "\t"
	end
end, {expr = true, noremap = true})

vim.keymap.set({"i", "s"}, "<C-N>", function ()
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	else
		return "\t"
	end
end, {expr = true, noremap = true})

-- Custom preprocessing for completion items to clean up CSS documentation
local function preprocess_completion_item(entry)
	-- Only process CSS/SCSS/LESS files
	local filetype = vim.bo.filetype
	if not (filetype == 'css' or filetype == 'scss' or filetype == 'less') then
		return
	end

	-- Clean up documentation for CSS LSP
	if entry.source.name == 'nvim_lsp' then
		local item = entry:get_completion_item()
		if item.documentation then
			vim.notify("CSS doc preprocessing triggered", vim.log.levels.INFO)
			local doc = item.documentation
			if type(doc) == 'table' and doc.value then
				local original = doc.value
				-- Remove base64 encoded images (Baseline icons) - fixed pattern
				doc.value = doc.value:gsub('!%[Baseline[^%]]*%]%(data:image/[^%)]+%)', '')
				-- Remove MDN reference URLs - more flexible pattern
				doc.value = doc.value:gsub('%[MDN [Rr]eference%]%(https?://[^%)]+%)', '')
				-- Remove standalone URLs
				doc.value = doc.value:gsub('https?://[^%s%)]+', '')
				-- Clean up "Baseline" text
				doc.value = doc.value:gsub('Baseline[^\n]*', '')
				-- Clean up extra whitespace/newlines
				doc.value = doc.value:gsub('\n\n\n+', '\n\n')
				doc.value = doc.value:gsub('^\n+', '')
				doc.value = doc.value:gsub('%s+$', '')

				if original ~= doc.value then
					vim.notify("CSS doc cleaned!", vim.log.levels.INFO)
				end
			elseif type(doc) == 'string' then
				doc = doc:gsub('!%[Baseline[^%]]*%]%(data:image/[^%)]+%)', '')
				doc = doc:gsub('%[MDN [Rr]eference%]%(https?://[^%)]+%)', '')
				doc = doc:gsub('https?://[^%s%)]+', '')
				doc = doc:gsub('Baseline[^\n]*', '')
				doc = doc:gsub('\n\n\n+', '\n\n')
				doc = doc:gsub('^\n+', '')
				doc = doc:gsub('%s+$', '')
				item.documentation = doc
				vim.notify("CSS doc cleaned (string)!", vim.log.levels.INFO)
			end
		end
	end
end

cmp.setup({
	preselect = cmp.PreselectMode.None,
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
		},
		format = function(entry, vim_item)
			preprocess_completion_item(entry)
			return vim_item
		end,
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-j>"] = cmp.mapping(
			cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
			{ "i", "s", "c" }
		),
		["<C-k>"] = cmp.mapping(
			cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
			{ "i", "s", "c" }
		),
		["<C-l>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_jumpable() then
				vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
			else
				fallback()
			end
		end, {
				"i",
				"s",
			}),
		["<C-h>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
			else
				fallback()
			end
		end, {
				"i",
				"s",
			}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end, { "i", "s", "c" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end, { "i", "s", "c" }),
		['<CR>'] = cmp.mapping(function(fallback)
			if cmp.visible() and cmp.get_active_entry() then
				cmp.confirm({ select = false })
			else
				fallback()
			end
		end, { "i", "s", "c" }),
		['<C-s>'] = cmp.mapping.confirm({ select = true }),
	},
	sources = {
		{ name = "calc", max_item_count = 5, priority = 2000 },
		{ name = "luasnip", keyword_length = 2, max_item_count = 5, priority = 1500 },
		{ name = "nvim_lsp", keyword_length = 3, max_item_count = 5, priority = 1000 },
		{ name = "nvim_lsp_signature_help" },
		{ name = "buffer", keyword_length = 3, max_item_count = 5, priority = 500 },
		{ name = "path", keyword_length = 5, max_item_count = 5, priority = 300 },
	},
	experimental = {
		ghost_text = false,
	},
})

cmp.setup.cmdline(":", {
	sources = {
		{ name = "cmdline", keyword_length = 2 },
		{ name = "path" },
	},
})

cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})
