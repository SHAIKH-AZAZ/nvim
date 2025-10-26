-- ============================================================================
-- Keymaps - Custom Keyboard Shortcuts
-- ============================================================================
-- Additional keybindings for better workflow
-- ============================================================================

local map = vim.keymap.set

-- ========================================
-- Buffer Management
-- ========================================

-- <leader>bd: Close current buffer (buffer delete)
map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Close Buffer" })

-- <leader>bD: Force close buffer (discard changes)
map("n", "<leader>bD", "<cmd>bd!<cr>", { desc = "Force Close Buffer" })

-- <leader>bw: Wipe buffer (more aggressive delete)
map("n", "<leader>bw", "<cmd>bw<cr>", { desc = "Wipe Buffer" })

-- Ctrl+q: Quick close buffer
map("n", "<C-q>", "<cmd>bd<cr>", { desc = "Close Buffer" })

-- ========================================
-- Window Management
-- ========================================

-- <leader>wc: Close current window
map("n", "<leader>wc", "<cmd>close<cr>", { desc = "Close Window" })

-- <leader>wo: Close all other windows
map("n", "<leader>wo", "<cmd>only<cr>", { desc = "Close Other Windows" })

-- <leader>ws: Split window horizontally
map("n", "<leader>ws", "<cmd>split<cr>", { desc = "Split Horizontal" })

-- <leader>wv: Split window vertically
map("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Split Vertical" })

-- ========================================
-- Quick Save and Quit
-- ========================================

-- <leader>w: Save file
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save File" })

-- <leader>q: Quit window
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit Window" })

-- <leader>Q: Quit all
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit All" })

-- Ctrl+s: Save file (works in normal and insert mode)
map({ "n", "i" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- ========================================
-- Better Navigation
-- ========================================

-- Ctrl+h/j/k/l: Navigate between windows
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

-- ========================================
-- Better Indenting
-- ========================================

-- Stay in visual mode when indenting
map("v", "<", "<gv", { desc = "Indent Left" })
map("v", ">", ">gv", { desc = "Indent Right" })

-- ========================================
-- Move Lines
-- ========================================

-- Alt+j/k: Move lines up/down
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Line Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Line Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Lines Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Lines Up" })

-- ========================================
-- Clear Search Highlight
-- ========================================

-- <Esc>: Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear Search Highlight" })

-- ========================================
-- Better Paste
-- ========================================

-- p: Paste without yanking in visual mode
map("v", "p", '"_dP', { desc = "Paste Without Yank" })

-- ========================================
-- Quick Fix List
-- ========================================

-- ]q: Next quickfix item
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next Quickfix" })

-- [q: Previous quickfix item
map("n", "[q", "<cmd>cprev<cr>", { desc = "Previous Quickfix" })

-- ========================================
-- Diagnostics
-- ========================================

-- ]d: Next diagnostic
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })

-- [d: Previous diagnostic
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })

-- <leader>e: Show diagnostic in floating window
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show Diagnostic" })
