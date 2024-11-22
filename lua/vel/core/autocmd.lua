local utils = require("vel.core.utils")

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = utils.augroup("checktime"),
	command = "checktime",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = utils.augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = utils.augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = utils.augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = utils.augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
		"fugitive",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = utils.augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = utils.augroup("json_conceal"),
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt.conceallevel = 0
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = utils.augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Enable spell checking and wrap for certain file types
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = utils.augroup("spell_check_file_pattern"),
	pattern = { "*.txt", "*.md", "*.tex", "*.typ", "gitcommit", "markdown", "text", "plaintex", "typst" },
	callback = function()
	  vim.opt.wrap = true
		vim.opt.spell = true
	end,
})

-- Set shiftwidth to 4 in these filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = utils.augroup("change_shift_width_file_pattern"),
	pattern = { "c", "cpp", "py", "java", "cs" },
	callback = function()
		vim.bo.shiftwidth = 4
	end,
})

-- Auto save file on focus change
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave", "BufWinLeave" }, {
	group = utils.augroup("auto_save_file_on_focus_change"),
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		local buf_modified = vim.bo[buf].modified
		if vim.bo.filetype ~= "" and vim.bo.buftype == "" and buf_modified == true then
			vim.cmd("silent! w")
		end
	end,
})

-- Fix commnet on new line
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	group = utils.augroup("fix_comment_on_new_line"),
	pattern = { "*" },
	callback = function()
		vim.cmd([[set formatoptions-=cro]])
	end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = utils.augroup("json_conceal"),
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- Add timestamp as extension for backup files
vim.api.nvim_create_autocmd("BufWritePre", {
	group = utils.augroup("timestamp_backupext"),
	desc = "Add timestamp to backup extension",
	pattern = "*",
	callback = function()
		vim.opt.backupext = "-" .. vim.fn.strftime("%Y%m%d%H%M")
	end,
})

--- Remove all trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = utils.augroup("TrimWhiteSpaceGrp"),
	command = [[:%s/\s\+$//e]],
})

-- Function to get the full path and replace the home directory with ~
local function get_winbar_path()
  -- local full_path = vim.fn.expand("%:p")
  -- return full_path:gsub(vim.fn.expand("$HOME"), "~")
  return "%f"
end
-- Function to get the number of open buffers using the :ls command
local function get_buffer_count()
  local buffers = vim.fn.execute("ls")
  local count = 0
  -- Match only lines that represent buffers, typically starting with a number followed by a space
  for line in string.gmatch(buffers, "[^\r\n]+") do
    if string.match(line, "^%s*%d+") then
      count = count + 1
    end
  end
  return count
end
-- Function to update the winbar
local function update_winbar()
  local home_replaced = get_winbar_path()
  local buffer_count = get_buffer_count()
  vim.opt.winbar = "%#WinBar1#%m "
    .. "%#WinBar2#("
    .. buffer_count
    .. ") "
    .. "%#WinBar1#"
    .. home_replaced
    .. "%*%=%#WinBar2#"
  -- I don't need the hostname as I have it in lualine
  -- .. vim.fn.systemlist("hostname")[1]
end
-- Autocmd to update the winbar on BufEnter and WinEnter events
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  callback = update_winbar,
})
