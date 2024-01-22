return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	config = function()
		local wk = require("which-key")
		wk.register({
			d = { name = "+Debug" },
			da = { name = "+Adapters" },
			r = { name = "+Replace" },
			o = { name = "+Obsidian" },
			u = { name = "+UI" },
			c = { name = "+Code" },
			f = { name = "+File/Find" },
			b = { name = "+Buffer" },
			g = { name = "+Git" },
			q = { name = "+Quit/Session" },
			s = { name = "+Search" },
			w = { name = "+Window" },
			x = { name = "+Diagnostics/Quickfix" },
			t = { name = "+Terminal" },
			m = { name = "+Markdown" },
			["<tab>"] = { name = "+Tab" },
		}, { prefix = "<leader>" })
	end,
}
