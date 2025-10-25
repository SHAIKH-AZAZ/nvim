-- ============================================================================
-- Tiny Inline Diagnostic - Beautiful Inline Diagnostics
-- ============================================================================
-- Shows LSP diagnostics inline at the end of lines
-- More polished than native virtual text
-- ============================================================================

return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "LspAttach", -- Load when LSP attaches
	priority = 1000, -- Load before other plugins
	config = function()
		require("tiny-inline-diagnostic").setup({
			-- ========================================
			-- Display Options
			-- ========================================
			signs = {
				left = "", -- Icon on left
				right = "", -- Icon on right
				diag = "●", -- Diagnostic icon
				arrow = "    ", -- Arrow pointing to diagnostic
				up_arrow = "    ", -- Up arrow
				vertical = " │", -- Vertical line
				vertical_end = " └", -- End of vertical line
			},

			-- ========================================
			-- Highlight Groups
			-- ========================================
			hi = {
				error = "DiagnosticError", -- Error color
				warn = "DiagnosticWarn", -- Warning color
				info = "DiagnosticInfo", -- Info color
				hint = "DiagnosticHint", -- Hint color
				arrow = "NonText", -- Arrow color
				background = "CursorLine", -- Background color (optional)
				mixing_color = "None", -- Color mixing (None = no mixing)
			},

			-- ========================================
			-- Blend Settings
			-- ========================================
			blend = {
				factor = 0.27, -- Blend factor (0-1, lower = more transparent)
			},

			-- ========================================
			-- Behavior
			-- ========================================
			options = {
				-- Show diagnostics only on cursor line
				show_source = false, -- Don't show source (e.g., "eslint")
				
				-- Throttle updates (ms)
				throttle = 20,

				-- Multiple diagnostics on same line
				multiple_diag_under_cursor = false, -- Show only first diagnostic

				-- Multiline diagnostics
				multilines = false, -- Don't show multiline diagnostics inline

				-- Show all diagnostics on line
				show_all_diags_on_cursorline = false, -- Only show first

				-- Enable/disable per severity
				enable_on_insert = false, -- Don't show in insert mode
			},

			-- ========================================
			-- Overflow Handling
			-- ========================================
			overflow = {
				mode = "wrap", -- "wrap" or "none"
			},

			-- ========================================
			-- Format Function
			-- ========================================
			format = function(diagnostic)
				-- Customize diagnostic message format
				return diagnostic.message
			end,
		})

		-- ========================================
		-- Disable Native Virtual Text
		-- ========================================
		-- Since we're using tiny-inline-diagnostic
		vim.diagnostic.config({
			virtual_text = false, -- Disable native virtual text
		})
	end,
}
