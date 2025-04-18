return {
	"stevearc/oil.nvim",
	lazy = false,
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		delete_to_trash = true,
		view_options = {
			show_hidden = true,
		},
		keymaps = {
			["q"] = { "actions.close", mode = "n" },
		},
	},
	keys = {
		{
			"<leader>e",
			"<cmd>Oil --float --preview <cr>",
			desc = "Open mini.files (Directory of Current File)",
		},
	},
}
