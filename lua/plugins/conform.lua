return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

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
				"package-lock.json",
				"yarn.lock",
				"pnpm-lock.yaml",
			}

			for _, excluded in ipairs(excluded_files) do
				if basename == excluded then
					return false
				end
			end

			return true
		end

		conform.setup({
			formatters_by_ft = {

				-- Web development
				javascript = {
					"prettier",
				},
				typescript = {
					"prettier",
				},
				javascriptreact = {
					"prettier",
				},
				typescriptreact = {
					"prettier",
				},
				css = {
					"prettier",
				},
				html = {
					"prettier",
				},
				json = {
					"prettier",
				},

				yaml = { "prettier" },

				markdown = { "prettier" },

				-- graphql = { "prettier" },

				-- Lua
				lua = { "stylua" },

				-- Python
				python = { "isort", "black" },

				-- Go
				-- go = { "gofmt", "goimports" },

				-- Rust
				-- rust = { "rustfmt" },

				-- Shell
				sh = { "shfmt" },

				bash = { "shfmt" },

				zsh = { "shfmt" },

				-- TOML
				-- toml = { "taplo" },

				-- Use the "*" filetype to run formatters on all filetypes
				["*"] = { "trim_whitespace" },
			},
			-- Set default options
			default_format_opts = {
				lsp_format = "fallback",
			},
			-- Set up format-on-save (with exclusions)
			format_on_save = function(bufnr)
				-- Don't format dotfiles and git-ignored files
				if not should_format(bufnr) then
					return nil
				end

				return {
					timeout_ms = 500,
					lsp_format = "fallback",
				}
			end,
			-- Customize formatters
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2" }, -- 2 spaces indentation
				},
			},
		})

		-- Keybindings
		vim.keymap.set({ "n", "v" }, "<leader>lf", function()
			local bufnr = vim.api.nvim_get_current_buf()
			if should_format(bufnr) then
				conform.format({
					lsp_format = "fallback",
					async = false,
					timeout_ms = 500,
				})
			else
				vim.notify("⚠️ Formatting disabled for this file", vim.log.levels.WARN)
			end
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
