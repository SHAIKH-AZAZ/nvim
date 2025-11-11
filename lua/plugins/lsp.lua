-- ============================================================================
-- LSP Configuration (Neovim 0.11+ Native API)
-- ============================================================================

return {
	-- Mason: installer and manager for LSP servers
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- Mason-LSPConfig: bridge Mason with LSP
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"pyright",
					"html",
					"cssls",
					"tailwindcss",
					"emmet_ls",
					"jsonls",
				},
				automatic_installation = true,
			})
		end,
	},

	-- LSP Setup using Neovim 0.11+ native API
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- Get capabilities from blink.cmp
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Disable formatting from LSP (using conform.nvim instead)
			local on_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end

			-- ========================================
			-- TypeScript/JavaScript Server
			-- ========================================
			vim.lsp.config.ts_ls = {
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayFunctionParameterTypeHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayFunctionParameterTypeHints = true,
						},
					},
				},
			}
			vim.lsp.enable("ts_ls")

			-- ========================================
			-- Lua Server
			-- ========================================
			vim.lsp.config.lua_ls = {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			}
			vim.lsp.enable("lua_ls")

			-- ========================================
			-- Python Server
			-- ========================================
			vim.lsp.config.pyright = {
				capabilities = capabilities,
				on_attach = on_attach,
			}
			vim.lsp.enable("pyright")

			-- ========================================
			-- HTML Server
			-- ========================================
			vim.lsp.config.html = {
				capabilities = capabilities,
				on_attach = on_attach,
			}
			vim.lsp.enable("html")

			-- ========================================
			-- CSS Server
			-- ========================================
			vim.lsp.config.cssls = {
				capabilities = capabilities,
				on_attach = on_attach,
			}
			vim.lsp.enable("cssls")

			-- ========================================
			-- Tailwind CSS Server
			-- ========================================
			vim.lsp.config.tailwindcss = {
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
			}
			vim.lsp.enable("tailwindcss")

			-- ========================================
			-- Emmet Server
			-- ========================================
			vim.lsp.config.emmet_ls = {
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "html", "css", "javascriptreact", "typescriptreact" },
			}
			vim.lsp.enable("emmet_ls")

			-- ========================================
			-- JSON Server
			-- ========================================
			vim.lsp.config.jsonls = {
				capabilities = capabilities,
				on_attach = on_attach,
			}
			vim.lsp.enable("jsonls")

			-- ========================================
			-- Disable ESLint LSP (causes errors)
			-- ========================================
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client and client.name == "eslint" then
						vim.lsp.stop_client(client.id)
					end
				end,
			})

			-- ========================================
			-- LSP Keymaps
			-- ========================================
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", vim.lsp.buf.definition, "Go to Definition")
					map("gr", vim.lsp.buf.references, "Show References")
					map("gI", vim.lsp.buf.implementation, "Go to Implementation")
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
					map("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
					map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
				end,
			})
		end,
	},
}
