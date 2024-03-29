return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	cmd = { "ConformInfo" },
	keys = function()
		local function toggle_format()
			vim.g.conform_autoformat = not vim.g.conform_autoformat
			local auto_format = vim.g.conform_autoformat
			vim.notify("Autoformat: " .. tostring(auto_format))
		end
		vim.api.nvim_create_user_command("ConformFormatToggle", toggle_format, {
			desc = "Auto Format Toggle",
		})

		return {
			{
				"<leader>cf",
				function()
					require("conform").format({
						lsp_fallback = true,
						async = false,
						timeout_ms = 5000,
					})
				end,
				mode = { "n", "v" },
				desc = "Format file or range (in visual mode)",
			},
			{
				"<leader>uf",
				toggle_format,
				mode = { "n", "v" },
				desc = "Auto Format Toggle",
			},
		}
	end,
	config = function()
		local conform = require("conform")
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		vim.g.conform_autoformat = false

		conform.setup({
			formatters_by_ft = {
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				javascriptreact = { { "prettierd", "prettier" } },
				typescriptreact = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
				graphql = { { "prettierd", "prettier" } },
				svelte = { { "prettierd", "prettier" } },
				css = { { "prettierd", "prettier" } },
				scss = { { "prettierd", "prettier" } },
				html = { { "prettierd", "prettier" } },
				yaml = { "yamlfix" },
				bash = { "beautysh" },
				markdown = { { "prettierd", "prettier" } },
				lua = { "stylua" },
				python = { "isort", "black" },
				java = { "google-java-format" },
			},
			format_on_save = function()
				if vim.g.conform_autoformat == false then
					return
				end
				return {
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				}
			end,
		})
	end,
}
