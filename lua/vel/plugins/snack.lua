return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		quickfile = { enabled = true },
		words = { enabled = true },
		statuscolumn = {
			enabled = true,
		},
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		dashboard = {
			enabled = true,
						preset = {
						  header = [[
██╗   ██╗███████╗██╗     
██║   ██║██╔════╝██║     
██║   ██║█████╗  ██║     
╚██╗ ██╔╝██╔══╝  ██║     
 ╚████╔╝ ███████╗███████╗
  ╚═══╝  ╚══════╝╚══════╝]]
						}
		},
		indent = { enabled = true },
		scope = { enabled = true },
		explorer = { enabled = false },
	},
	keys = {
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
		{
			"<leader>gl",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>cR",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Rename File",
		},
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next Reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},
		{
			"<leader>z",
			function()
				Snacks.zen()
			end,
			desc = "Toggle Zen Mode",
		},
		{
			"<leader>E",
			function()
				Snacks.explorer({
					auto_close = true,
					layout = { layout = { position = "right" } },
				})
			end,
			desc = "File Explorer",
		},
	},
	init = function()
		local utils = require("vel.core.utils")
		---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			group = utils.augroup("User"),
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create some toggle mappings
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle
					.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle.inlay_hints():map("<leader>uh")
				Snacks.toggle.indent():map("<leader>ug")
				Snacks.toggle.dim():map("<leader>uD")
			end,
		})
	end,
}
