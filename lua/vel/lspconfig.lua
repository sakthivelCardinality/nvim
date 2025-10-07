-- Diagnostics {{{
local config = {
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
	virtual_lines = false,
	virtual_text = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "single",
		source = "always",
		header = "",
		prefix = "",
		suffix = "",
	},
}
vim.diagnostic.config(config)
-- }}}

-- Improve LSPs UI {{{
local icons = {
	Class = " ",
	Color = " ",
	Constant = " ",
	Constructor = " ",
	Enum = " ",
	EnumMember = " ",
	Event = " ",
	Field = " ",
	File = " ",
	Folder = " ",
	Function = "󰊕 ",
	Interface = " ",
	Keyword = " ",
	Method = "ƒ ",
	Module = "󰏗 ",
	Property = " ",
	Snippet = " ",
	Struct = " ",
	Text = " ",
	Unit = " ",
	Value = " ",
	Variable = " ",
}

local completion_kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(completion_kinds) do
	completion_kinds[i] = icons[kind] and icons[kind] .. kind or kind
end
-- }}}

-- adding blink to completion
local blink_capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("*", { capabilities = blink_capabilities })
-- }}}

-- Lsp capabilities and on_attach {{{
-- Here we grab default Neovim capabilities and extend them with ones we want on top
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.foldingRange = {
	dynamicRegistration = true,
	lineFoldingOnly = true,
}

capabilities.textDocument.semanticTokens.multilineTokenSupport = true
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config("*", {
	capabilities = capabilities,
})
-- }}}

-- Disable the default keybinds {{{
for _, bind in ipairs({ "grn", "gra", "gri", "grr" }) do
	pcall(vim.keymap.del, "n", bind)
end
-- }}}

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local bufnr = ev.buf
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if not client then
			return
		end
		---@diagnostic disable-next-line need-check-nil
		if client.server_capabilities.completionProvider then
			vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
			-- vim.bo[bufnr].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
		end
		---@diagnostic disable-next-line need-check-nil
		if client.server_capabilities.definitionProvider then
			vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
		end

		-- -- nightly has inbuilt completions, this can replace all completion plugins
		-- if client:supports_method("textDocument/completion", bufnr) then
		--   -- Enable auto-completion
		--   vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
		-- end

		--- Disable semantic tokens
		---@diagnostic disable-next-line need-check-nil
		client.server_capabilities.semanticTokensProvider = nil

		-- All the keymaps

		local function diagnostic_goto(next, severity)
			local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
			severity = severity and vim.diagnostic.severity[severity] or nil
			return function()
				go({ severity = severity })
			end
		end

		local keymap = vim.keymap.set
		local lsp = vim.lsp
		local opts = { silent = true }
		local function opt(desc, others)
			return vim.tbl_extend("force", opts, { desc = desc }, others or {})
		end

		keymap("n", "<leader>cl", vim.cmd.LspInfo, opt("Show LSP Info"))

		keymap("n", "<leader>cq", vim.cmd.LspRestart, opt("LSP Restart"))

		keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opt("Show LSP references")) -- show definition, references

		keymap("n", "gD", vim.lsp.buf.declaration, opt("Go to declaration")) -- go to declaration

		keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opt("Show LSP definitions")) -- show lsp definitions

		keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opt("Show LSP implementations")) -- show lsp implementations

		keymap("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opt("Show LSP type definitions")) -- show lsp type definitions

		keymap({ "n", "v" }, "<leader>ca", lsp.buf.code_action, opt("Code actions")) -- see available code actions, in visual mode will apply to selection

		keymap("n", "<leader>cr", lsp.buf.rename, opt("Smart rename")) -- smart rename

		keymap("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opt("Show buffer diagnostics")) -- show  diagnostics for file

		keymap("n", "<leader>cd", vim.diagnostic.open_float, opt("Show line diagnostics")) -- show diagnostics for line

		keymap("n", "[d", diagnostic_goto(true), opt("Go to previous diagnostic")) -- jump to previous diagnostic in buffer

		keymap("n", "]d", diagnostic_goto(false), opt("Go to next diagnostic")) -- jump to next diagnostic in buffer

		keymap("n", "[e", diagnostic_goto(true, "ERROR"), opt("Go to previous error")) -- jump to previous diagnostic in buffer

		keymap("n", "]e", diagnostic_goto(false, "ERROR"), opt("Go to next error")) -- jump to next diagnostic in buffer

		keymap("n", "[w", diagnostic_goto(true, "WARN"), opt("Go to previous warn")) -- jump to previous diagnostic in buffer

		keymap("n", "]w", diagnostic_goto(false, "WARN"), opt("Go to next warn")) -- jump to next diagnostic in buffer

		keymap("n", "[i", diagnostic_goto(true, "INFO"), opt("Go to previous info")) -- jump to previous diagnostic in buffer

		keymap("n", "]i", diagnostic_goto(false, "INFO"), opt("Go to next info")) -- jump to next diagnostic in buffer

		keymap("n", "K", vim.lsp.buf.hover, opt("Show documentation for what is under cursor")) -- show documentation for what is under cursor

		keymap("n", "gK", vim.lsp.buf.signature_help, opt("Signature Help"))

		keymap("n", "<Leader>cL", lsp.codelens.run, opt("Run CodeLens"))
	end,
})
-- }}}

