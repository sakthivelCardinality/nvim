return {
	-- {
	-- 	"Mofiqul/dracula.nvim",
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	lazy = false,
	-- 	opts = {
	-- 		-- show the '~' characters after the end of buffers
	-- 		show_end_of_buffer = true, -- default false
	-- 		-- use transparent background
	-- 		transparent_bg = true, -- default false
	-- 		-- set custom lualine background color
	-- 		lualine_bg_color = nil, -- default nil
	-- 		-- set italic comment
	-- 		italic_comment = true, -- default false
	-- 		-- overrides the default highlights with table see `:h synIDattr`
	-- 		overrides = {
	-- 			-- Comment = { fg = "#ff1493", italic = true },
	-- 			CursorLine = { bg = "none" },
	-- 			CursorLineNr = { fg = "#fff000", bold = true },
	-- 			-- LineNr = { fg = "#8400ff" },
	-- 			NormalFloat = { bg = "none" },
	-- 			BufferLineBufferSelected = { bg = "none" },
	-- 			TelescopeNormal = { bg = "none" },
	-- 		},
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("dracula").setup(opts)
	-- 		-- vim.cmd.colorscheme("dracula")
	-- 	end,
	-- },
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
		opts = {
			options = {},
			styles = {
				types = "NONE",
				methods = "italic",
				numbers = "NONE",
				strings = "NONE",
				comments = "italic",
				keywords = "bold,italic",
				constants = "NONE",
				functions = "italic",
				operators = "NONE",
				variables = "NONE",
				parameters = "NONE",
				conditionals = "italic",
				virtual_text = "NONE",
			},
			highlights = {
				CursorLine = { bg = "none" },
				CursorLineNr = { fg = "#fff000", bold = false },
				Whitespace = { fg = "#303642" },
				LineNr = { fg = "#8400ff" },
			},
		},
		config = function(_, opts)
			require("onedarkpro").setup(opts)
			vim.cmd.colorscheme("onedark_dark")
		end,
	},
	-- {
	-- 	"Shatur/neovim-ayu",
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		require("ayu").setup({
	-- 			overrides = {
	-- 				Normal = { bg = "None" },
	-- 				ColorColumn = { bg = "None" },
	-- 				SignColumn = { bg = "None" },
	-- 				Folded = { bg = "None" },
	-- 				FoldColumn = { bg = "None" },
	-- 				CursorLine = { bg = "None" },
	-- 				CursorColumn = { bg = "None" },
	-- 				WhichKeyFloat = { bg = "None" },
	-- 				VertSplit = { bg = "None" },
	-- 			},
	-- 		})
	-- 		-- vim.cmd.colorscheme("ayu-dark")
	-- 	end,
	-- },
	-- {
	-- 	"tiagovla/tokyodark.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {
	-- 		transparent_background = true,
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("tokyodark").setup(opts) -- calling setup is optional
	-- 		-- vim.cmd.colorscheme("tokyodark")
	-- 	end,
	-- },
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {
	-- 		style = "moon",
	-- 		transparent = true,
	-- 		styles = {
	-- 			floats = "transparent",
	-- 			sidebars = "transparent",
	-- 		},
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("tokyonight").setup(opts)
	-- 		-- vim.cmd.colorscheme("tokyonight")
	-- 	end,
	-- },
	-- {
	-- 	"justinsgithub/oh-my-monokai.nvim",
	-- 	config = function()
	-- 		require("oh-my-monokai").setup({
	-- 			transparent_background = true,
	-- 			terminal_colors = true,
	-- 			devicons = true, -- highlight the icons of `nvim-web-devicons`
	-- 			palette = "default", -- or create your own ^^ e.g. justinsgithub
	-- 			inc_search = "background", -- underline | background
	-- 			background_clear = {
	-- 				"float_win",
	-- 				"toggleterm",
	-- 				"telescope",
	-- 				"which-key",
	-- 				"renamer",
	-- 				"neo-tree",
	-- 				"nvim-tree",
	-- 			},
	-- 			plugins = {
	-- 				bufferline = {
	-- 					underline_selected = false,
	-- 					underline_visible = false,
	-- 				},
	-- 				indent_blankline = {
	-- 					context_start_underline = false,
	-- 				},
	-- 			},
	-- 			override = function()
	-- 				return {
	-- 					LineNr = {
	-- 						fg = "#8400ff",
	-- 					},
	-- 					CursorLineNr = {
	-- 						fg = "#fff000",
	-- 					},
	-- 				}
	-- 			end,
	-- 		})
	-- 		vim.cmd.colorscheme("oh-my-monokai")
	-- 	end,
	-- },
}
