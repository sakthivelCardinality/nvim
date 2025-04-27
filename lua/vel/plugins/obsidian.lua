return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	event = "VeryLazy",
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{
			"<leader>oo",
			"<cmd>ObsidianNew weekly.md<cr>",
			desc = "Open weekly notes",
			mode = { "n" },
		},
		{
			"<leader>on",
			"<cmd>ObsidianNew<cr>",
			desc = "Create New Obsidian Note",
			mode = { "n" },
		},
		{
			"<leader>ot",
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
		{
			"<leader>oT",
			"<cmd>ObsidianTemplate<cr>",
			desc = "Switch Obsidian Template",
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

		-- Optional, if you keep notes in a specific subdirectory of your vault.
		notes_subdir = "notes/custom",

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
			-- Smart action depending on context, either follow link or toggle checkbox.
			["<cr>"] = {
				action = function()
					return require("obsidian").util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			},
		},

		-- Optional, customize how names/IDs for new notes are created.
		note_id_func = function(title)
			-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
			-- In this case a note with the title 'My new note' will given an ID that looks
			-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
			local suffix = ""
			if title ~= nil then
				-- If title is given, transform it into valid file name.
				suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				local userValue = vim.fn.input("File Name : ")
				suffix = userValue
				if suffix == "" then
					-- If title is nil, just add 4 random uppercase letters to the suffix.
					for _ = 1, 4 do
						suffix = suffix .. string.char(math.random(65, 90))
					end
					suffix = tostring(os.date("%Y-%m-%d")) .. "-" .. suffix
				end
			end
			return suffix
		end,

		-- Optional, alternatively you can customize the frontmatter data.
		note_frontmatter_func = function(note)
			-- This is equivalent to the default frontmatter function.
			local out = { id = note.id, aliases = note.aliases, tags = note.tags }
			-- `note.metadata` contains any manually added fields in the frontmatter.
			-- So here we just make sure those fields are kept in the frontmatter.
			if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
				for k, v in pairs(note.metadata) do
					out[k] = v
				end
			end
			return out
		end,

		-- Optional, for templates (see below).
		templates = {
			subdir = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
			-- A map for custom variables, the key should be the variable and the value a function
			substitutions = {},
		},

		attachments = {
			img_folder = "assets/imgs", -- This is the default

			img_text_func = function(client, path)
				local link_path
				local vault_relative_path = client:vault_relative_path(path)
				if vault_relative_path ~= nil then
					-- Use relative path if the image is saved in the vault dir.
					link_path = vault_relative_path
				else
					-- Otherwise use the absolute path.
					link_path = tostring(path)
				end
				link_path = "../../" .. link_path
				local display_name = vim.fs.basename(link_path)
				return string.format("![%s](%s)", display_name, link_path)
			end,
		},
	},
}
