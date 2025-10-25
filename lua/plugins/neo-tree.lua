-- ============================================================================
-- Neo-tree - File Explorer
-- ============================================================================
-- Modern file tree explorer with git integration
-- Toggle with Ctrl+n
-- ============================================================================

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required utility library
		"nvim-tree/nvim-web-devicons", -- File icons
		"MunifTanjim/nui.nvim", -- UI components
	},
	config = function()
		require("neo-tree").setup({
			-- ========================================
			-- Filesystem Settings
			-- ========================================
			filesystem = {
				filtered_items = {
					hide_dotfiles = false, -- Show hidden files (.gitignore, .env, etc.)
					hide_gitignored = false, -- Show git-ignored files
				},
				follow_current_file = { enabled = true }, -- Auto-focus current file in tree
				group_empty_dirs = true, -- Collapse empty nested directories
				use_libuv_file_watcher = true, -- Live updates when creating/editing files
			},

			-- ========================================
			-- Visual Components
			-- ========================================
			default_component_configs = {
				-- Git status icons
				git_status = {
					symbols = {
						added = "", -- New file
						modified = "", -- Modified file
						deleted = "", -- Deleted file
						renamed = "", -- Renamed file
						untracked = "", -- Untracked file
						ignored = "", -- Git-ignored file
						unstaged = "󰄱", -- Unstaged changes
						staged = "", -- Staged changes
						conflict = "", -- Merge conflict
					},
				},
				-- Modified buffer indicator
				modified = {
					symbol = "●", -- Show dot for unsaved buffers (non-git too)
					highlight = "NeoTreeModified",
				},
			},

			-- ========================================
			-- Event Handlers
			-- ========================================
			event_handlers = {
				-- Auto-close tree when opening a file
				{
					event = "file_opened",
					handler = function()
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
				-- Notify when new file is added
				{
					event = "file_added",
					handler = function(file_path)
						vim.notify("New file added: " .. file_path, vim.log.levels.INFO)
					end,
				},
			},
		})
	end,
}
