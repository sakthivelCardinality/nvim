local opt = vim.opt

-- default to dark theme
opt.background = "dark"

-- line number
opt.number = true -- Print line number
opt.relativenumber = true -- Relative line numbers

-- mouse
opt.mouse = "a" -- Enable mouse mode

-- clipboard
opt.clipboard = "unnamedplus" -- Sync with system clipboard

-- cursor
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.cursorline = true -- Enable highlighting of the current line

-- terminal
opt.termguicolors = true -- True color support

-- screen
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.scrolloff = 8 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.expandtab = true -- Use spaces instead of tabs
opt.wrap = true -- Disable line wrap

-- popup
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup

-- statusline
opt.showmode = false -- Dont show mode since we have a statusline
opt.laststatus = 3 -- global statusline

-- tabstop, indent
opt.tabstop = 2 -- Number of spaces tabs count for
opt.smartindent = true -- Insert indents automatically

-- regards backup
opt.autowrite = true -- Enable auto write
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.timeoutlen = 300
opt.updatetime = 100 -- Save swap file and trigger CursorHold
opt.swapfile = false
opt.backup = true
opt.backupdir = os.getenv("HOME") .. "/.vim/backup/"
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir/"
opt.undolevels = 10000

-- search
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true -- Ignore case
opt.smartcase = true -- Don't ignore case with capitals
opt.spelllang = { "en" }

-- grep format
opt.grepformat = "%f:%l:%c:%m"
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepprg = "rg --vimgrep"

-- screen split
opt.splitkeep = "screen"
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.inccommand = "nosplit" -- preview incremental substitute

-- auto completion
opt.completeopt = "menu,menuone,noselect"

-- allow backspace on indent, end of line or insert mode start position
opt.backspace = "indent,eol,start"

-- list
opt.list = true -- Show some invisible characters (tabs...
opt.listchars:append("space:⋅")
opt.listchars:append("eol:↴")

-- window
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

-- visible in markdown files
opt.conceallevel = 0
