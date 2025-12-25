return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
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
				"python",
				"java",
				"regex",
				"go",
				"gomod",
				"gowork",
				"gosum",
			},
			-- enable highlight
			highlight = { enable = true, additional_vim_regex_highlighting = { "markdown" } },
			-- enable indentation
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
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
			vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
				pattern = { "*.component.html", "*.container.html" },
				callback = function()
					vim.treesitter.start(nil, "angular")
				end,
			})
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close_on_slash = true,
				},
			})
		end,
	},
}
