return {
	"numToStr/Comment.nvim",
	enabled = false,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			enabled = false,
			opts = {},
		},
	},
	opts = {},
}
