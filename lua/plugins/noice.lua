-- ============================================================================
-- Noice - Better UI for Messages, Cmdline, and Popups
-- ============================================================================
-- Replaces default UI with beautiful, modern alternatives
-- Shows messages, command line, and search in floating windows
-- ============================================================================

return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim", -- UI components
		"rcarriga/nvim-notify", -- Notification manager
	},
	opts = {
		-- ========================================
		-- LSP Progress
		-- ========================================
		lsp = {
			progress = {
				enabled = true, -- Show LSP loading progress
			},
			override = {
				-- Override LSP markdown rendering
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},

		-- ========================================
		-- Presets
		-- ========================================
		presets = {
			bottom_search = true, -- Use classic bottom search
			command_palette = true, -- Command palette style cmdline
			long_message_to_split = true, -- Long messages in split
			inc_rename = false, -- Incremental rename (disable if using inc-rename.nvim)
			lsp_doc_border = true, -- Border for LSP docs
		},

		-- ========================================
		-- Routes (Message Handling)
		-- ========================================
		routes = {
			-- Skip "written" messages
			{
				filter = {
					event = "msg_show",
					kind = "",
					find = "written",
				},
				opts = { skip = true },
			},
			-- Skip search count messages
			{
				filter = {
					event = "msg_show",
					kind = "",
					find = "%d+L, %d+B",
				},
				opts = { skip = true },
			},
		},
	},
	keys = {
		-- <leader>sn: Show notification history
		{
			"<leader>sn",
			function()
				require("noice").cmd("history")
			end,
			desc = "Noice History",
		},
		-- <leader>sl: Show last message
		{
			"<leader>sl",
			function()
				require("noice").cmd("last")
			end,
			desc = "Noice Last Message",
		},
		-- <leader>sd: Dismiss all notifications
		{
			"<leader>sd",
			function()
				require("noice").cmd("dismiss")
			end,
			desc = "Dismiss All",
		},
	},
}
