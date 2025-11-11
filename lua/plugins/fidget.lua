-- ============================================================================
-- Fidget - LSP Progress Notifications
-- ============================================================================
-- Shows LSP loading progress in the corner (e.g., "Loading TypeScript...")
-- ============================================================================

return {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	opts = {
		-- Notification window configuration
		notification = {
			window = {
				winblend = 0, -- Transparency (0 = opaque, 100 = transparent)
				border = "none", -- Border style: "none", "single", "double", "rounded"
				zindex = 45, -- Stack order (higher = on top)
				max_width = 0, -- Max width (0 = no limit)
				max_height = 0, -- Max height (0 = no limit)
				x_padding = 1, -- Horizontal padding
				y_padding = 0, -- Vertical padding
				align = "bottom", -- Alignment: "top", "bottom", "avoid_cursor"
				relative = "editor", -- Position relative to: "editor", "win"
			},
			-- How notifications are displayed
			view = {
				stack_upwards = true, -- Stack notifications upwards
				icon_separator = " ", -- Separator between icon and message
				group_separator = "---", -- Separator between notification groups
				group_separator_hl = "Comment", -- Highlight group for separator
			},
		},

		-- LSP progress display
		progress = {
			poll_rate = 0, -- How often to poll for progress (0 = use update from LSP)
			suppress_on_insert = false, -- Hide progress in insert mode
			ignore_done_already = false, -- Ignore new tasks that are already done
			ignore_empty_message = false, -- Ignore tasks with no message
			
			-- Notification group configuration
			notification_group = function(msg)
				return msg.lsp_client.name -- Group by LSP server name
			end,

			-- Ignore specific LSP servers or messages
			ignore = {}, -- e.g., { "null-ls" } to ignore null-ls progress

			-- Progress display format
			display = {
				render_limit = 16, -- Max number of messages to render
				done_ttl = 3, -- How long to show completed messages (seconds)
				done_icon = "✔", -- Icon for completed tasks
				done_style = "Constant", -- Highlight group for done icon
				progress_ttl = math.huge, -- How long to show in-progress messages
				progress_icon = { pattern = "dots", period = 1 }, -- Loading animation
				progress_style = "WarningMsg", -- Highlight group for progress
				group_style = "Title", -- Highlight group for group name
				icon_style = "Question", -- Highlight group for icons
				priority = 30, -- Display priority
				skip_history = true, -- Don't add to notification history
				format_annote = function(msg)
					return msg.title
				end,
				format_group_name = function(group)
					return tostring(group)
				end,
				overrides = {
					rust_analyzer = { name = "rust-analyzer" },
				},
			},

			-- LSP client configuration
			lsp = {
				progress_ringbuf_size = 0, -- Size of LSP progress ring buffer (0 = no limit)
			},
		},

		-- Logger configuration (for debugging)
		logger = {
			level = vim.log.levels.WARN, -- Log level: DEBUG, INFO, WARN, ERROR
			float_precision = 0.01, -- Precision for float values
			path = string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache")),
		},
	},
}
