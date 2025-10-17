-- plugins/none-ls.lua
return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.completion.spell,
					null_ls.builtins.completion.prettier,
					-- null_ls.builtins.completion.eslint_d,
					-- eslint diagnostic will only work after extras is installed
				},
			})

			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},

	{
		"nvimtools/none-ls-extras.nvim", -- required for eslint diagnostics
		-- no config needed, lazy-loaded automatically
	},
}
