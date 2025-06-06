return {
	"L3MON4D3/LuaSnip",
	enabled = true,
	version = "v2.*",
	build = "make install_jsregexp",
	event = "InsertEnter",
	dependencies = {
		"rafamadriz/friendly-snippets",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })
		end,
	},
	opts = {
		history = true,
		delete_check_events = "TextChanged",
	},
	keys = {
		-- {
		-- 	"<tab>",
		-- 	function()
		-- 		return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
		-- 	end,
		-- 	expr = true,
		-- 	silent = true,
		-- 	mode = "i",
		-- },
		-- {
		-- 	"<tab>",
		-- 	function()
		-- 		require("luasnip").jump(1)
		-- 	end,
		-- 	mode = "s",
		-- },
		-- {
		-- 	"<s-tab>",
		-- 	function()
		-- 		require("luasnip").jump(-1)
		-- 	end,
		-- 	mode = { "i", "s" },
		-- },
	},
}
