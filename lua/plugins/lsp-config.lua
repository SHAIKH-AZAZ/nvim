return {
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls", "rust_analyzer", "ts_ls", "pyright", "eslint", "jsonls", "html", "cssls"
      }
    }

  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.enable("ts_ls");
      vim.lsp.enable("lua_ls");

      vim.keymap.set('n' , 'K' , vim.lsp.buf.hover , {})
      vim.keymap.set('n' , 'gd' , vim.lsp.buf.definition , {})
      vim.keymap.set({'n' , 'v'} , '<leader>ca' , vim.lsp.buf.code_action , {})
    end
  }
}
