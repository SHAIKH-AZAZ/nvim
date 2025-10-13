return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- ✅ Use new API if available (Neovim 0.11+), otherwise fallback
	  local lspconfig = (vim.lsp and vim.lsp.config) or require("lspconfig")

	  -- Setup language servers safely
	  local servers = { "lua_ls", "ts_ls" }

	  for _, server in ipairs(servers) do
		  if lspconfig[server] and lspconfig[server].setup then
			  lspconfig[server].setup({})
		  else
			  vim.notify("LSP: setup not found for " .. server, vim.log.levels.WARN)
		  end
	  end

	  -- Keymaps for LSP
	  vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
	  vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
	  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
  end,  },
}
