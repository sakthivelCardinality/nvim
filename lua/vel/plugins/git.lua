return {
	{ "tpope/vim-fugitive", enabled = false, event = { "BufReadPre", "BufNewFile" } },
	{
		"NeogitOrg/neogit",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"<leader>gg",
				function()
					local neogit = require("neogit")
					neogit.open({ kind = "auto" })
				end,
				desc = "Neogit toggle",
				mode = { "n" },
			},
		},
		opts = {},
	},
	{
		"sindrets/diffview.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"<leader>gdo",
				"<cmd>DiffviewOpen<cr>",
				desc = "Open",
				mode = { "n" },
			},
			{
				"<leader>gdc",
				"<cmd>DiffviewClose<cr>",
				desc = "Close",
				mode = { "n" },
			},
			{
				"<leader>gdr",
				"<cmd>DiffviewRefresh<cr>",
				desc = "Refresh",
				mode = { "n" },
			},
			{
				"<leader>gdh",
				"<cmd>DiffviewFileHistory %<cr>",
				desc = "Current File History",
				mode = { "n" },
			},
			{
				"<leader>gdH",
				"<cmd>DiffviewFileHistory<cr>",
				desc = "File History",
				mode = { "n" },
			},
		},
		opts = {},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			current_line_blame = true,
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

				-- Action
				map("n", "]h", function()
					if vim.wo.diff then
						return "]h"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, "Next Hunk")

				map("n", "[h", function()
					if vim.wo.diff then
						return "[h"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, "Previous Hunk")

				-- visual mode
				map("v", "<leader>ghs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "git stage git hunk")
				map("v", "<leader>ghr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "git reset git hunk")

				-- normal mode
				map("n", "<leader>ghs", gs.stage_hunk, "git stage hunk")
				map("n", "<leader>ghr", gs.reset_hunk, "git reset hunk")
				map("n", "<leader>ghS", gs.stage_buffer, "git Stage Buffer")
				map("n", "<leader>ghu", gs.undo_stage_hunk, "git Undo Stage Hunk")
				map("n", "<leader>ghR", gs.reset_buffer, "git Reset Buffer")
				map("n", "<leader>ghp", gs.preview_hunk, "git Preview Hunk")
				map("n", "<leader>ghb", function()
					gs.blame_line({ full = true })
				end, "git Blame Line")
				map("n", "<leader>ghd", gs.diffthis, "git Diff This")
				map("n", "<leader>ghD", function()
					gs.diffthis("~")
				end, "git Diff This ~")

				-- Toggle Git Ui
				map("n", "<leader>gtb", gs.toggle_current_line_blame, "Toggle Git Line Blame")
				map("n", "<leader>gtd", gs.toggle_deleted, "Toggle Git Delete")

				-- Text Object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	},
}
