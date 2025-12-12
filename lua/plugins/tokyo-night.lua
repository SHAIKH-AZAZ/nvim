-- ============================================================================
-- TokyoNight - Color Scheme
-- ============================================================================
-- Clean, vibrant, and slightly futuristic. Comes in 4 styles.
-- ============================================================================

return {
	"folke/tokyonight.nvim",
	name = "tokyonight",
	priority = 1000, -- Load early, above UI plugins
	config = function()
		require("tokyonight").setup({
			style = "night", -- night, storm, moon, day
			transparent = false, -- Match your Catppuccin style
			terminal_colors = true,

			-- Dim inactive windows (similar to Catppuccin option)
			dim_inactive = true,

			-- Optional custom highlights (like your Catppuccin overrides)
			on_highlights = function(hl, c)
				hl.LineNr = { fg = c.orange }
				hl.Comment = { fg = c.teal, italic = true }
			end,
		})

		vim.cmd.colorscheme("tokyonight")
	end,
}
