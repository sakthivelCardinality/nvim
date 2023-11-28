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
				Comment = { fg = "#ff1493", italic = true },
				CursorLine = { bg = "none" },
				CursorLineNr = { fg = "#fff000", bold = true },
				LineNr = { fg = "#8400ff" },
				NormalFloat = { bg = "none" },
				BufferLineBufferSelected = { bg = "none" },
			},
		},
		config = function(_, opts)
			require("dracula").setup(opts)
			vim.cmd.colorscheme("dracula")

			-- change highlights to differnt colors
			vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "LineNr", { fg = "#8400ff" })
			-- vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#fff000", bold = true })
		end,
	},
}
