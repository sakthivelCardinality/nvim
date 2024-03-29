return {
	"akinsho/toggleterm.nvim",
	enabled = true,
	event = "VeryLazy",
	version = "*",
	opts = {
		size = 20,
		open_mapping = [[<c-\>]],
		hide_numbers = true,
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		insert_mappings = true,
		persist_size = true,
		direction = "float",
		close_on_exit = true,
		shell = vim.o.shell,
		float_opts = {
			border = "curved",
			winblend = 0,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		function _G.set_terminal_keymaps()
			local _opts = { noremap = true }
			vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], _opts)
			vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], _opts)
			vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], _opts)
			vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], _opts)
			vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], _opts)
		end

		-- ====================================================
		-- Custom terminals
		-- ====================================================
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			direction = "float",
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(0, "t", "<esc>", "<cmd>close<CR>", { silent = false, noremap = true })
				if vim.fn.mapcheck("<esc>", "t") ~= "" then
					vim.api.nvim_buf_del_keymap(term.bufnr, "t", "<esc>")
				end
			end,
		})

		function _lazygit_toggle()
			lazygit:toggle()
		end

		local keymap = vim.keymap -- for conciseness

		keymap.set(
			"n",
			"<leader>gl",
			"<cmd>lua _lazygit_toggle()<CR>",
			{ noremap = true, silent = true, desc = "Lazygit" }
		)

		keymap.set(
			"n",
			"<leader>th",
			"<cmd>ToggleTerm size=10 direction=horizontal<cr>",
			{ desc = "Terminal Horizontal" }
		)

		keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=60 direction=vertical<cr>", { desc = "Terminal Vertical" })
		keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Terminal Float" })
		keymap.set(
			"n",
			"<leader>tt",
			"<cmd>ToggleTerm size=60 direction=vertical<cr>",
			{ desc = "Terminal split Vertical" }
		)
	end,
}
