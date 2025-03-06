return {
	"nvim-pack/nvim-spectre",
	enabled = false,
	event = { "BufReadPre", "BufNewFile" },
	cmd = "Spectre",
	opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
      { "<leader>sp", function() require("spectre").open_file_search() end, desc = "Replace in current files (Spectre)" },
    },
}
