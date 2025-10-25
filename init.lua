-- ============================================================================
-- Neovim Init File
-- ============================================================================
-- Main entry point for Neovim configuration
-- This file bootstraps the plugin manager and loads all configurations
-- ============================================================================

-- ========================================
-- Bootstrap Lazy.nvim Plugin Manager
-- ========================================
-- Check if lazy.nvim is installed, if not, clone it from GitHub
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- Use latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath) -- Add lazy.nvim to runtime path

-- ========================================
-- Load Core Configuration
-- ========================================
-- Load basic vim settings (indentation, line numbers, mouse, etc.)
require("vim-options")

-- ========================================
-- Setup Lazy.nvim and Load Plugins
-- ========================================
-- This loads all plugin files from lua/plugins/ directory
require("lazy").setup("plugins", {
	checker = { enabled = true }, -- Automatically check for plugin updates
	performance = {
		rtp = {
			-- Disable unused built-in plugins for faster startup
			disabled_plugins = {
				"gzip", -- gzip file support
				"tarPlugin", -- tar file support
				"tohtml", -- convert to HTML
				"tutor", -- Neovim tutor
				"zipPlugin", -- zip file support
			},
		},
	},
})

-- ========================================
-- Load Additional Configuration
-- ========================================
-- Load custom autocommands (auto-save, format on save, etc.)
require("core.autocmd")
