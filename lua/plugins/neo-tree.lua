-- ============================================================================
-- Neo-tree - File Explorer
-- ============================================================================
-- Modern file tree explorer with git integration
--
-- Shows: .env, .gitignore, and other important dotfiles
-- Hides: .git, .DS_Store, node_modules, .cache, .vscode, .idea
--
-- Keymaps:
--   Ctrl+n       - Toggle neo-tree
--   <leader>e    - Focus neo-tree
--   <leader>E    - Reveal current file in tree
--
-- Inside Neo-tree:
--   H            - Toggle ALL hidden files
--   I            - Toggle git-ignored files
--   a            - Add file/folder
--   d            - Delete
--   r            - Rename
--   c            - Copy
--   x            - Cut
--   p            - Paste
--   ?            - Show help
-- ============================================================================

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required utility library
		"nvim-tree/nvim-web-devicons", -- File icons
		"MunifTanjim/nui.nvim", -- UI components
	},
	keys = {
		-- Ctrl+n: Toggle neo-tree
		{ "<C-n>", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
		-- <leader>e: Focus neo-tree
		{ "<leader>e", "<cmd>Neotree focus<cr>", desc = "Focus Neo-tree" },
		-- <leader>E: Reveal current file in neo-tree
		{ "<leader>E", "<cmd>Neotree reveal<cr>", desc = "Reveal in Neo-tree" },
	},
	config = function()
		require("neo-tree").setup({
			-- ========================================
			-- Window Settings
			-- ========================================
			window = {
				position = "left", -- left, right, top, bottom, float, current
				width = 30, -- Width of the window
				mappings = {
					-- Toggle hidden files with H
					["H"] = "toggle_hidden",
					-- Toggle git-ignored files with I
					["I"] = "toggle_git_ignored",
				},
			},
			-- ========================================
			-- Filesystem Settings
			-- ========================================
			filesystem = {
				filtered_items = {
					-- ========================================
					-- IMPORTANT: Hidden files ARE shown by default
					-- Press 'H' in neo-tree to toggle them
					-- ========================================
					hide_dotfiles = false, -- FALSE = Show .env, .gitignore, etc.
					hide_gitignored = false, -- FALSE = Show git-ignored files
					hide_hidden = false, -- FALSE = Show hidden files
					
					-- Only hide these specific junk files
					hide_by_name = {
						-- ".DS_Store",
						-- "thumbs.db",
					},
					
					-- Don't hide by pattern
					hide_by_pattern = {},
					
					-- Always show important files (redundant but explicit)
					always_show = {
						".gitignore",
						".env",
						".env.local",
						".env.example",
						".env.development",
						".env.production",
						".eslintrc.js",
						".eslintrc.json",
						".prettierrc",
						".prettierrc.json",
					},
					
					-- Always show .env files
					always_show_by_pattern = {
						".env*",
					},
					
					-- Never show junk files
					never_show = {
						".DS_Store",
						"thumbs.db",
					},
					
					-- Show filtered items (dimmed)
					visible = true,
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
				-- Auto-close tree when opening a file (with error handling)
				{
					event = "file_opened",
					handler = function()
						pcall(function()
							require("neo-tree.command").execute({ action = "close" })
						end)
					end,
				},
				-- Notify when new file is added (with error handling)
				{
					event = "file_added",
					handler = function(file_path)
						pcall(function()
							vim.notify("New file added: " .. file_path, vim.log.levels.INFO)
						end)
					end,
				},
			},
		})
	end,
}
