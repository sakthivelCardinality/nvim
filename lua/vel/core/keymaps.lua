vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local keymap = vim.keymap -- for conciseness

-- Escape insert mode
keymap.set("i", "jj", "<Esc>", { desc = "Escape insert mode", remap = true, silent = true })
-- keymap.set("i", "jk", "<Esc>", { desc = "Escape insert mode" })

-- Remap for dealing with word wrap
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- insert mode move between beginningand end of line
keymap.set("i", "<C-b>", "<ESC>^i", { desc = "Beginning of line" })
keymap.set("i", "<C-e>", "<End>", { desc = "End of line" })

-- Inprove pasting
keymap.set("x", "<leader>p", [["_dP]], { desc = "Preserve previous word when pasting" })
-- keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy the content to system clipboard" })
-- keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy the content to system clipboard" })

-- scroll at the center of screen
keymap.set("n", "J", "mzJ`z", { desc = "Set the cursor on same position" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move down half page center page" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move up half page center page" })
-- keymap.set("n", "n", "nzzzv", { desc = "Search word with half page" })
-- keymap.set("n", "N", "Nzzzv", { desc = "Search word with half page" })
keymap.set("n", "*", "*zz", { desc = "Search word under cursor with half page" })

-- Move to window using the <ctrl> hjkl keys
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Clear search with <esc>
keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
keymap.set(
	"n",
	"<leader>ur",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	{ desc = "Redraw / clear hlsearch / diff update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap.set("n", "n", "'Nn'[v:searchforward].'zzzv'", { expr = true, desc = "Next search result with half page" })
keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap.set("n", "N", "'nN'[v:searchforward].'zzzv'", { expr = true, desc = "Prev search result with half page" })
keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- save file
keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- lazy
keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- quit
keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- windows
keymap.set("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
keymap.set("n", "<leader>wh", "<C-W>s", { desc = "Split window below", remap = true })
keymap.set("n", "<leader>wv", "<C-W>v", { desc = "Split window right", remap = true })
keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- tabs
keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- buffers
keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
keymap.set("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Add undo break-points
keymap.set("i", ",", ",<c-g>u")
keymap.set("i", ".", ".<c-g>u")
keymap.set("i", ";", ";<c-g>u")

keymap.set("n", "<C-c>", "<cmd> %y+ <CR>", { desc = "Copy whole file" })

keymap.set("n", "<leader>rp", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", {
	desc = "inline find replace",
})

-- Insert mode move cursor
keymap.set("i", "<C-h>", "<Left>", { desc = "Move Cursor Left Insert Mode" })
keymap.set("i", "<C-l>", "<Right>", { desc = "Move Cursor Right Insert Mode" })
keymap.set("i", "<C-j>", "<Down>", { desc = "Move Cursor Down Insert Mode" })
keymap.set("i", "<C-k>", "<Up>", { desc = "Move Cursor Up Insert Mode" })

-- Quicker macro playback
keymap.set("n", "Q", "@qj", { desc = "Macro for single line" })
keymap.set("x", "Q", ":norm @q<CR>", { desc = " Macro for selecting multiple lines" })

-- Open line, but stay in normal mode
keymap.set("n", "<Leader><CR>", "o<Esc>", { desc = "Add blank line below in normal mode" })
