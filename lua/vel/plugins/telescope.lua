return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		branch = "0.1.x",
		cmd = "Telescope",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				event = "VeryLazy",
				build = "make",
				config = function()
					require("telescope").load_extension("fzf")
				end,
			},
		},
		keys = {
			{ "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
			{ "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep (root dir)" },
			{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			{
				"<leader><space>",
				function()
					require("vel.core.utils").telescope_git_or_file()
				end,
				desc = "Find Files (root dir)",
			},
			-- find
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files (root dir)" },
			{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Find symbols Files" },
			{ "<leader>fS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Find symbols Workspace" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
			{ "<leader>fg", "<cmd>Telescope grep_string<cr>", desc = "Grep String" },
			-- git
			{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
			{ "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
			{ "<leader>gf", "<cmd>Telescope git_files<CR>", desc = "Files" },
			{ "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Branches" },
			-- search
			{ '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
			{ "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
			{
				"<leader>sb",
				"<cmd>Telescope current_buffer_fuzzy_find<cr>",
				desc = "[/] Fuzzily search in current buffer",
			},
			{ "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			{ "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
			{ "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
			{ "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
			{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
			{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
			{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
			{ "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Find symbols Files" },
			{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
			{ "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
			{
				"<S-h>",
				function()
					require("telescope.builtin").buffers({
						sort_mru = true,
						sort_lastused = true,
						initial_mode = "normal",
					})
				end,
				desc = "Open telescope buffers",
			},
		},
		opts = {
			-- change the stype for the telescope find_files and git_files
			defaults = require("telescope.themes").get_ivy({
				path_display = function(_, path)
					return require("vel.core.utils").change_path_display(path)
				end,
				layout_config = {
					preview_width = 0.4,
				},
				file_ignore_patterns = { ".git/", "node_modules/", "dist/", "target/", ".angular/", "src/assets" },
				mappings = {
					i = {
						["<esc>"] = function(...)
							require("telescope.actions").close(...)
						end,
						["<C-k>"] = function(...)
							require("telescope.actions").move_selection_previous(...) -- move to prev result
						end,
						["<C-j>"] = function(...)
							require("telescope.actions").move_selection_next(...) -- move to next result
						end,
						["<M-p>"] = function(...)
							require("telescope.actions.layout").toggle_preview(...)
						end,
						["<C-Down>"] = function(...)
							require("telescope.actions").cycle_history_next(...)
						end,
						["<C-Up>"] = function(...)
							require("telescope.actions").cycle_history_prev(...)
						end,
					},
					n = {
						["<M-p>"] = function(...)
							require("telescope.actions.layout").toggle_preview(...)
						end,
						["d"] = function(...)
							require("telescope.actions").delete_buffer(...)
						end,
						["q"] = function(...)
							require("telescope.actions").close(...)
						end,
					},
				},
			}),
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			local utils = require("vel.core.utils")

			-- change parent directory highlights style
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "TelescopeResults",
				group = utils.augroup("telescope_result"),
				callback = function(ctx)
					vim.api.nvim_buf_call(ctx.buf, function()
						vim.fn.matchadd("TelescopeParent", "\t\t.*$")
						vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
					end)
				end,
			})
		end,
	},
	-- {
	-- 	"nvim-telescope/telescope-ui-select.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("telescope").setup({
	-- 			extensions = {
	-- 				["ui-select"] = {
	-- 					require("telescope.themes").get_dropdown({}),
	-- 				},
	-- 			},
	-- 		})
	-- 		require("telescope").load_extension("ui-select")
	-- 	end,
	-- },
}
