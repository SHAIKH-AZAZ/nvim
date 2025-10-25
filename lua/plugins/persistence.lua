-- ============================================================================
-- Persistence - Session Management
-- ============================================================================
-- Automatically saves and restores your Neovim session
-- Remembers open files, window layout, and more
-- ============================================================================

return {
	"folke/persistence.nvim",
	event = "BufReadPre", -- Load before reading files
	opts = {
		dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- Session directory
		options = { "buffers", "curdir", "tabpages", "winsize" }, -- What to save
	},
	keys = {
		-- <leader>qs: Restore session for current directory
		{
			"<leader>qs",
			function()
				require("persistence").load()
			end,
			desc = "Restore Session",
		},
		-- <leader>ql: Restore last session
		{
			"<leader>ql",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "Restore Last Session",
		},
		-- <leader>qd: Don't save current session
		{
			"<leader>qd",
			function()
				require("persistence").stop()
			end,
			desc = "Don't Save Current Session",
		},
	},
}
