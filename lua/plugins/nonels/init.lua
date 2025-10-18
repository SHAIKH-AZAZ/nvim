
return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local null_ls = require("null-ls")

      -- load modular sources
      local formatting = require("plugins.nonels.formatting")
      local diagnostics = require("plugins.nonels.diagnostics")
      local completion = require("plugins.nonels.completion")

      null_ls.setup({
        sources = vim.list_extend({}, formatting),
      })
      null_ls.setup({
        sources = vim.list_extend({} , formatting)
      })


      -- merge all sources in one table before setupf
      local all_sources = vim.list_extend({} , formatting)
      vim.list_extend(all_sources, diagnostics)
      vim.list_extend(all_sources,  completion)

      --- final setup 
      null_ls.setup({
        sources = all_sources,
      })

      vim.keymap.set("n", "<leader>gf", function()
        vim.lsp.buf.format({ async = true })
      end, { desc = "Format file with LSP" })
    end,
  },

  {
    "nvimtools/none-ls-extras.nvim",
    lazy = true,
  },
}

