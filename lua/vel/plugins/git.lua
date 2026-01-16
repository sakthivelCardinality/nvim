return {
	{
		"tpope/vim-fugitive",
		enabled = true,
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"<leader>gg",
				"<cmd>Git<cr>",
				desc = "Git Toggle",
				mode = { "n" },
			},
			{
				"<leader>gdo",
				"<cmd>Gvdiffsplit!<cr>",
				desc = "Git Diff Open",
				mode = { "n" },
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			current_line_blame = true,
			attach_to_untracked = true,
			on_attach = function(buffer)
				local gs = require("gitsigns")

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

				-- Action
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.nav_hunk("next")
					end)
					return "<Ignore>"
				end, "Goto Next Git Hunk")

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.nav_hunk("prev")
					end)
					return "<Ignore>"
				end, "Goto Previous Git Hunk")

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
				-- map("n", "<leader>ghu", gs.undo_stage_hunk, "git Undo Stage Hunk")
				map("n", "<leader>ghR", gs.reset_buffer, "git Reset Buffer")
				map("n", "<leader>ghp", gs.preview_hunk, "git Preview Hunk")
				map("n", "<leader>ghi", gs.preview_hunk_inline, "git Preview Inline Hunk")
				map("n", "<leader>ghb", function()
					gs.blame_line({ full = true })
				end, "git Blame Line")
				map("n", "<leader>ghd", gs.diffthis, "git Diff This")
				map("n", "<leader>ghD", function()
					gs.diffthis("~")
				end, "git Diff This ~")

				-- Quickfix list
				map("n", "<leader>ghq", gs.setqflist, "git Quickfix List")
				map("n", "<leader>ghQ", function()
					gs.setqflist("all")
				end, "git Quickfix List All")

				-- Toggle Git Ui
				map("n", "<leader>gtb", gs.toggle_current_line_blame, "Toggle Git Line Blame")
				map("n", "<leader>gtd", gs.toggle_deleted, "Toggle Git Delete")
				map("n", "<leader>gtw", gs.toggle_word_diff, "Toggle Git Word Diff")

				-- Text Object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	},
	-- {
	-- 	"ThePrimeagen/git-worktree.nvim",
	-- 	enabled = true,
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		local Worktree = require("git-worktree")
	-- 		Worktree.setup({
	-- 			change_directory_command = "cd",
	-- 		})
	-- 		require("telescope").load_extension("git_worktree")
	-- 	end,
	-- 	keys = {
	-- 		{
	-- 			"<leader>gw",
	-- 			function()
	-- 				require("telescope").extensions.git_worktree.git_worktrees()
	-- 			end,
	-- 			desc = "Git Worktrees",
	-- 			mode = { "n" },
	-- 		},
	-- 		{
	-- 			"<leader>gW",
	-- 			function()
	-- 				require("telescope").extensions.git_worktree.create_git_worktree()
	-- 			end,
	-- 			desc = "Create Git Worktree",
	-- 			mode = { "n" },
	-- 		},
	-- 	},
	-- },
}
