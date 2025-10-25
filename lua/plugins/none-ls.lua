-- ============================================================================
-- None-ls - Formatting and Linting
-- ============================================================================
-- Bridges external formatters/linters with Neovim's LSP
-- Provides formatting (prettier, stylua) and diagnostics (eslint, stylelint)
-- ============================================================================

return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim", -- Extra sources
		},
		config = function()
			local null_ls = require("null-ls")

			-- ========================================
			-- Formatting Sources
			-- ========================================
			-- Tools that format your code
			local formatting = {
				null_ls.builtins.formatting.stylua, -- Lua formatter
				null_ls.builtins.formatting.prettier, -- JS/TS/CSS/HTML/JSON formatter
				null_ls.builtins.formatting.eslint_d, -- JS/TS formatter + fixer
			}

			-- ========================================
			-- Diagnostic Sources
			-- ========================================
			-- Tools that check your code for errors
			local diagnostics = {
				null_ls.builtins.diagnostics.eslint_d, -- JS/TS linting
				null_ls.builtins.diagnostics.stylelint, -- CSS/SCSS/Tailwind linting
				null_ls.builtins.diagnostics.markdownlint, -- Markdown linting
				null_ls.builtins.diagnostics.jsonlint, -- JSON validation
			}

			-- ========================================
			-- Completion Sources
			-- ========================================
			local completion = {
				null_ls.builtins.completion.spell, -- Spell check suggestions
			}

			-- ========================================
			-- Merge All Sources
			-- ========================================
			local all_sources = {}
			vim.list_extend(all_sources, formatting)
			vim.list_extend(all_sources, diagnostics)
			vim.list_extend(all_sources, completion)

			-- ========================================
			-- Setup None-ls
			-- ========================================
			null_ls.setup({
				sources = all_sources,
			})

			-- ========================================
			-- Keymaps
			-- ========================================
			-- <leader>gf: Format current file
			vim.keymap.set("n", "<leader>gf", function()
				vim.lsp.buf.format({ async = true })
			end, { desc = "Format file with LSP" })
		end,
	},

	-- ========================================
	-- None-ls Extras
	-- ========================================
	-- Additional sources for none-ls
	{
		"nvimtools/none-ls-extras.nvim",
		lazy = true, -- Only load when needed
	},
}
