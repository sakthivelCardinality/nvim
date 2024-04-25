return {
	"utilyre/barbecue.nvim",
	event = "VeryLazy",
	name = "barbecue",
	version = "*",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons", -- optional dependency
	},
	opts = {
		-- configurations go here
		create_autocmd = false, -- prevent barbecue from updating itself automatically
	},
	config = function(_, opts)
		local barbecue = require("barbecue")
		barbecue.setup(opts)

		vim.keymap.set({ "n" }, "<leader>ub", function()
			require("barbecue.ui").toggle()
		end, { desc = "Barbecue Toggle" })

		local utils = require("vel.core.utils")
		vim.api.nvim_create_autocmd({
			"WinScrolled", -- or WinResized on NVIM-v0.9 and higher
			"BufWinEnter",
			"CursorHold",
			"InsertLeave",

			-- include this if you have set `show_modified` to `true`
			-- "BufModifiedSet",
		}, {
			group = utils.augroup("barbecue.updater"),
			callback = function()
				require("barbecue.ui").update()
			end,
		})
	end,
}
