return {
	"lukas-reineke/indent-blankline.nvim",
	event = "VeryLazy",
	main = "ibl",
	opts = {
		indent = {
			char = "│",
			tab_char = "│",
		},
		scope = { enabled = false },
		exclude = {
			filetypes = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"nvim-tree",
				"Trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
			},
		},
	},
}
