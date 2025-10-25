-- ============================================================================
-- Which-key - Keymap Helper
-- ============================================================================
-- Shows available keybindings in a popup as you type
-- Helps you discover and remember keyboard shortcuts
-- ============================================================================

return {
	"folke/which-key.nvim",
	event = "VeryLazy", -- Load after startup
	opts_extend = { "spec" },
	opts = {
		preset = "helix", -- Visual preset (helix, modern, classic)
		defaults = {},

		-- ========================================
		-- Keymap Groups
		-- ========================================
		-- Organize keymaps into logical groups
		spec = {
			{
				mode = { "n", "v" }, -- Normal and visual modes
				-- Group definitions (shown in which-key popup)
				{ "<leader><tab>", group = "tabs" }, -- Tab management
				{ "<leader>c", group = "code" }, -- Code actions
				{ "<leader>d", group = "debug" }, -- Debugging
				{ "<leader>dp", group = "profiler" }, -- Performance profiling
				{ "<leader>f", group = "file/find" }, -- File operations
				{ "<leader>g", group = "git" }, -- Git operations
				{ "<leader>gh", group = "hunks" }, -- Git hunks
				{ "<leader>q", group = "quit/session" }, -- Quit/session
				{ "<leader>s", group = "search" }, -- Search operations
				{ "<leader>u", group = "ui" }, -- UI toggles
				{ "<leader>x", group = "diagnostics/quickfix" }, -- Diagnostics
				{ "[", group = "prev" }, -- Previous navigation
				{ "]", group = "next" }, -- Next navigation
				{ "g", group = "goto" }, -- Go to commands
				{ "gs", group = "surround" }, -- Surround operations
				{ "z", group = "fold" }, -- Folding commands

				-- ========================================
				-- Dynamic Groups
				-- ========================================
				-- Buffer group (shows all open buffers)
				{
					"<leader>b",
					group = "buffer",
					expand = function()
						return require("which-key.extras").expand.buf()
					end,
				},
				-- Window group (shows window commands)
				{
					"<leader>w",
					group = "windows",
					proxy = "<c-w>", -- Proxy to Ctrl+w commands
					expand = function()
						return require("which-key.extras").expand.win()
					end,
				},

				-- ========================================
				-- Better Descriptions
				-- ========================================
				{ "gx", desc = "Open with system app" }, -- Open URL/file
			},
		},
	},

	-- ========================================
	-- Keymaps
	-- ========================================
	keys = {
		-- <leader>?: Show buffer-local keymaps
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Keymaps (which-key)",
		},

		-- Ctrl+w Space: Window hydra mode (repeat window commands)
		{
			"<c-w><space>",
			function()
				require("which-key").show({ keys = "<c-w>", loop = true })
			end,
			desc = "Window Hydra Mode (which-key)",
		},

		-- s: Show all 's' keymaps
		{
			"s",
			function()
				require("which-key").show({ global = false })
			end,
			desc = " S key-maps",
		},
	},

	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		-- Legacy support (deprecated)
		if not vim.tbl_isempty(opts.defaults) then
			LazyVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
			wk.register(opts.defaults)
		end
	end,
}
