return {
	"nvim-lualine/lualine.nvim",
	enabled = false,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local config = {
			options = {
				theme = "auto",
				globalstatus = true,
				disabled_filetypes = { statusline = { "dashboard" } },
			},
			sections = {
				lualine_c = {
					{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
					{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "filetype" },
				},
				lualine_y = {
					{ "progress", separator = " ", padding = { left = 1, right = 1 } },
				},
				-- lualine_z = {
				-- 	function()
				-- 		return os.date("%r")
				-- 	end,
				-- },
			},
		}

		lualine.setup(config)
	end,
}
