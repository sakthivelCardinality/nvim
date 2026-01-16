return {
	"neovim/nvim-lspconfig",
	enabled = true,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
    { "folke/lazydev.nvim", opts = {} },
	},
	config = function()
	end,
}
