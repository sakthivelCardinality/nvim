return {
	{
		"williamboman/mason-lspconfig.nvim",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		opts = {
			-- list of servers for mason to install
			ensure_installed = {
				-- "ts_ls",
				"html",
				"cssls",
				-- "tailwindcss",
				-- "svelte",
				"angularls",
				"lua_ls",
				-- "graphql",
				"emmet_ls",
				-- "prismals",
				-- "pyright",
				"bashls",
				-- "clangd",
				"dockerls",
				"jsonls",
				"marksman",
				"rust_analyzer",
				"sqlls",
				"yamlls",
				-- "zls",
				-- "jdtls",
				-- "denols",
				"gopls",
				"vtsls",
			},
		},
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
			"neovim/nvim-lspconfig",
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"beautysh", -- bash formatter
				"yamlfix", -- yaml formatter
				-- "google-java-format", -- java formatter
				"prettierd", -- prettierd formatter
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				-- "isort", -- python formatter
				-- "black", -- python formatter
				-- "pylint", -- python linter
				"eslint_d", -- js linter
				"goimports",
				"gofumpt",
				"golangci-lint",
				"luacheck",
				"cspell",
			},
		},
		dependencies = {
			"williamboman/mason.nvim",
		},
	},
}
