return {
  "nvim-lua/lsp-status.nvim",
  event = "LspAttach",
  config = function()
    require("lsp-status").setup()
  end,
}

