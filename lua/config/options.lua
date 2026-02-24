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
-- Line Numbers (Force Enable)
-- ========================================
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers (easier for jumping with 5j, 10k, etc.)
vim.wo.number = true -- Window-local setting
vim.wo.relativenumber = true -- Window-local setting

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
vim.opt.winminheight = 0 -- Minimum window height (0 = allow very small windows)
vim.opt.winminwidth = 0 -- Minimum window width (0 = allow very small windows)
vim.opt.winheight = 1 -- Minimum height for current window
vim.opt.winwidth = 1 -- Minimum width for current window

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
-- Folding (Code Collapse)
-- ========================================
-- Note: These settings are overridden by UFO plugin if installed
-- UFO will handle folding automatically

-- ========================================
-- Diagnostics Configuration
-- ========================================
-- Virtual text is truncated to prevent wrapping across the screen
-- Use <leader>de or hover (K) to see full error messages
vim.diagnostic.config({
	virtual_text = {
		-- Only show errors and warnings inline (skip hints/info)
		severity = { min = vim.diagnostic.severity.WARN },
		-- Truncate long messages
		format = function(diagnostic)
			local max_width = 60
			local message = diagnostic.message
			if #message > max_width then
				message = message:sub(1, max_width) .. "…"
			end
			return message
		end,
		prefix = "●", -- Clean dot prefix
		spacing = 4, -- Spacing between code and diagnostic
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰌵 ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
	underline = true, -- Underline errors
	update_in_insert = false, -- Don't update while typing (less distracting)
	severity_sort = true, -- Sort by severity (errors first)
	float = {
		border = "rounded", -- Rounded border for floating windows
		source = true, -- Show which LSP/linter produced the error
		header = "", -- No header
		prefix = "", -- No prefix
		max_width = 80, -- Limit float width
	},
})

-- ========================================
-- Inlay Hints Configuration
-- ========================================
-- Enable inlay hints globally (shows parameter names, type hints, etc.)
vim.lsp.inlay_hint.enable(true)
