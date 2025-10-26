-- ============================================================================
-- UFO - Ultra Fast Folding
-- ============================================================================
-- Modern code folding with LSP and Treesitter support
-- Shows preview when hovering over folded code
-- ============================================================================

return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async", -- Required dependency
	},
	event = "BufReadPost",
	config = function()
		-- ========================================
		-- Folding Options
		-- ========================================
		vim.o.foldcolumn = "1" -- Show fold column (0-9, '0' to disable)
		vim.o.foldlevel = 99 -- Open all folds by default (high number = more open)
		vim.o.foldlevelstart = 99 -- Start with all folds open
		vim.o.foldenable = true -- Enable folding

		-- ========================================
		-- UFO Setup
		-- ========================================
		require("ufo").setup({
			-- ========================================
			-- Provider Priority
			-- ========================================
			-- Try LSP first, then Treesitter, then indent
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,

			-- ========================================
			-- Fold Preview
			-- ========================================
			-- Show preview when hovering over folded code
			preview = {
				win_config = {
					border = "rounded", -- Border style
					winhighlight = "Normal:Normal", -- Highlight
					winblend = 0, -- Transparency (0-100)
				},
				mappings = {
					scrollU = "<C-u>", -- Scroll up in preview
					scrollD = "<C-d>", -- Scroll down in preview
					jumpTop = "[", -- Jump to top
					jumpBot = "]", -- Jump to bottom
				},
			},

			-- ========================================
			-- Fold Virtual Text
			-- ========================================
			-- Text shown at the end of folded lines
			fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = (" 󰁂 %d lines"):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0

				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end

				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end,
		})

		-- ========================================
		-- Keymaps
		-- ========================================
		local map = vim.keymap.set

		-- zR: Open all folds
		map("n", "zR", require("ufo").openAllFolds, { desc = "Open All Folds" })

		-- zM: Close all folds
		map("n", "zM", require("ufo").closeAllFolds, { desc = "Close All Folds" })

		-- zr: Open folds one level
		map("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "Open Folds One Level" })

		-- zm: Close folds one level
		map("n", "zm", require("ufo").closeFoldsWith, { desc = "Close Folds One Level" })

		-- K: Hover or preview fold
		map("n", "K", function()
			local winid = require("ufo").peekFoldedLinesUnderCursor()
			if not winid then
				vim.lsp.buf.hover() -- Fall back to LSP hover
			end
		end, { desc = "Peek Fold or Hover" })
	end,
}
