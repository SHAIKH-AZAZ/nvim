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
			-- Helper: Check if file should be formatted
			-- ========================================
			local function should_format(bufnr)
				local filename = vim.api.nvim_buf_get_name(bufnr)
				local basename = vim.fn.fnamemodify(filename, ":t")

				-- Don't format dotfiles (files starting with .)
				if basename:match("^%.") then
					return false
				end

				-- Don't format if file is in .gitignore
				local gitignore_check = vim.fn.system("git check-ignore " .. vim.fn.shellescape(filename))
				if vim.v.shell_error == 0 then
					return false
				end

				-- Don't format these specific files
				local excluded_files = {
					".env",
					".env.local",
					".env.development",
					".env.production",
					".gitignore",
					".dockerignore",
					".npmrc",
					".yarnrc",
				}

				for _, excluded in ipairs(excluded_files) do
					if basename == excluded then
						return false
					end
				end

				return true
			end

			-- ========================================
			-- Setup None-ls
			-- ========================================
			null_ls.setup({
				sources = all_sources,
				-- Filter formatting based on file type
				on_attach = function(client, bufnr)
					-- Disable formatting for dotfiles and git-ignored files
					if not should_format(bufnr) then
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false
					end
				end,
			})

			-- ========================================
			-- Keymaps
			-- ========================================
			-- <leader>gf: Format current file (respects exclusions)
			vim.keymap.set("n", "<leader>gf", function()
				local bufnr = vim.api.nvim_get_current_buf()
				if should_format(bufnr) then
					vim.lsp.buf.format({ async = true })
				else
					vim.notify("⚠️ Formatting disabled for this file", vim.log.levels.WARN)
				end
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
