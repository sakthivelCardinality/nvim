return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		opts = {
			auto_install = true,
			-- ensure these language parsers are installed
			ensure_installed = {
				"json",
				"json5",
				"javascript",
				"typescript",
				"angular",
				"tsx",
				"html",
				"css",
				"sql",
				"prisma",
				"markdown",
				"markdown_inline",
				"yaml",
				"xml",
				"bash",
				"vim",
				"dockerfile",
				"gitignore",
				"c",
				"lua",
				"rust",
				"query",
				"zig",
				"cpp",
				"go",
				"python",
				"java",
			},
			-- enable highlight
			highlight = { enable = true, additional_vim_regex_highlighting = { "markdown" } },
			-- enable indentation
			indent = { enable = true },
			-- enable autotagging (w/ nvim-ts-autotag plugin)
			autotag = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			textobjects = {
				-- select = {
				-- 	enable = true,
				--
				-- 	-- Automatically jump forward to textobj, similar to targets.vim
				-- 	lookahead = true,
				--
				-- 	keymaps = {
				-- 		-- You can use the capture groups defined in textobjects.scm
				-- 		["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
				-- 		["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
				-- 		["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
				-- 		["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },
				--
				-- 		-- works for javascript/typescript files (custom capture I created in after/queries/ecma/textobjects.scm)
				-- 		["a:"] = { query = "@property.outer", desc = "Select outer part of an object property" },
				-- 		["i:"] = { query = "@property.inner", desc = "Select inner part of an object property" },
				-- 		["l:"] = { query = "@property.lhs", desc = "Select left part of an object property" },
				-- 		["r:"] = { query = "@property.rhs", desc = "Select right part of an object property" },
				--
				-- 		["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
				-- 		["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },
				--
				-- 		["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
				-- 		["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },
				--
				-- 		["af"] = {
				-- 			query = "@function.outer",
				-- 			desc = "Select outer part of a method/function definition",
				-- 		},
				-- 		["if"] = {
				-- 			query = "@function.inner",
				-- 			desc = "Select inner part of a method/function definition",
				-- 		},
				--
				-- 		["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
				-- 		["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
				-- 	},
				-- },
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
					goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
					goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
					goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
				},
			},
		},
		config = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				---@type table<string, boolean>
				local added = {}
				opts.ensure_installed = vim.tbl_filter(function(lang)
					if added[lang] then
						return false
					end
					added[lang] = true
					return true
				end, opts.ensure_installed)
			end
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	-- {
	-- 	"nvim-treesitter/nvim-treesitter-context",
	-- 	event = { "BufReadPre", "BufNewFile" },
	-- 	opts = { max_lines = 3 },
	-- 	keys = {
	-- 		{
	-- 			"<leader>ut",
	-- 			function()
	-- 				local tsc = require("treesitter-context")
	-- 				tsc.toggle()
	-- 			end,
	-- 			desc = "Toggle Treesitter Context",
	-- 		},
	-- 	},
	-- },
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		opts = {},
	},
	-- {
	-- 	"windwp/nvim-autopairs",
	-- 	enabled = false,
	-- 	event = "InsertEnter",
	-- 	opts = {
	-- 		check_ts = true,
	-- 		ts_config = {
	-- 			lua = { "string" }, -- it will not add a pair on that treesitter node
	-- 			javascript = { "template_string" },
	-- 			java = false, -- don't check treesitter on java
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	"hiphish/rainbow-delimiters.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("rainbow-delimiters.setup").setup({})
	-- 	end,
	-- },
}
