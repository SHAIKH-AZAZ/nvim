-- ============================================================================
-- Telescope - Fuzzy Finder
-- ============================================================================
-- Fast, extensible fuzzy finder for files, text, and more
-- Think of it as Ctrl+P on steroids
-- ============================================================================

return {
	"nvim-telescope/telescope.nvim",
	branch = "master", -- Using master to fix deprecated warnings
	-- Alternative: '0.1.x' for stable version
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required utility library
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- Faster fuzzy matching (C implementation)
		"nvim-tree/nvim-web-devicons", -- File icons
		"andrew-george/telescope-themes", -- Theme switcher extension
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		-- Load extensions
		telescope.load_extension("fzf") -- Enable fast fuzzy matching
		telescope.load_extension("themes") -- Enable theme switcher

		telescope.setup({
			defaults = {
				-- Smart path display (truncates long paths intelligently)
				path_display = { "smart" },
				mappings = {
					-- Insert mode mappings (when typing in search)
					i = {
						["<C-k>"] = actions.move_selection_previous, -- Ctrl+k: Move up
						["<C-j>"] = actions.move_selection_next, -- Ctrl+j: Move down
					},
				},
			},
			extensions = {
				-- Theme switcher configuration
				themes = {
					enable_previewer = true, -- Show theme preview
					enable_live_preview = true, -- Live preview as you navigate
					persist = {
						enabled = true, -- Save selected theme
						path = vim.fn.stdpath("config") .. "/lua/colorscheme.lua", -- Save location
					},
				},
			},
		})

		-- ========================================
		-- Keymaps
		-- ========================================

		-- <leader>pr: Find recently opened files
		vim.keymap.set("n", "<leader>pr", "<cmd>Telescope oldfiles<CR>", { desc = "Fuzzy find recent files" })

		-- <leader>ff: Find files in current directory
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })

		-- <leader>fg: Live grep (search text in all files)
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })

		-- <leader>fb: List open buffers
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })

		-- <leader>fh: Search Neovim help documentation
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

		-- <leader>lg: Find word under cursor in all files
		vim.keymap.set("n", "<leader>lg", function()
			local word = vim.fn.expand("<cWORD>") -- Get word under cursor
			builtin.grep_string({ search = word })
		end, { desc = "Find Connected Words under cursor" })

		-- <leader>ths: Open theme switcher
		vim.keymap.set(
			"n",
			"<leader>ths",
			"<cmd>Telescope themes<CR>",
			{ noremap = true, silent = true, desc = "Theme Switcher" }
		)
	end,
}
