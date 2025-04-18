return {
	"MeanderingProgrammer/render-markdown.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		render_modes = { "n", "c", "t" },
	},
}
