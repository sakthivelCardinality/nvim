return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	keys = {
		{
			"<leader>mp",
			"<cmd>MarkdownPreview<cr>",
			desc = "Markdown Preview",
		},
		{
			"<leader>ms",
			"<cmd>MarkdownPreviewStop<cr>",
			desc = "Markdown Preview Stop",
		},
		{
			"<leader>mt",
			"<cmd>MarkdownPreviewToggle<cr>",
			desc = "Markdown Preview Toggle",
		},
	},
}
