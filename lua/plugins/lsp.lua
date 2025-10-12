
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    -- ===========================
    -- Mason Setup
    -- ===========================
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "pyright", "ts_ls" },
    })

    -- ===========================
    -- nvim-cmp Setup
    -- ===========================
    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
      },
    })

    -- ===========================
    -- LSP Keymaps
    -- ===========================
    local on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      local map = vim.keymap.set

      map("n", "gd", vim.lsp.buf.definition, opts)
      map("n", "K", vim.lsp.buf.hover, opts)
      map("n", "gi", vim.lsp.buf.implementation, opts)
      map("n", "<leader>rn", vim.lsp.buf.rename, opts)
      map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      map("n", "gr", vim.lsp.buf.references, opts)
    end

    -- ===========================
    -- Capabilities for nvim-cmp
    -- ===========================
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- ===========================
    -- LSP Servers
    -- ===========================
    local lspconfig = require("lspconfig")

    -- Lua
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = { diagnostics = { globals = { "vim" } } }
      }
    })

    -- Python
    lspconfig.pyright.setup({
      on_attach = on_attach,
      capabilities = capabilities
    })

    -- JavaScript / TypeScript
    lspconfig.ts_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities
    })
  end
}

