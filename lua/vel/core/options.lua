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

-- Enable break indent
opt.breakindent = true

-- screen
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.scrolloff = 10 -- Lines of context
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
opt.copyindent = true -- Copy the previous indentation on autoindenting.

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
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true -- Ignore case
opt.smartcase = true -- Don't ignore case with capitals

-- spell check
opt.spelllang = { "en_us" }
opt.spell = false

-- screen split
opt.splitkeep = "screen"
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.inccommand = "nosplit" -- preview incremental substitute

-- auto completion
opt.completeopt = "menu,menuone,noselect"

-- allow backspace on indent, end of line or insert mode start position
opt.backspace = { "start", "eol", "indent" }

-- list
opt.list = true -- Show some invisible characters (tabs...
opt.listchars = { tab = "  ", eol = "↴", trail = "·" }

-- Markup setup
opt.conceallevel = 0
