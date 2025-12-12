-- ============================================================================
-- Bufferline - Buffer/Tab Bar
-- ============================================================================
-- Shows open buffers as tabs at the top of the editor
-- Provides visual buffer management with mouse support
-- ============================================================================

return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "VeryLazy", -- Load after startup
	dependencies = "nvim-tree/nvim-web-devicons", -- File icons
	opts = {
		options = {
			-- ========================================
			-- Display Mode
			-- ========================================
			mode = "buffers", -- Show buffers (use "tabs" for tabpages)
			themable = true, -- Allow colorscheme to style bufferline

			-- ========================================
			-- Numbering
			-- ========================================
			numbers = "none", -- Options: "none" | "ordinal" | "buffer_id" | "both"

			-- ========================================
			-- Mouse Actions
			-- ========================================
			close_command = "bdelete! %d", -- Left click on close icon
			right_mouse_command = "bdelete! %d", -- Right click to close
			left_mouse_command = "buffer %d", -- Left click to switch
			middle_mouse_command = nil, -- Middle click (disabled)

			-- ========================================
			-- Visual Indicators
			-- ========================================
			indicator = {
				icon = "▎", -- Active buffer indicator
				style = "icon", -- Options: 'icon' | 'underline' | 'none'
			},
			buffer_close_icon = "󰅖", -- Close button icon
			modified_icon = "●", -- Unsaved changes indicator
			close_icon = "", -- Tab close icon
			left_trunc_marker = "", -- When tabs overflow left
			right_trunc_marker = "", -- When tabs overflow right

			-- ========================================
			-- Sizing
			-- ========================================
			max_name_length = 18, -- Truncate long file names
			max_prefix_length = 15, -- Truncate long paths
			truncate_names = true, -- Enable name truncation
			tab_size = 18, -- Width of each tab

			-- ========================================
			-- Diagnostics Integration
			-- ========================================
			diagnostics = "nvim_lsp", -- Show LSP errors/warnings
			diagnostics_update_in_insert = false, -- Don't update in insert mode
			-- Custom diagnostic indicator
			diagnostics_indicator = function(count, level)
				local icon = level:match("error") and " " or " "
				return " " .. icon .. count
			end,

			-- ========================================
			-- Offsets (for sidebars)
			-- ========================================
			-- Reserve space when neo-tree is open
			offsets = {
				{
					filetype = "neo-tree",
					text = "File Explorer",
					text_align = "center", -- Options: "left" | "center" | "right"
					separator = true,
				},
			},

			-- ========================================
			-- Visual Options
			-- ========================================
			color_icons = true, -- Colored file type icons
			show_buffer_icons = true, -- Show file type icons
			show_buffer_close_icons = true, -- Show close buttons
			show_close_icon = true, -- Show global close icon
			show_tab_indicators = true, -- Show tab indicators
			show_duplicate_prefix = true, -- Show path for duplicate names
			persist_buffer_sort = true, -- Remember custom sort order
			separator_style = "thick", -- Options: "slant" | "slope" | "thick" | "thin"
			enforce_regular_tabs = false, -- Don't force equal tab widths
			always_show_bufferline = true, -- Show even with one buffer

			-- ========================================
			-- Hover Behavior
			-- ========================================
			hover = {
				enabled = true, -- Enable hover effects
				delay = 200, -- Hover delay in ms
				reveal = { "close" }, -- Show close button on hover
			},

			-- ========================================
			-- Sorting
			-- ========================================
			sort_by = "insert_after_current", -- How to order new buffers
			-- Options: 'insert_after_current' | 'insert_at_end' | 'id' | 'extension' | 'directory' | 'tabs'
		},
	},

	-- ========================================
	-- Keymaps
	-- ========================================
	keys = {
		-- Buffer management
		{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
		{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
		{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
		{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
		{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },

		-- Navigation
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" }, -- Shift+h
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" }, -- Shift+l
		{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },

		-- Reordering
		{ "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
		{ "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
	},
}
