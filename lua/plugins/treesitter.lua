return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate", -- update parsers automatically
  config = function()
    local ts_configs = require("nvim-treesitter.configs")

    ts_configs.setup({
      -- Parsers to install
      ensure_installed = { "lua", "javascript", "typescript", "python", "html", "css" },
      auto_install = true,
      -- Enable syntax highlighting
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      -- Enable indentation based on treesitter
      indent = {
        enable = true,
      },

      -- Incremental selection
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },

      -- Rainbow parentheses
      rainbow = {
        extended_mode = true,
        max_file_lines = nil,
      },
    })
  end
}
