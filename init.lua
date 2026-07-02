-- this is init file for lua configuration in this is the initial config first loaded 
require("config.options")
require("config.keymaps")
require("config.autocmd")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

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

-- Apply the active colorscheme from one central place.
require("current-theme")
