-- ============================================================================
-- Treesitter - Advanced Syntax Highlighting
-- ============================================================================
-- Provides better syntax highlighting, code understanding, and text objects
-- Uses tree-sitter parsers for accurate code parsing
-- ============================================================================

return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" }, -- Load when opening files
		build = ":TSUpdate", -- Auto-update parsers after install
		dependencies = {
			"HiPhish/rainbow-delimiters.nvim", -- Rainbow parentheses (modern maintained version)
		},

		config = function()
			local ts_configs = require("nvim-treesitter.configs")

			ts_configs.setup({
				-- ========================================
				-- Language Parsers to Install
				-- ========================================
				ensure_installed = {
					-- Web Development
					"json",
					"javascript",
					"typescript",
					"tsx", -- TypeScript JSX
					"html",
					"css",
					"graphql",
					"svelte",
					"http", -- HTTP requests

					-- Backend
					"go",
					"python",
					"java",
					"rust",
					"ron", -- Rust Object Notation
					"c",

					-- Config/Data
					"yaml",
					"prisma", -- Prisma ORM
					"dockerfile",
					"gitignore",

					-- Documentation
					"markdown",
					"markdown_inline",

					-- Neovim
					"lua",
					"vim",
					"vimdoc",
					"query", -- Treesitter queries

					-- Shell
					"bash",
				},
				sync_install = false, -- Install parsers asynchronously
				auto_install = true, -- Auto-install missing parsers when opening files

				-- ========================================
				-- Syntax Highlighting
				-- ========================================
				highlight = {
					enable = true, -- Enable treesitter-based highlighting
					additional_vim_regex_highlighting = false, -- Disable old regex highlighting (faster)
				},

				-- ========================================
				-- Smart Indentation
				-- ========================================
				indent = {
					enable = true, -- Use treesitter for indentation
				},

				-- ========================================
				-- Incremental Selection
				-- ========================================
				-- Expand selection based on syntax tree
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>", -- Start selection
						node_incremental = "<C-space>", -- Expand to next node
						scope_incremental = false, -- Disabled
					},
				},
			})

			-- ========================================
			-- Rainbow Delimiters (Colored Brackets)
			-- ========================================
			-- Colors matching brackets/parentheses for easier reading
			local rainbow_delimiters = require("rainbow-delimiters")

			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"], -- Default strategy
					vim = rainbow_delimiters.strategy["local"], -- Vim-specific
				},
				query = {
					[""] = "rainbow-delimiters", -- Default query
					lua = "rainbow-blocks", -- Lua-specific (colors blocks)
				},
				-- Color cycle for nested brackets
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			}
		end,
	},

	-- ========================================
	-- Auto-close Tags (HTML/JSX/TSX)
	-- ========================================
	-- Automatically closes HTML/JSX tags as you type
	{
		"windwp/nvim-ts-autotag",
		enabled = true,
		-- Only load for these file types
		ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" },
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true, -- Auto-close tags: <div> → <div></div>
					enable_rename = true, -- Auto-rename pairs: <div> → <section> updates both tags
					enable_close_on_slash = false, -- Don't auto-close on </
				},
				-- Per-filetype configuration
				per_filetype = {
					["html"] = {
						enable_close = true, -- Enable for HTML
					},
					["typescriptreact"] = {
						enable_close = true, -- Enable for TSX
					},
				},
			})
		end,
	},
}
