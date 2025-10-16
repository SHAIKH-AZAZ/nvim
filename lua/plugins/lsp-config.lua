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
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
        vim.lsp.config['lua_ls'] ={
      -- command for starting server
          cmd = {'lua-language-server'},
          filetypes = {'lua'},
      -- root marker for usage
         root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
      -- enabling lsp config for lua_ls 
        vim.lsp.enable('lua_ls'),
      },
	  -- Keymaps for LSP
	  vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
	  vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
	  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {
        desc = "LSP code action , suggested actions"

      })
  end,
  },
}
