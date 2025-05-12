return {
	"jiaoshijie/undotree",
	event = "VeryLazy",
	dependencies = "nvim-lua/plenary.nvim",
	config = true,
	keys = {
		{ "<leader><F5>", "<cmd>lua require('undotree').toggle()<cr>", desc = "Open UndotreeToggle" },
	},
}
