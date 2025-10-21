-- Leader keys must be set before lazy.nvim loads
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- ============================================================================
-- General Settings
-- ============================================================================

-- Enable true color support
vim.opt.termguicolors = true

-- Enable mouse support in all modes
vim.opt.mouse = "a"

-- Hide mode indicator (already shown in statusline)
vim.opt.showmode = false

-- Enable persistent undo
vim.opt.undofile = true

-- Disable swap files
vim.opt.swapfile = false

-- Enable backup files
vim.opt.backup = false
vim.opt.writebackup = false

-- ============================================================================
-- UI Settings
-- ============================================================================

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight current line
vim.opt.cursorline = true

-- Always show sign column to prevent text shifting
vim.opt.signcolumn = "yes"

-- Show invisible characters
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Scroll offset - keep cursor away from edges
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Command line height
vim.opt.cmdheight = 1

-- Better completion experience
vim.opt.completeopt = "menu,menuone,noselect"

-- Popup menu height
vim.opt.pumheight = 10

-- ============================================================================
-- Indentation & Formatting
-- ============================================================================

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- Tab width
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Smart indenting
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Line wrapping
vim.opt.wrap = false

-- Break lines at word boundaries
vim.opt.linebreak = true
vim.opt.breakindent = true

-- ============================================================================
-- Search Settings
-- ============================================================================

-- Case-insensitive search unless uppercase is used
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Highlight search results
vim.opt.hlsearch = true

-- Incremental search
vim.opt.incsearch = true

-- ============================================================================
-- Split Windows
-- ============================================================================

-- Open new splits to the right and below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Equalize splits on resize
vim.opt.equalalways = true

-- ============================================================================
-- Timing & Performance
-- ============================================================================

-- Faster completion
vim.opt.updatetime = 250

-- Timeout for key sequences
vim.opt.timeoutlen = 300

-- ============================================================================
-- File Handling
-- ============================================================================

-- Disable autochdir (can cause issues with plugins)
vim.opt.autochdir = false

-- File encoding
vim.opt.fileencoding = "utf-8"

-- Confirm before closing unsaved files
vim.opt.confirm = true

-- ============================================================================
-- Clipboard
-- ============================================================================

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- ============================================================================
-- Folding
-- ============================================================================

-- Enable folding
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = "0"

-- Use treesitter for folding (if available)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- ============================================================================
-- Miscellaneous
-- ============================================================================

-- Better diff algorithm
vim.opt.diffopt:append("linematch:60")

-- Enable spell checking for certain file types (set in autocmds)
vim.opt.spell = false
vim.opt.spelllang = "en_us"

-- Shorter messages
vim.opt.shortmess:append("c")

-- Don't show intro message
vim.opt.shortmess:append("I")

-- Better whitespace handling
vim.opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

-- Disable some built-in plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
