
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    -- Modern maintained rainbow plugin
    "HiPhish/rainbow-delimiters.nvim",
  },
  config = function()
    local ts_configs = require("nvim-treesitter.configs")

    ts_configs.setup({
      ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "python",
        "html",
        "css",
        "json",
        "bash",
        "vim",
        "markdown",
      },
      auto_install = true,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false, -- safer
      },

      indent = {
        enable = true,
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    })

    -- Rainbow delimiters (replaces old ts-rainbow)
    local rainbow_delimiters = require("rainbow-delimiters")

    vim.g.rainbow_delimiters = {
      strategy = {
        [""] = rainbow_delimiters.strategy["global"],
        vim = rainbow_delimiters.strategy["local"],
      },
      query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
      },
      highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      },
    }
  end,
}

