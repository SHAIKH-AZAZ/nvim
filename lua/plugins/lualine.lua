-- ============================================================================
-- Lualine - Statusline
-- ============================================================================
-- Beautiful, fast statusline at the bottom of your editor
-- Shows mode, git branch, diagnostics, file info, and more
-- ============================================================================

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- Icons for file types
	opts = {
		-- ========================================
		-- General Options
		-- ========================================
		options = {
			theme = "auto", -- automatically match your colorscheme (better than hardcoding)
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
      globalstatus = true, -- use a single statusline across all windows (Neovim 0.9+)
		},

		-- ========================================
		-- Active Window Sections
		-- ========================================
		-- Layout: |A|B|C ---------- X|Y|Z|
		sections = {
			-- Left side
			lualine_a = { "mode" }, -- INSERT, NORMAL, VISUAL, etc.
			lualine_b = {
				"branch", -- Git branch name
				"diff", -- Git changes (+3 ~2 -1)
				"diagnostics", -- LSP errors/warnings
			},
			lualine_c = { "filename" }, -- Current file name

			-- Right side
			lualine_x = {
				"encoding", -- File encoding (utf-8)
				"fileformat", -- Line endings (unix/dos)
				"filetype", -- File type (lua, javascript, etc.)
			},
			lualine_y = { "progress" }, -- File position (50%)
			lualine_z = { "location" }, -- Line:Column (10:5)
		},

		-- ========================================
		-- Inactive Window Sections
		-- ========================================
		-- Shown in non-focused windows
		inactive_sections = {
			lualine_c = { "filename" }, -- Just show filename
			lualine_x = { "location" }, -- Just show position
		},

		-- ========================================
		-- Extensions
		-- ========================================
		-- Special statuslines for specific plugins
		extensions = {
			"neo-tree", -- File explorer statusline
			"quickfix", -- Quickfix list statusline
		},
	},
	config = function(_, opts)
		require("lualine").setup(opts)
	end,
}
