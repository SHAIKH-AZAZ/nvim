-- ============================================================================
-- Health Check - Diagnostic Commands
-- ============================================================================
-- Commands to check if plugins and features are working correctly
-- ============================================================================

-- ========================================
-- Check LSP Status
-- ========================================
vim.api.nvim_create_user_command("CheckLSP", function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		vim.notify("❌ No LSP clients attached", vim.log.levels.WARN)
	else
		local names = {}
		for _, client in ipairs(clients) do
			table.insert(names, client.name)
		end
		vim.notify("✅ LSP Active: " .. table.concat(names, ", "), vim.log.levels.INFO)
	end
end, { desc = "Check LSP status" })

-- ========================================
-- Check Treesitter Status
-- ========================================
vim.api.nvim_create_user_command("CheckTreesitter", function()
	local ts_ok, ts = pcall(require, "nvim-treesitter.parsers")
	if not ts_ok then
		vim.notify("❌ Treesitter not loaded", vim.log.levels.ERROR)
		return
	end
	
	local parser = ts.get_parser()
	if parser then
		vim.notify("✅ Treesitter Active: " .. parser:lang(), vim.log.levels.INFO)
	else
		vim.notify("❌ No Treesitter parser for this filetype", vim.log.levels.WARN)
	end
end, { desc = "Check Treesitter status" })

-- ========================================
-- Check Completion Status
-- ========================================
vim.api.nvim_create_user_command("CheckCompletion", function()
	local blink_ok = pcall(require, "blink.cmp")
	if blink_ok then
		vim.notify("✅ Blink.cmp loaded", vim.log.levels.INFO)
	else
		vim.notify("❌ Blink.cmp not loaded", vim.log.levels.ERROR)
	end
end, { desc = "Check completion status" })

-- ========================================
-- Check Autopairs Status
-- ========================================
vim.api.nvim_create_user_command("CheckAutopairs", function()
	local autopairs_ok, autopairs = pcall(require, "nvim-autopairs")
	if autopairs_ok then
		local state = autopairs.state
		vim.notify("✅ Autopairs loaded and active", vim.log.levels.INFO)
	else
		vim.notify("❌ Autopairs not loaded", vim.log.levels.ERROR)
	end
end, { desc = "Check autopairs status" })

-- ========================================
-- Check All Plugins
-- ========================================
vim.api.nvim_create_user_command("CheckPlugins", function()
	local plugins = {
		{ name = "Telescope", module = "telescope" },
		{ name = "Neo-tree", module = "neo-tree" },
		{ name = "Treesitter", module = "nvim-treesitter" },
		{ name = "Gitsigns", module = "gitsigns" },
		{ name = "Lualine", module = "lualine" },
		{ name = "Blink.cmp", module = "blink.cmp" },
		{ name = "Which-key", module = "which-key" },
		{ name = "UFO", module = "ufo" },
	}
	
	local results = {}
	for _, plugin in ipairs(plugins) do
		local ok = pcall(require, plugin.module)
		table.insert(results, (ok and "✅ " or "❌ ") .. plugin.name)
	end
	
	vim.notify(table.concat(results, "\n"), vim.log.levels.INFO)
end, { desc = "Check all plugins" })

-- ========================================
-- Fix Line Numbers
-- ========================================
vim.api.nvim_create_user_command("FixLineNumbers", function()
	vim.wo.number = true
	vim.wo.relativenumber = true
	vim.notify("✅ Line numbers restored", vim.log.levels.INFO)
end, { desc = "Force enable line numbers" })

-- ========================================
-- Fix Window Layout
-- ========================================
vim.api.nvim_create_user_command("FixWindows", function()
	pcall(function()
		-- Close all floating windows
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			local config = vim.api.nvim_win_get_config(win)
			if config.relative ~= "" then
				vim.api.nvim_win_close(win, true)
			end
		end
		-- Equalize window sizes
		vim.cmd("wincmd =")
		vim.notify("✅ Windows fixed", vim.log.levels.INFO)
	end)
end, { desc = "Fix window layout issues" })

-- ========================================
-- Show Config Info
-- ========================================
vim.api.nvim_create_user_command("ConfigInfo", function()
	local info = {
		"📦 Neovim Config Info",
		"",
		"Version: " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch,
		"Config: " .. vim.fn.stdpath("config"),
		"Data: " .. vim.fn.stdpath("data"),
		"Leader: <Space>",
		"",
		"Quick Commands:",
		":CheckLSP - Check LSP status",
		":CheckTreesitter - Check Treesitter",
		":CheckPlugins - Check all plugins",
		":FixLineNumbers - Restore line numbers",
		":FixWindows - Fix window layout",
		":Lazy - Plugin manager",
		":Mason - LSP installer",
	}
	vim.notify(table.concat(info, "\n"), vim.log.levels.INFO)
end, { desc = "Show config information" })
