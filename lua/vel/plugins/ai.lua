return {
	{
		"github/copilot.vim",
		enabled = false,
		event = "VeryLazy",
		opts = {},
	},
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	enabled = false,
	-- 	cmd = "Copilot",
	-- 	build = ":Copilot auth",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		require("copilot").setup({
	-- 			panel = {
	-- 				enabled = true,
	-- 				auto_refresh = true,
	-- 				keymap = {
	-- 					jump_next = "<c-j>",
	-- 					jump_prev = "<c-k>",
	-- 					accept = "<tab>",
	-- 					refresh = "r",
	-- 					open = "<M-CR>",
	-- 				},
	-- 				layout = {
	-- 					position = "bottom", -- | top | left | right
	-- 					ratio = 0.4,
	-- 				},
	-- 			},
	-- 			suggestion = {
	-- 				enabled = true,
	-- 				auto_trigger = true,
	-- 				debounce = 75,
	-- 				keymap = {
	-- 					accept = "<tab>",
	-- 					accept_word = false,
	-- 					accept_line = false,
	-- 					next = "<c-j>",
	-- 					prev = "<c-k>",
	-- 					dismiss = "<C-e>",
	-- 				},
	-- 			},
	-- 			copilot_node_command = vim.fn.expand("$HOME") .. "/.nvm/versions/node/v20.11.0/bin/node", -- Node.js version must be > 18.x
	-- 		})
	-- 	end,
	-- },
}
