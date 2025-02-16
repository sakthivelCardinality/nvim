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
				mode = { "n" },
				desc = "Format file",
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
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				graphql = { "prettierd", "prettier", stop_after_first = true },
				svelte = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				scss = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "yamlfix" },
				bash = { "beautysh" },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				lua = { "stylua" },
				python = { "isort", "black" },
				java = { "google-java-format" },
				go = { "goimports", "gofumpt" },
			},
			format_on_save = function()
				if vim.g.conform_autoformat == false then
					return
				end
				return { lsp_fallback = true, async = false, timeout_ms = 1000 }
			end,
		})

		vim.api.nvim_create_user_command("ConformRangeFormat", function(args)
			local range = nil
			if args.count ~= -1 then
				local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
				range = {
					start = { args.line1, 0 },
					["end"] = { args.line2, end_line:len() },
				}
			end
			require("conform").format({ async = true, lsp_format = "fallback", range = range }, function(err)
				if not err then
					local mode = vim.api.nvim_get_mode().mode
					if vim.startswith(string.lower(mode), "v") then
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
					end
				end
			end)
		end, { range = true })

		vim.keymap.set({ "v" }, "<leader>cf", "<cmd>ConformRangeFormat<cr>", { desc = "Range Format" })
	end,
}
