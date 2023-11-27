return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{
			"<leader>on",
			"<cmd>ObsidianNew<cr>",
			desc = "Create New Obsidian Note",
			mode = { "n" },
		},
		{
			"<leader>oo",
			"<cmd>ObsidianToday<cr>",
			desc = "Open Today Obsidian Note",
			mode = { "n" },
		},
		{
			"<leader>oy",
			"<cmd>ObsidianYesterday<cr>",
			desc = "Open Yesterday Obsidian Note",
			mode = { "n" },
		},
		{
			"<leader>os",
			"<cmd>ObsidianQuickSwitch<cr>",
			desc = "Search Obsidian Notes In Vault",
			mode = { "n" },
		},
		{
			"<leader>og",
			"<cmd>ObsidianSearch<cr>",
			desc = "Search Obsidian Notes Using Grep",
			mode = { "n" },
		},
		{
			"<leader>op",
			"<cmd>ObsidianPasteImg<cr>",
			desc = "Paste Image and move to image to particular path",
			mode = { "n" },
		},
		{
			"<leader>ow",
			"<cmd>ObsidianWorkspace<cr>",
			desc = "Switch Obsidian Workspace",
			mode = { "n" },
		},
	},
	opts = {
		workspaces = {
			{
				name = "work",
				path = "~/my-vault",
			},
		},

		daily_notes = {
			-- Optional, if you keep daily notes in a separate directory.
			folder = "notes/dailies",
			-- Optional, if you want to change the date format for the ID of daily notes.
			date_format = "%Y-%m-%d",
			-- Optional, if you want to change the date format of the default alias of daily notes.
			alias_format = "%B %-d, %Y",
			-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
			template = nil,
		},

		-- Optional, key mappings.
		mappings = {
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			-- Toggle check-boxes.
			["<leader>oh"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true, desc = "Toggle CheckBoxes" },
			},
		},
	},
}
