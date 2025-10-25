
-- ============================================================================
-- Dropbar - Modern Breadcrumbs
-- ============================================================================
-- Shows code context (file path, function, class) at the top of the window
-- Modern replacement for breadcrumbs.nvim (no deprecated functions)
-- ============================================================================

return {
	"Bekaboo/dropbar.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-telescope/telescope-fzf-native.nvim", -- Optional: fuzzy finder
	},
	opts = {
		-- ========================================
		-- General Settings
		-- ========================================
		general = {
			enable = true, -- Enable dropbar
			attach_events = { "BufEnter", "BufWritePost" }, -- When to update
		},

		-- ========================================
		-- Icons
		-- ========================================
		icons = {
			enable = true, -- Show icons
			kinds = {
				-- Use nvim-web-devicons for file and folder icons
				file_icon = function(path)
					local devicons = require("nvim-web-devicons")
					local name = vim.fn.fnamemodify(path, ":t")
					local ext = vim.fn.fnamemodify(path, ":e")
					return devicons.get_icon(name, ext, { default = true })
				end,
				folder_icon = function()
					return "󰉋", "Directory" -- Folder icon
				end,
			},
		},

		-- ========================================
		-- Symbol Settings
		-- ========================================
		symbol = {
			preview = {
				reorient = function(_, range)
					local invisible = range["end"].line - vim.fn.line("w$") + 1
					if invisible > 0 then
						local view = vim.fn.winsaveview()
						view.topline = view.topline + invisible
						vim.fn.winrestview(view)
					end
				end,
			},
		},

		-- ========================================
		-- Bar Settings
		-- ========================================
		bar = {
			hover = true, -- Enable hover
			sources = function(buf, _)
				local sources = require("dropbar.sources")
				local utils = require("dropbar.utils")
				if vim.bo[buf].ft == "markdown" then
					return {
						sources.path,
						sources.markdown,
					}
				end
				if vim.bo[buf].buftype == "terminal" then
					return {
						sources.terminal,
					}
				end
				return {
					sources.path,
					utils.source.fallback({
						sources.lsp,
						sources.treesitter,
					}),
				}
			end,
		},

		-- ========================================
		-- Menu Settings
		-- ========================================
		menu = {
			preview = true, -- Show preview when hovering
			quick_navigation = true, -- Quick navigation with hjkl
			entry = {
				padding = {
					left = 1,
					right = 1,
				},
			},
			keymaps = {
				["<CR>"] = function()
					local menu = require("dropbar.api").get_current_dropbar_menu()
					if not menu then
						return
					end
					local cursor = vim.api.nvim_win_get_cursor(menu.win)
					local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
					if component then
						menu:click_on(component, nil, 1, "l")
					end
				end,
				["q"] = function()
					local menu = require("dropbar.api").get_current_dropbar_menu()
					if menu then
						menu:close()
					end
				end,
			},
		},
	},
	keys = {
		-- <leader>; : Pick from dropbar
		{
			"<leader>;",
			function()
				require("dropbar.api").pick()
			end,
			desc = "Dropbar Pick",
		},
	},
}
