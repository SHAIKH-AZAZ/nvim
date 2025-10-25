-- ============================================================================
-- Basic Vim Options
-- ============================================================================
-- Core editor settings and behavior
-- ============================================================================

-- ========================================
-- Indentation Settings
-- ========================================
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.tabstop = 2 -- Tab width is 2 spaces
vim.opt.softtabstop = 2 -- Backspace deletes 2 spaces
vim.opt.shiftwidth = 2 -- Indent/outdent by 2 spaces

-- ========================================
-- Line Numbers
-- ========================================
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers (easier for jumping with 5j, 10k, etc.)

-- ========================================
-- Colors and UI
-- ========================================
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.cursorline = true -- Highlight the current line
vim.opt.showmode = false -- Don't show mode (INSERT, NORMAL) below statusline (lualine shows it)

-- ========================================
-- Leader Keys
-- ========================================
vim.g.mapleader = " " -- Space is the leader key (used for custom shortcuts like <leader>ca)
vim.g.maplocalleader = "/" -- Local leader for buffer-specific shortcuts

-- ========================================
-- Undo and History
-- ========================================
vim.opt.undofile = true -- Save undo history to file (persistent undo across sessions)

-- ========================================
-- Mouse Support
-- ========================================
vim.opt.mouse = "a" -- Enable mouse in all modes (click, scroll, select)

-- ========================================
-- Text Wrapping
-- ========================================
vim.opt.breakindent = true -- Wrapped lines continue with same indentation
vim.opt.linebreak = true -- Break lines at word boundaries (not in middle of words)

-- ========================================
-- Search Settings
-- ========================================
vim.opt.ignorecase = true -- Case-insensitive search by default
vim.opt.smartcase = true -- Case-sensitive if search contains uppercase letters

-- ========================================
-- Sign Column (for git signs, diagnostics)
-- ========================================
vim.opt.signcolumn = "yes" -- Always show sign column (prevents text shifting)
vim.wo.signcolumn = "yes" -- Window-local setting

-- ========================================
-- Window Splitting
-- ========================================
vim.opt.splitright = true -- New vertical splits open to the right
vim.opt.splitbelow = true -- New horizontal splits open below

-- ========================================
-- Clipboard Integration
-- ========================================
vim.opt.clipboard = "unnamedplus" -- Use system clipboard (y/p works with Ctrl+C/V)

-- ========================================
-- Search Settings (Enhanced)
-- ========================================
vim.opt.hlsearch = true -- Highlight all search matches
vim.opt.incsearch = true -- Show matches as you type

-- ========================================
-- Scroll Behavior
-- ========================================
vim.opt.scrolloff = 8 -- Keep 8 lines above/below cursor (keeps cursor centered)
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor

-- ========================================
-- Completion Menu
-- ========================================
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- Better completion experience
vim.opt.pumheight = 10 -- Max 10 items in completion popup

-- ========================================
-- Performance
-- ========================================
vim.opt.updatetime = 250 -- Faster completion and git signs (default 4000ms)
vim.opt.timeoutlen = 300 -- Faster which-key popup (default 1000ms)

-- ========================================
-- File Handling
-- ========================================
vim.opt.backup = false -- Don't create backup files
vim.opt.writebackup = false -- Don't backup before overwriting
vim.opt.swapfile = false -- Don't create swap files

-- ========================================
-- Conceal Level
-- ========================================
vim.opt.conceallevel = 0 -- Show all characters (don't hide quotes in JSON/Markdown)

-- ========================================
-- Diagnostics Configuration
-- ========================================
-- Note: Virtual text is disabled because we use tiny-inline-diagnostic plugin
vim.diagnostic.config({
	virtual_text = false, -- Disabled (using tiny-inline-diagnostic instead)
	signs = true, -- Show signs in gutter
	underline = true, -- Underline errors
	update_in_insert = false, -- Don't update while typing
	severity_sort = true, -- Sort by severity (errors first)
	float = {
		border = "rounded", -- Rounded border for floating windows
		source = "always", -- Always show source
		header = "", -- No header
		prefix = "", -- No prefix
	},
})