-- Servers {{{
vim.lsp.enable({
	"gopls",
	"lua_ls",
	"html",
	"cssls",
	"bashls",
	"sqlls",
	"emmet_ls",
	"ts_ls",
	"angularls",
	"zls",
	"yamlls",
	-- "denols",
	"jsonls",
	"dockerls",
	"marksman",
})
-- }}}

-- Start, Stop, Restart, Log commands {{{
vim.api.nvim_create_user_command("LspStart", function()
	vim.cmd.e()
end, { desc = "Starts LSP clients in the current buffer" })

vim.api.nvim_create_user_command("LspStop", function(opts)
	for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
		if opts.args == "" or opts.args == client.name then
			client:stop(true)
			vim.notify(client.name .. ": stopped")
		end
	end
end, {
	desc = "Stop all LSP clients or a specific client attached to the current buffer.",
	nargs = "?",
	complete = function(_, _, _)
		local clients = vim.lsp.get_clients({ bufnr = 0 })
		local client_names = {}
		for _, client in ipairs(clients) do
			table.insert(client_names, client.name)
		end
		return client_names
	end,
})

vim.api.nvim_create_user_command("LspRestart", function()
	local detach_clients = {}
	for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
		client:stop(true)
		if vim.tbl_count(client.attached_buffers) > 0 then
			detach_clients[client.name] = { client, vim.lsp.get_buffers_by_client_id(client.id) }
		end
	end
	local timer = vim.uv.new_timer()
	if not timer then
		return vim.notify("Servers are stopped but havent been restarted")
	end
	timer:start(
		100,
		50,
		vim.schedule_wrap(function()
			for name, client in pairs(detach_clients) do
				local client_id = vim.lsp.start(client[1].config, { attach = false })
				if client_id then
					for _, buf in ipairs(client[2]) do
						vim.lsp.buf_attach_client(buf, client_id)
					end
					vim.notify(name .. ": restarted")
				end
				detach_clients[name] = nil
			end
			if next(detach_clients) == nil and not timer:is_closing() then
				timer:close()
			end
		end)
	)
end, {
	desc = "Restart all the language client(s) attached to the current buffer",
})

vim.api.nvim_create_user_command("LspLog", function()
	vim.cmd.vsplit(vim.lsp.log.get_filename())
end, {
	desc = "Get all the lsp logs",
})

vim.api.nvim_create_user_command("LspInfo", function()
	vim.cmd("silent checkhealth vim.lsp")
end, {
	desc = "Get all the information about all LSP attached",
})
-- }}}
