return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		plugins = { spelling = true },
		defaults = {
			mode = { "n", "v" },
			["<leader>d"] = { name = "+Debug" },
			["<leader>da"] = { name = "+Adapters" },
			["<leader>r"] = { name = "+Replace" },
			["<leader>o"] = { name = "+Obsidian" },
			["<leader>u"] = { name = "+UI" },
			["<leader>c"] = { name = "+Code" },
			["<leader>f"] = { name = "+File/Find" },
			["<leader>b"] = { name = "+Buffer" },
			["<leader>g"] = { name = "+Git" },
			["<leader>gh"] = { name = "+Git Blame" },
			["<leader>gt"] = { name = "+Git toggle" },
			["<leader>q"] = { name = "+Quit/Session" },
			["<leader>s"] = { name = "+Search" },
			["<leader>w"] = { name = "+Window" },
			["<leader>x"] = { name = "+Diagnostics/Quickfix" },
			["<leader>t"] = { name = "+Terminal" },
			["<leader>m"] = { name = "+Markdown" },
			["<leader><tab>"] = { name = "+Tab" },
			["]"] = { name = "+Next" },
			["["] = { name = "+Prev" },
			["g"] = { name = "+Goto" },
			["gs"] = { name = "+Surround" },
			["<leader>gd"] = { name = "+Diff View" },
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.register(opts.defaults)
	end,
}
