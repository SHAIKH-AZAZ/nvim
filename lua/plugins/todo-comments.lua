-- ============================================================================
-- Todo Comments - Highlight and Navigate TODOs
-- ============================================================================
-- Highlights TODO, FIXME, NOTE, etc. in comments
-- Shows icons in sign column (gutter) for non-git files
-- ============================================================================

return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("todo-comments").setup({
			-- ========================================
			-- Sign Column (Gutter) Icons
			-- ========================================
			signs = true, -- Show icons in sign column
			sign_priority = 8, -- Priority (higher = more important)

			-- ========================================
			-- Keywords and Colors
			-- ========================================
			keywords = {
				FIX = {
					icon = " ", -- Icon in gutter
					color = "error", -- Red color
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- Aliases
				},
				TODO = {
					icon = " ",
					color = "info", -- Blue color
				},
				HACK = {
					icon = " ",
					color = "warning", -- Yellow color
				},
				WARN = {
					icon = " ",
					color = "warning",
					alt = { "WARNING", "XXX" },
				},
				PERF = {
					icon = " ",
					color = "default",
					alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
				},
				NOTE = {
					icon = " ",
					color = "hint", -- Cyan color
					alt = { "INFO" },
				},
				TEST = {
					icon = "⏲ ",
					color = "test",
					alt = { "TESTING", "PASSED", "FAILED" },
				},
			},

			-- ========================================
			-- Highlighting
			-- ========================================
			highlight = {
				multiline = true, -- Highlight multi-line comments
				before = "", -- Highlight before keyword
				keyword = "wide", -- Highlight keyword: "wide", "fg", "bg"
				after = "fg", -- Highlight after keyword
				pattern = [[.*<(KEYWORDS)\s*:]], -- Pattern to match
				comments_only = true, -- Only in comments
			},

			-- ========================================
			-- Search
			-- ========================================
			search = {
				command = "rg", -- Use ripgrep
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				pattern = [[\b(KEYWORDS):]], -- Search pattern
			},
		})
	end,

	-- ========================================
	-- Keymaps
	-- ========================================
	keys = {
		-- ]t: Jump to next TODO comment
		{
			"]t",
			function()
				require("todo-comments").jump_next()
			end,
			desc = "Next todo comment",
		},

		-- [t: Jump to previous TODO comment
		{
			"[t",
			function()
				require("todo-comments").jump_prev()
			end,
			desc = "Previous todo comment",
		},

		-- <leader>ft: Find all TODOs with Telescope
		{
			"<leader>ft",
			"<cmd>TodoTelescope<cr>",
			desc = "Find todos",
		},

		-- <leader>fT: Find TODOs in current file
		{
			"<leader>fT",
			"<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",
			desc = "Find todos/fix/fixme",
		},
	},
}
