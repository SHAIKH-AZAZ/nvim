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
				show_all_diags_on_cursorline = true, -- Show all (but we'll filter duplicates)

				-- Enable/disable per severity
				enable_on_insert = true, -- Don't show in insert mode
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
				-- Remove duplicate messages by checking if already shown
				return diagnostic.message
			end,

			-- ========================================
			-- Filter Duplicates
			-- ========================================
			-- Only show unique diagnostics (filter out duplicates)
			break_line = {
				enabled = false, -- Don't break lines
			},
		})

		-- ========================================
		-- Disable Native Virtual Text & Filter Duplicates
		-- ========================================
		-- Since we're using tiny-inline-diagnostic
		vim.diagnostic.config({
			virtual_text = false, -- Disable native virtual text
		})

		-- ========================================
		-- Filter Duplicate Diagnostics
		-- ========================================
		-- Override diagnostic handler to show only unique messages
		local original_handler = vim.diagnostic.handlers.virtual_text
		vim.diagnostic.handlers.virtual_text = {
			show = function(namespace, bufnr, diagnostics, opts)
				-- Filter out duplicate diagnostics
				local seen = {}
				local unique_diagnostics = {}
				for _, diag in ipairs(diagnostics) do
					local key = diag.lnum .. ":" .. diag.message
					if not seen[key] then
						seen[key] = true
						table.insert(unique_diagnostics, diag)
					end
				end
				if original_handler and original_handler.show then
					original_handler.show(namespace, bufnr, unique_diagnostics, opts)
				end
			end,
			hide = original_handler and original_handler.hide or function() end,
		}
	end,
}
