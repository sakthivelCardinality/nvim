-- return {
-- 	"mbbill/undotree",
-- 	event = "VeryLazy",
-- 	keys = {
-- 		{
-- 			"<leader><F5>",
-- 			function()
-- 				vim.cmd.UndotreeToggle()
-- 			end,
-- 			desc = "open UndotreeToggle",
-- 		},
-- 	},
-- }
--

return {
	"jiaoshijie/undotree",
	event = "VeryLazy",
	dependencies = "nvim-lua/plenary.nvim",
	config = true,
	keys = {
		{ "<leader>uu", "<cmd>lua require('undotree').toggle()<cr>", desc = "Open UndotreeToggle" },
	},
}
