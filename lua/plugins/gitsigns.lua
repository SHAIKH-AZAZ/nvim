-- ============================================================================
-- Gitsigns - Git Integration
-- ============================================================================
-- Shows git changes in the sign column (gutter)
-- Provides git hunk navigation, staging, and blame
-- ============================================================================

return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" }, -- Load when opening files
	-- Only enable if inside a git repository
	cond = function()
		local gitdir = vim.fn.finddir(".git", ".;")
		return gitdir ~= ""
	end,
	config = function()
		require("gitsigns").setup({
			-- ========================================
			-- Sign Column Icons
			-- ========================================
			signs = {
				add = { text = "▎" }, -- New lines
				change = { text = "▎" }, -- Modified lines
				delete = { text = "" }, -- Deleted lines
				topdelete = { text = "" }, -- Deleted at top
				changedelete = { text = "▎" }, -- Changed and deleted
				untracked = { text = "▎" }, -- Untracked files
			},
			-- Icons for staged changes
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},

			-- ========================================
			-- Keymaps (per buffer)
			-- ========================================
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				-- Helper function to create keymaps
				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
				end

				-- ========================================
				-- Navigation
				-- ========================================

				-- ]h: Next hunk (git change)
				map("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, "Next Hunk")

				-- [h: Previous hunk
				map("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, "Prev Hunk")

				-- ]H: Jump to last hunk
				map("n", "]H", function()
					gs.nav_hunk("last")
				end, "Last Hunk")

				-- [H: Jump to first hunk
				map("n", "[H", function()
					gs.nav_hunk("first")
				end, "First Hunk")

				-- ========================================
				-- Actions
				-- ========================================

				-- <leader>ghs: Stage hunk (add to git)
				map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")

				-- <leader>ghr: Reset hunk (discard changes)
				map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")

				-- <leader>ghS: Stage entire buffer
				map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")

				-- <leader>ghu: Undo stage hunk
				map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")

				-- <leader>ghR: Reset entire buffer
				map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")

				-- <leader>ghp: Preview hunk inline
				map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")

				-- <leader>ghb: Show git blame for current line
				map("n", "<leader>ghb", function()
					gs.blame_line({ full = true })
				end, "Blame Line")

				-- <leader>ghB: Show git blame for entire buffer
				map("n", "<leader>ghB", gs.blame, "Blame Buffer")

				-- <leader>ghd: Show diff for current file
				map("n", "<leader>ghd", gs.diffthis, "Diff This")

				-- <leader>ghD: Show diff against HEAD~
				map("n", "<leader>ghD", function()
					gs.diffthis("~")
				end, "Diff This ~")

				-- ih: Text object for hunk (use with operators like dih, yih)
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		})
	end,
}
