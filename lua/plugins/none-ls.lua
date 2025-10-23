return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
		config = function()
			local null_ls = require("null-ls")

      -- formatting
      local formatting = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.eslint_d,
      }

      local diagnostics = {
				null_ls.builtins.diagnostics.eslint_d,     -- JS/TS linting
				null_ls.builtins.diagnostics.stylelint,    -- CSS/Tailwind linting
				null_ls.builtins.diagnostics.markdownlint, -- Markdown
				null_ls.builtins.diagnostics.jsonlint,     -- JSON
			}

      local completion = {
				null_ls.builtins.completion.spell, -- Spell completion
			}


      local all_sources = {}
			vim.list_extend(all_sources, formatting)
			vim.list_extend(all_sources, diagnostics)
			vim.list_extend(all_sources, completion)

			null_ls.setup({
				sources = vim.list_extend({}, formatting),
			})
	   		null_ls.setup({
				sources = vim.list_extend({}, formatting),
			})

			-- merge all sources in one table before setupf
			local all_sources = vim.list_extend({}, formatting)
			vim.list_extend(all_sources, diagnostics)
			vim.list_extend(all_sources, completion)

			--- final setup
			null_ls.setup({
				sources = all_sources,
			})

			vim.keymap.set("n", "<leader>gf", function()
				vim.lsp.buf.format({ async = true })
			end, { desc = "Format file with LSP" })
		end,
	},

	{
		"nvimtools/none-ls-extras.nvim",
		lazy = true,
	},
}
