return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- configure nvim-tree
		nvimtree.setup({
			live_filter = {
				prefix = "[FILTER]: ",
				always_show_folders = false, -- Turn into false from true by default
			},
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
						enable = false,
					},
					quit_on_open = false,
					resize_window = true,
				},
			},
			renderer = {
				root_folder_label = ":~:s?$?/..?",
				highlight_git = true,
				highlight_opened_files = "none",
				group_empty = true,

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

		local utils = require("vel.core.utils")

		-- Float window resize
		local tree_api = require("nvim-tree")
		local tree_view = require("nvim-tree.view")
		vim.api.nvim_create_autocmd({ "VimResized" }, {
			group = utils.augroup("NvimTreeResize"),
			callback = function()
				if tree_view.is_visible() then
					tree_view.close()
					tree_api.open()
				end
			end,
		})

		-- Go to last used hidden buffer when deleting a buffer
		vim.api.nvim_create_autocmd("BufEnter", {
			group = utils.augroup("NvimTreeLastUsedBuffer"),
			nested = true,
			callback = function()
				local api = require("nvim-tree.api")

				-- Only 1 window with nvim-tree left: we probably closed a file buffer
				if #vim.api.nvim_list_wins() == 1 and api.tree.is_tree_buf() then
					-- Required to let the close event complete. An error is thrown without this.
					vim.defer_fn(function()
						-- close nvim-tree: will go to the last hidden buffer used before closing
						api.tree.toggle({ find_file = true, focus = true })
						-- re-open nivm-tree
						api.tree.toggle({ find_file = true, focus = true })
						-- nvim-tree is still the active window. Go to the previous window.
						vim.cmd("wincmd p")
					end, 0)
				end
			end,
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file in explorer" }) -- toggle file explorer
		-- keymap.set("n", "<leader>ee", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
		-- keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		-- keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
	end,
}
