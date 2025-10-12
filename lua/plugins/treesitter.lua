
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",  -- update parsers automatically
  config = function()
    local ts_configs = require("nvim-treesitter.configs")

    ts_configs.setup({
      -- Parsers to install
      ensure_installed = { "lua", "javascript", "typescript", "python", "html", "css" },

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
--      rainbow = {
--        enable = true,
--        extended_mode = true, -- highlight non-bracket delimiters like html tags
--        max_file_lines = nil,
--      },
    })
  end,
  dependencies = {
    "p00f/nvim-ts-rainbow", -- rainbow plugin dependency
  },
}
