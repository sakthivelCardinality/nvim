return {
	{ "echasnovski/mini.statusline", event = "VeryLazy", opts = {} },
	{ "echasnovski/mini.cursorword", event = "VeryLazy", opts = {} },
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {
			modes = { insert = true, command = true, terminal = false },
			-- skip autopair when next character is one of these
			skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
			-- skip autopair when the cursor is inside these treesitter nodes
			skip_ts = { "string" },
			-- skip autopair when next character is closing pair
			-- and there are more closing pairs than opening pairs
			skip_unbalanced = true,
			-- better deal with markdown code blocks
			markdown = true,
		},
	},
	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
					e = { -- Word with case
						{
							"%u[%l%d]+%f[^%l%d]",
							"%f[%S][%l%d]+%f[^%l%d]",
							"%f[%P][%l%d]+%f[^%l%d]",
							"^[%l%d]+%f[^%l%d]",
						},
						"^().*()$",
					},
					g = function(ai_type) -- Whole buffer, similar to `gg` and 'G' motion
						local start_line, end_line = 1, vim.fn.line("$")
						if ai_type == "i" then
							-- Skip first and last blank lines for `i` textobject
							local first_nonblank, last_nonblank =
								vim.fn.nextnonblank(start_line), vim.fn.prevnonblank(end_line)
							-- Do nothing for buffer with all blanks
							if first_nonblank == 0 or last_nonblank == 0 then
								return { from = { line = start_line, col = 1 } }
							end
							start_line, end_line = first_nonblank, last_nonblank
						end

						local to_col = math.max(vim.fn.getline(end_line):len(), 1)
						return { from = { line = start_line, col = 1 }, to = { line = end_line, col = to_col } }
					end,
				},
			}
		end,
	},
	{
		"echasnovski/mini.hipatterns",
		event = "VeryLazy",
		config = function()
			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})
		end,
	},
	{
		"echasnovski/mini.indentscope",
		event = "VeryLazy",
		opts = {
			symbol = "│",
			options = {
				try_as_border = true,
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"dashboard",
					"lazy",
					"mason",
					"toggleterm",
					"NvimTree",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
	{
		"echasnovski/mini.surround",
		event = "VeryLazy",
		opts = {
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
			},
		},
	},
	{
		"echasnovski/mini.bufremove",
		enabled = false,
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"<leader>bd",
				function()
					local bd = require("mini.bufremove").delete
					if vim.bo.modified then
						local choice =
							vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
						if choice == 1 then -- Yes
							vim.cmd.write()
							bd(0)
						elseif choice == 2 then -- No
							bd(0, true)
						end
					else
						bd(0)
					end
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>bD",
				function()
					require("mini.bufremove").delete(0, true)
				end,
				desc = "Delete Buffer (Force)",
			},
		},
	},
	{
		"echasnovski/mini.files",
		event = "VeryLazy",
		keys = {
			{
				"<leader>e",
				function()
					require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
				end,
				desc = "Open mini.files (Directory of Current File)",
			},
			{
				"<leader>E",
				function()
					require("mini.files").open(vim.uv.cwd(), true)
				end,
				desc = "Open mini.files (cwd)",
			},
		},
		opts = {
			options = {
				-- Whether to use for editing directories
				-- Disabled by default in LazyVim because neo-tree is used for that
				use_as_default_explorer = true,
				-- If set to false, files are moved to the trash directory
				-- To get this dir run :echo stdpath('data')
				-- ~/.local/share/neobean/mini.files/trash
				permanent_delete = false,
			},
			windows = {
				preview = true,
				width_focus = 30,
				width_preview = 50,
			},
			mappings = {
				close = "q",
				-- Use this if you want to open several files
				go_in = "l",
				-- This opens the file, but quits out of mini.files (default L)
				go_in_plus = "<CR>",
				-- I swapped the following 2 (default go_out: h)
				-- go_out_plus: when you go out, it shows you only 1 item to the right
				-- go_out: shows you all the items to the right
				go_out = "H",
				go_out_plus = "h",
				-- Default <BS>
				reset = ",",
				-- Default @
				reveal_cwd = ".",
				show_help = "g?",
				-- Default =
				synchronize = "s",
				trim_left = "<",
				trim_right = ">",
			},
		},
	},
}
