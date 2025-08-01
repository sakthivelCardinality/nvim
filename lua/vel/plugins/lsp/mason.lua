return {
	"williamboman/mason.nvim",
	event = "VeryLazy",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"svelte",
				"angularls",
				"lua_ls",
				"graphql",
				"emmet_ls",
				"prismals",
				"pyright",
				"bashls",
				"clangd",
				"dockerls",
				"jsonls",
				"marksman",
				"rust_analyzer",
				"sqlls",
				"yamlls",
				"zls",
				"jdtls",
				"denols",
				"gopls",
				"vtsls",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = false, -- not the same as ensure_installed
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"beautysh", -- bash formatter
				"yamlfix", -- yaml formatter
				"google-java-format", -- java formatter
				"prettierd", -- prettierd formatter
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint", -- python linter
				"eslint_d", -- js linter
				"goimports",
				"gofumpt",
				"golangci-lint",
				"luacheck",
				"cspell",
			},
		})
	end,
}
