-- ============================================================================
-- LSP Configuration (Neovim 0.11+ + Mason + Blink.cmp)
-- ============================================================================

return {
  -- Mason: installer and manager for LSP, DAP, linters, and formatters
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason-LSPConfig: bridge Mason with lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",      -- lua server
          "ts_ls",       -- ✅ new name for the TypeScript server
          "pyright",     -- python server
          "html",        -- html server
          "cssls",       -- css
          "tailwindcss", -- tailwindcss server
          "emmet_ls",
          "jsonls",
        },
        automatic_installation = true,
      })
    end,
  },

  -- LSPConfig (core setup)
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp", "williamboman/mason-lspconfig.nvim" },

    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Disable LSP formatting (use conform/null-ls instead)
      local on_attach = function(client, _)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end

      local default_config = {
        capabilities = capabilities,
        on_attach = on_attach,
      }

      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup_handlers({
        -- Default handler for all servers
        function(server_name)
          local config = vim.tbl_extend("force", {}, default_config)

          -- Per-server tweaks
          if server_name == "ts_ls" then
            config.settings = {
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
            }
          elseif server_name == "lua_ls" then
            config.settings = {
              Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                  checkThirdParty = false,
                },
                telemetry = { enable = false },
              },
            }
          elseif server_name == "emmet_ls" then
            config.filetypes = { "html", "css", "javascriptreact", "typescriptreact" }
          end

          lspconfig[server_name].setup(config)
        end,
      })

      -- Keymaps (LSP buffer-local)
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
