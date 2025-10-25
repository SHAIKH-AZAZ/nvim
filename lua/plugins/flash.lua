-- ============================================================================
-- Flash - Enhanced Navigation
-- ============================================================================
-- Jump to any location on screen with 2 keystrokes
-- Like EasyMotion but faster and more modern
-- ============================================================================

return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		-- Search settings
		search = {
			multi_window = true, -- Search across all windows
			forward = true, -- Search forward
			wrap = true, -- Wrap around file
		},
		-- Jump settings
		jump = {
			autojump = false, -- Don't auto-jump if only one match
		},
		-- Label settings
		label = {
			uppercase = false, -- Use lowercase labels
			rainbow = {
				enabled = true, -- Rainbow colors for labels
			},
		},
		-- Modes
		modes = {
			char = {
				enabled = true, -- Enable for f/F/t/T motions
				jump_labels = true, -- Show labels
			},
		},
	},
	keys = {
		-- s: Flash search
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		-- S: Flash treesitter (select by syntax)
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		-- r: Remote flash (for operator pending)
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		-- R: Treesitter search
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
		-- Ctrl+s: Toggle flash in search
		{
			"<c-s>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Toggle Flash Search",
		},
	},
}
