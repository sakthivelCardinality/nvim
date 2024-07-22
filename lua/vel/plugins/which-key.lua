return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.add({
			mode = { "n", "v" },
			{ "<leader>d", desc = "+Debug" },
			{"<leader>da", desc = "+Adapters" },
			{"<leader>r", desc = "+Replace" },
			{"<leader>o", desc = "+Obsidian" },
			{"<leader>u", desc = "+UI" },
			{"<leader>c", desc = "+Code" },
			{"<leader>f", desc = "+File/Find" },
			{"<leader>b", desc = "+Buffer" },
			{"<leader>g", desc = "+Git" },
			{"<leader>gh", desc = "+Git Blame" },
			{"<leader>gt", desc = "+Git toggle" },
			{"<leader>q", desc = "+Quit/Session" },
			{"<leader>s", desc = "+Search" },
			{"<leader>w", desc = "+Window" },
			{"<leader>x", desc = "+Diagnostics/Quickfix" },
			{"<leader>t", desc = "+Terminal" },
			{"<leader>m", desc = "+Markdown" },
			{"<leader><tab>", desc = "+Tab" },
			{"[", desc = "+Next" },
			{"]", desc = "+Prev" },
			{"g", desc = "+Goto" },
			{"gs", desc = "+Surround" },
			{"<leader>gd", desc = "+Diff View" },
		})
	end,
}
