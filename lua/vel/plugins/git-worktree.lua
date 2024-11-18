return {
	"ThePrimeagen/git-worktree.nvim",
	enabled = false,
	event = "VeryLazy",
	opts = {},
	config = function()
		require("telescope").load_extension("git_worktree")
	end,
	keys = {
		{
			"<leader>gw",
			function()
				require("telescope").extensions.git_worktree.git_worktrees()
			end,
			desc = "show all branch in git-worktree",
			mode = { "n" },
		},
		{
			"<leader>gW",
			function()
				require("telescope").extensions.git_worktree.create_git_worktree()
			end,
			desc = "create new branch in git-worktree",
			mode = { "n" },
		},
	},
}
