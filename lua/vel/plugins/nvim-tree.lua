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

		local HEIGHT_RATIO = 0.8 -- You can change this
		local WIDTH_RATIO = 0.5 -- You can change this too

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
			},
			view = {
				adaptive_size = true,
				side = "right",
				relativenumber = false,
				width = 40,
				signcolumn = "yes",

				-- Added below for the float window
				-- float = {
				-- 	enable = true,
				-- 	open_win_config = function()
				-- 		local screen_w = vim.opt.columns:get()
				-- 		local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
				-- 		local window_w = screen_w * WIDTH_RATIO
				-- 		local window_h = screen_h * HEIGHT_RATIO
				-- 		local window_w_int = math.floor(window_w)
				-- 		local window_h_int = math.floor(window_h)
				-- 		local center_x = (screen_w - window_w) / 2
				-- 		local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
				-- 		return {
				-- 			border = "rounded",
				-- 			relative = "editor",
				-- 			row = center_y,
				-- 			col = center_x,
				-- 			width = window_w_int,
				-- 			height = window_h_int,
				-- 		}
				-- 	end,
				-- },
				-- width = function()
				-- 	return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
				-- end,
			},
			git = {
				enable = true,
				ignore = false,
			},
			filesystem_watchers = {
				enable = true,
				ignore_dirs = {
					"node_modules",
					"dist",
					".angular",
				},
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
				highlight_git = true,
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

		keymap.set("n", "<leader>fe", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file in explorer" }) -- toggle file explorer
		-- keymap.set("n", "<leader>ee", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
		-- keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		-- keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
	end,
}
