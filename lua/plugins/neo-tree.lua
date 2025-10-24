return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
				},
				follow_current_file = { enabled = true },
				group_empty_dirs = true,
				use_libuv_file_watcher = true, -- live updates when creating/editing files
			},
			default_component_configs = {
				git_status = {
					symbols = {
						-- Status type → icon mappings
						added = "",
						modified = "",
						deleted = "",
						renamed = "",
						untracked = "",
						ignored = "",
						unstaged = "󰄱",
						staged = "",
						conflict = "",
					},
				},
				modified = {
					symbol = "●", -- Show dot for unsaved buffers (non-git too)
					highlight = "NeoTreeModified",
				},
			},
			event_handlers = {
				-- Optional: auto-refresh when saving or switching buffers
				{
					event = "file_opened",
					handler = function()
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
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
