return {
	"nvim-tree/nvim-tree.lua",
	event = "VeryLazy",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- configure nvim-tree
		nvimtree.setup({
			filters = {
				dotfiles = false,
				exclude = { vim.fn.stdpath("config") .. "/lua/custom" },
			},
			disable_netrw = true,
			hijack_netrw = true,
			hijack_cursor = true,
			hijack_unnamed_buffer_when_opening = false,
			sync_root_with_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			view = {
				adaptive_size = true,
				side = "right",
				relativenumber = false,
				width = 40,
				signcolumn = "yes",
			},
			git = {
				enable = true,
				ignore = false,
			},
			filesystem_watchers = {
				enable = true,
			},
			actions = {
				open_file = {
				  window_picker = {
				    enable = false
				  },
					quit_on_open = false,
					resize_window = true,
				},
			},
			renderer = {
				root_folder_label = true,
				highlight_git = true,
				highlight_opened_files = "none",

				indent_markers = {
					enable = false,
				},

				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},

					glyphs = {
						default = "󰈚",
						symlink = "",
						folder = {
							default = "",
							empty = "",
							empty_open = "",
							open = "",
							symlink = "",
							symlink_open = "",
							arrow_open = "",
							arrow_closed = "",
						},
						git = {
							unstaged = "✗",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "★",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},
		})

		-- Automatically open file upon creation
		local api = require("nvim-tree.api")
		api.events.subscribe(api.events.Event.FileCreated, function(file)
			vim.cmd("edit " .. file.fname)
		end)

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file in explorer" }) -- toggle file explorer
		-- keymap.set("n", "<leader>ee", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
		-- keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		-- keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
	end,
}
