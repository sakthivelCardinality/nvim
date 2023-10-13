return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
       -- stylua: ignore
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        -- stylua: ignore
        right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
			diagnostics = "nvim_lsp",
			always_show_bufferline = true,
		},
	},
	config = function(_, opts)
		require("bufferline").setup(opts)
		-- Fix bufferline when restoring a session
		vim.api.nvim_create_autocmd("BufAdd", {
			callback = function()
				vim.schedule(function()
					pcall(nvim_bufferline)
				end)
			end,
		})
	end,
}
