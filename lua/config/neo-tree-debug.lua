-- ============================================================================
-- Neo-tree Debug Commands
-- ============================================================================
-- Commands to diagnose neo-tree hidden files issues
-- ============================================================================

-- ========================================
-- Check Neo-tree Hidden Files Settings
-- ========================================
vim.api.nvim_create_user_command("NeoTreeDebug", function()
	local ok, neotree = pcall(require, "neo-tree")
	if not ok then
		vim.notify("❌ Neo-tree not loaded", vim.log.levels.ERROR)
		return
	end

	-- Get current state
	local state_ok, state = pcall(require, "neo-tree.sources.manager")
	if state_ok then
		local fs_state = state.get_state("filesystem")
		if fs_state and fs_state.filtered_items then
			local info = {
				"📁 Neo-tree Hidden Files Settings:",
				"",
				"hide_dotfiles: " .. tostring(fs_state.filtered_items.hide_dotfiles or false),
				"hide_gitignored: " .. tostring(fs_state.filtered_items.hide_gitignored or false),
				"hide_hidden: " .. tostring(fs_state.filtered_items.hide_hidden or false),
				"visible: " .. tostring(fs_state.filtered_items.visible or false),
				"",
				"💡 Press 'H' in neo-tree to toggle hidden files",
				"💡 Press 'I' in neo-tree to toggle git-ignored files",
			}
			vim.notify(table.concat(info, "\n"), vim.log.levels.INFO)
		else
			vim.notify("⚠️ Could not get neo-tree state", vim.log.levels.WARN)
		end
	else
		vim.notify("⚠️ Could not access neo-tree state", vim.log.levels.WARN)
	end
end, { desc = "Debug neo-tree hidden files settings" })

-- ========================================
-- Force Show Hidden Files
-- ========================================
vim.api.nvim_create_user_command("NeoTreeShowHidden", function()
	-- Force neo-tree to show hidden files
	vim.cmd([[
		Neotree close
		Neotree show
	]])
	vim.notify("🔄 Neo-tree refreshed - hidden files should be visible", vim.log.levels.INFO)
end, { desc = "Force neo-tree to show hidden files" })

-- ========================================
-- List Files in Current Directory
-- ========================================
vim.api.nvim_create_user_command("ListHiddenFiles", function()
	local cwd = vim.fn.getcwd()
	local handle = vim.loop.fs_scandir(cwd)
	
	if not handle then
		vim.notify("❌ Could not scan directory", vim.log.levels.ERROR)
		return
	end
	
	local files = {}
	local hidden_files = {}
	
	while true do
		local name, type = vim.loop.fs_scandir_next(handle)
		if not name then break end
		
		if name:sub(1, 1) == "." then
			table.insert(hidden_files, name .. (type == "directory" and "/" or ""))
		else
			table.insert(files, name .. (type == "directory" and "/" or ""))
		end
	end
	
	local info = {
		"📂 Files in: " .. cwd,
		"",
		"Hidden files (" .. #hidden_files .. "):",
	}
	
	for _, file in ipairs(hidden_files) do
		table.insert(info, "  • " .. file)
	end
	
	if #hidden_files == 0 then
		table.insert(info, "  (none)")
	end
	
	vim.notify(table.concat(info, "\n"), vim.log.levels.INFO)
end, { desc = "List hidden files in current directory" })
