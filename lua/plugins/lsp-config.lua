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
          "pynvim",
          "pyright"
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason.nvim",
			{ "mason-org/mason-lspconfig.nvim", config = function() end },
		},
      
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("lua_ls", {})
      vim.lsp.config("pynvim" , {})
			vim.lsp.config("ts_ls", { capabilities = capabilities })
			vim.lsp.config("tsserver", { capabilities = capabilities })
      vim.lsp.config("pyright" , {})
      vim.lsp.enable("pyright")
			vim.lsp.enable("tsserver")
      vim.lsp.enable("pynvim")
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("ts_ls")

			-- Keymaps for LSP
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {
				desc = "LSP code action , suggested actions",
			})
		end,
	},
}
