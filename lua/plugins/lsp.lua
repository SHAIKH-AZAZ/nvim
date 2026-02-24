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
					"svelte",
				},
				automatic_installation = true,
			})
		end,
	},

	-- Schemastore: JSON/YAML schemas for package.json, tsconfig, etc.
	{
		"b0o/schemastore.nvim",
		lazy = true,
	},

	-- LSP Setup using Neovim 0.11+ native API
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"b0o/schemastore.nvim",
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
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayVariableTypeHintsWhenTypeMatchesName = false,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayVariableTypeHintsWhenTypeMatchesName = false,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
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
			-- Tailwind CSS Server (project-aware)
			-- ========================================
			-- Only starts when tailwind.config.* exists in the project
			vim.lsp.config.tailwindcss = {
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte", "vue" },
				root_markers = {
					"tailwind.config.js",
					"tailwind.config.cjs",
					"tailwind.config.mjs",
					"tailwind.config.ts",
				},
			}
			vim.lsp.enable("tailwindcss")

			-- ========================================
			-- Emmet Server
			-- ========================================
			vim.lsp.config.emmet_ls = {
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "html", "css", "javascriptreact", "typescriptreact", "svelte", "vue" },
			}
			vim.lsp.enable("emmet_ls")

			-- ========================================
			-- JSON Server (with schemastore)
			-- ========================================
			vim.lsp.config.jsonls = {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			}
			vim.lsp.enable("jsonls")

			-- ========================================
			-- Svelte Server
			-- ========================================
			vim.lsp.config.svelte = {
				capabilities = capabilities,
				on_attach = on_attach,
			}
			vim.lsp.enable("svelte")

			-- ========================================
			-- ESLint LSP (project-aware)
			-- ========================================
			-- Only starts when ESLint config exists in the project
			-- NOTE: Previously ESLint was killed on attach. Now it's
			-- properly configured to only run in projects that use it.
			-- Formatting is still disabled (conform.nvim handles that).
			vim.lsp.config.eslint = {
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					-- Disable formatting (conform.nvim handles it)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
				root_markers = {
					".eslintrc",
					".eslintrc.js",
					".eslintrc.cjs",
					".eslintrc.json",
					".eslintrc.yaml",
					".eslintrc.yml",
					"eslint.config.js",
					"eslint.config.mjs",
					"eslint.config.cjs",
					"eslint.config.ts",
				},
			}
			vim.lsp.enable("eslint")

			-- ========================================
			-- LSP Keymaps
			-- ========================================
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- NOTE: gd and gI handled by Snacks picker (snacks.lua)
					-- NOTE: [d and ]d handled globally (keymaps.lua)
					map("gr", vim.lsp.buf.references, "Show References")
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
					map("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
				end,
			})
		end,
	},
}
