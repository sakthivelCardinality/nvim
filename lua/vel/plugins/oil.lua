return {
	"stevearc/oil.nvim",
	enabled = false,
	lazy = false,
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
			"<cmd>Oil --float <cr>",
			desc = "Open mini.files (Directory of Current File)",
		},
	},
}
