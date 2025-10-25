-- LSP Configuration for blink.cmp
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
					"pyright",
					"html",
					"cssls",
					"tailwindcss",
					"emmet_ls",
					"jsonls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Get capabilities from blink.cmp
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- TypeScript/JavaScript with React support
			vim.lsp.config.ts_ls = {
				capabilities = capabilities,
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
			}
			vim.lsp.enable("ts_ls")

			-- Tailwind CSS
			vim.lsp.config.tailwindcss = {
				capabilities = capabilities,
				filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
			}
			vim.lsp.enable("tailwindcss")

			-- HTML
			vim.lsp.config.html = {
				capabilities = capabilities,
			}
			vim.lsp.enable("html")

			-- CSS
			vim.lsp.config.cssls = {
				capabilities = capabilities,
			}
			vim.lsp.enable("cssls")

			-- Emmet for HTML/JSX
			vim.lsp.config.emmet_ls = {
				capabilities = capabilities,
				filetypes = { "html", "css", "javascriptreact", "typescriptreact" },
			}
			vim.lsp.enable("emmet_ls")

			-- Lua
			vim.lsp.config.lua_ls = {
				capabilities = capabilities,
			}
			vim.lsp.enable("lua_ls")

			-- Python
			vim.lsp.config.pyright = {
				capabilities = capabilities,
			}
			vim.lsp.enable("pyright")

			-- Enable inlay hints globally
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					
					if client and client.server_capabilities.inlayHintProvider then
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					end
				end,
			})

			-- Keymaps for LSP
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end, { desc = "Toggle Inlay Hints" })
		end,
	},
}
