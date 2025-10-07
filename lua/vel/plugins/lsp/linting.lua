return {
	"mfussenegger/nvim-lint",
	enabled = true,
	events = { "BufWritePost", "BufReadPost" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d", "cspell" },
			typescript = { "eslint_d", "cspell" },
			javascriptreact = { "eslint_d", "cspell" },
			typescriptreact = { "eslint_d", "cspell" },
			svelte = { "eslint_d" },
			python = { "pylint", "cspell" },
			go = { "golangci-lint", "cspell" },
			lua = { "luacheck", "cspell" },
			html = { "cspell" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>cl", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
