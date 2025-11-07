-- ============================================================================
-- LSP Configuration for blink.cmp
-- ============================================================================
-- This file configures Language Server Protocol (LSP) servers for code
-- intelligence features like autocomplete, go-to-definition, error checking
-- ============================================================================

return {
	-- ========================================
	-- Mason: LSP Server Manager
	-- ========================================
	-- Mason provides a UI to install and manage LSP servers, formatters, linters
	-- Run :Mason to open the installer interface
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- ========================================
	-- Mason-LSPConfig: Bridge between Mason and LSP
	-- ========================================
	-- Automatically installs LSP servers when you open files
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				-- List of LSP servers to auto-install
				ensure_installed = {
					"lua_ls", -- Lua language server
					"ts_ls", -- TypeScript/JavaScript server
					"pyright", -- Python server
					"html", -- HTML server
					"cssls", -- CSS server
					"tailwindcss", -- Tailwind CSS server
					"emmet_ls", -- Emmet abbreviations (div>ul>li)
					"jsonls", -- JSON server
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Get capabilities from blink.cmp
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			
			-- Disable formatting from LSP servers (using conform.nvim instead)
			local on_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end

			-- ========================================
			-- TypeScript/JavaScript Server (ts_ls)
			-- ========================================
			-- Provides: autocomplete, type checking, refactoring for JS/TS/React
			vim.lsp.config.ts_ls = {
				capabilities = capabilities,
				on_attach = on_attach,
				-- File types this server handles
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				settings = {
					typescript = {
						-- Inlay hints show inline type information in your code
						inlayHints = {
							includeInlayParameterNameHints = "all", -- Show parameter names: func(name: "John")
							includeInlayFunctionParameterTypeHints = true, -- Show param types
						},
					},
					javascript = {
						-- Same hints for JavaScript files
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayFunctionParameterTypeHints = true,
						},
					},
				},
			}
			vim.lsp.enable("ts_ls") -- Start the server

			-- ========================================
			-- Tailwind CSS Server
			-- ========================================
			-- Provides: class name autocomplete, color previews for Tailwind
			vim.lsp.config.tailwindcss = {
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
			}
			vim.lsp.enable("tailwindcss")

			-- ========================================
			-- HTML Server
			-- ========================================
			-- Provides: HTML tag autocomplete, validation
			vim.lsp.config.html = {
				capabilities = capabilities,
				on_attach = on_attach,
			}
			vim.lsp.enable("html")

			-- ========================================
			-- CSS Server
			-- ========================================
			-- Provides: CSS property autocomplete, validation
			vim.lsp.config.cssls = {
				capabilities = capabilities,
				on_attach = on_attach,
			}
			vim.lsp.enable("cssls")

			-- ========================================
			-- Emmet Server
			-- ========================================
			-- Provides: Emmet abbreviations (type "div>ul>li*3" then expand)
			vim.lsp.config.emmet_ls = {
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "html", "css", "javascriptreact", "typescriptreact" },
			}
			vim.lsp.enable("emmet_ls")

			-- ========================================
			-- Lua Server
			-- ========================================
			-- Provides: Lua autocomplete, Neovim API support
			vim.lsp.config.lua_ls = {
				capabilities = capabilities,
				on_attach = on_attach,
			}
			vim.lsp.enable("lua_ls")

			-- ========================================
			-- Python Server (Pyright)
			-- ========================================
			-- Provides: Python type checking, autocomplete
			vim.lsp.config.pyright = {
				capabilities = capabilities,
				on_attach = on_attach,
			}
			vim.lsp.enable("pyright")

			-- ========================================
			-- LSP Keymaps
			-- ========================================
			-- Keyboard shortcuts for LSP features

			-- K: Show documentation/hover info for symbol under cursor
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})

			-- gd: Go to definition of symbol under cursor
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})

			-- gr: Show all references of symbol under cursor
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})

			-- <leader>ca: Show code actions (fixes, refactorings)
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

			-- <leader>rn: Rename symbol under cursor
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
		end,
	},
}
