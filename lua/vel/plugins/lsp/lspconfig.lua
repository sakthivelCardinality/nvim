return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "folke/neodev.nvim", opts = {} },
		{ "saghen/blink.cmp" },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		local blink = require("blink.cmp")

		local keymap = vim.keymap -- for conciseness

		local function diagnostic_goto(next, severity)
			local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
			severity = severity and vim.diagnostic.severity[severity] or nil
			return function()
				go({ severity = severity })
			end
		end

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			if client.name == "gopls" and client.server_capabilities.semanticTokensProvider then
				local semantic = client.config.capabilities.textDocument.semanticTokens
				client.server_capabilities.semanticTokensProvider = {
					full = true,
					legend = {
						tokenTypes = semantic.tokenTypes,
						tokenModifiers = semantic.tokenModifiers,
					},
					range = true,
				}
			end

			opts.buffer = bufnr

			opts.desc = "Show LSP Info"
			keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", opts)

			opts.desc = "Show LSP references"
			keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "Code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>cd", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", diagnostic_goto(true), opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", diagnostic_goto(false), opts) -- jump to next diagnostic in buffer

			opts.desc = "Go to previous error"
			keymap.set("n", "[e", diagnostic_goto(true, "ERROR"), opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next error"
			keymap.set("n", "]e", diagnostic_goto(false, "ERROR"), opts) -- jump to next diagnostic in buffer

			opts.desc = "Go to previous warn"
			keymap.set("n", "[w", diagnostic_goto(true, "WARN"), opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next warn"
			keymap.set("n", "]w", diagnostic_goto(false, "WARN"), opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Signature Help"
			keymap.set("n", "gK", vim.lsp.buf.signature_help, opts)

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>cL", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
		end

		local util = require("lspconfig.util")

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = blink.get_lsp_capabilities(capabilities)

		-- Change the Diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local servers = {
			"html",
			"cssls",
			"clangd",
			-- "tailwindcss",
			"bashls",
			"pyright",
			"sqlls",
			-- "graphql",
			"emmet_ls",
		}

		for _, lsp in ipairs(servers) do
			lspconfig[lsp].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end

		-- configure angularls language server
		local mason_registry = require("mason-registry")
		local angularls_path = mason_registry.get_package("angular-language-server"):get_install_path()

		local cmd = {
			"ngserver",
			"--stdio",
			"--tsProbeLocations",
			table.concat({ angularls_path, vim.fn.getcwd() }, ","),
			"--ngProbeLocations",
			table.concat({ angularls_path .. "/node_modules/@angular/language-server", vim.fn.getcwd() }, ","),
			"--experimental-ivy",
		}

		lspconfig["angularls"].setup({
			cmd = cmd,
			on_new_config = function(new_config, new_root_dir)
				new_config.cmd = cmd
			end,
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure rust server
		lspconfig["rust_analyzer"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			fieltypes = { "rust" },
			root_dir = util.root_pattern("Cargo.toml"),
			settings = {
				["rust_analyzer"] = {
					cargo = {
						allFeatures = true,
					},
				},
			},
		})

		-- configure graphql language server
		-- lspconfig["graphql"].setup({
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- 	filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		-- })

		-- configure typescript server with plugin
		local function organize_imports()
			local params = {
				command = "_typescript.organizeImports",
				arguments = { vim.api.nvim_buf_get_name(0) },
				title = "",
			}
			vim.lsp.buf.execute_command(params)
		end

		lspconfig["ts_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			root_dir = util.root_pattern(
				"package.json",
				"tsconfig.json",
				"jsconfig.json",
				"gulpfile.js",
				"node_modules"
			),
			commands = {
				OrganizeImports = {
					organize_imports,
					description = "Organize Imports",
				},
			},
		})

		lspconfig["denols"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			root_dir = util.root_pattern("deno.json", "deno.jsonc"),
		})

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					telemetry = { enable = false },
					workspace = {
						checkThirdParty = false,
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		lspconfig["gopls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				gopls = {
					gofumpt = true,
					codelenses = {
						gc_details = false,
						generate = true,
						regenerate_cgo = true,
						run_govulncheck = true,
						test = true,
						tidy = true,
						upgrade_dependency = true,
						vendor = true,
					},
					hints = {
						assignVariableTypes = true,
						compositeLiteralFields = true,
						compositeLiteralTypes = true,
						constantValues = true,
						functionTypeParameters = true,
						parameterNames = true,
						rangeVariableTypes = true,
					},
					analyses = {
						-- fieldalignment = true,
						nilness = true,
						unusedparams = true,
						unusedwrite = true,
						useany = true,
					},
					usePlaceholders = true,
					completeUnimported = true,
					staticcheck = true,
					directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
					semanticTokens = true,
				},
			},
		})
	end,
}
