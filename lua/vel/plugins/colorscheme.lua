return {
	{
		"Mofiqul/dracula.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		lazy = false,
		opts = {
			-- show the '~' characters after the end of buffers
			show_end_of_buffer = true, -- default false
			-- use transparent background
			transparent_bg = true, -- default false
			-- set custom lualine background color
			lualine_bg_color = nil, -- default nil
			-- set italic comment
			italic_comment = true, -- default false
			-- overrides the default highlights with table see `:h synIDattr`
			overrides = {
				-- Comment = { fg = "#ff1493", italic = true },
				CursorLine = { bg = "none" },
				CursorLineNr = { fg = "#fff000", bold = true },
				LineNr = { fg = "#8400ff" },
				NormalFloat = { bg = "none" },
				BufferLineBufferSelected = { bg = "none" },
				TelescopeNormal = { bg = "none" },
			},
		},
		config = function(_, opts)
			require("dracula").setup(opts)
			vim.cmd.colorscheme("dracula")
		end,
	},
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
