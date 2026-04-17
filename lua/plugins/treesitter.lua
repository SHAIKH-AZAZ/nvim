-- ============================================================================
-- Treesitter - Advanced Syntax & Code Parsing
-- ============================================================================
-- Provides syntax highlighting, smart indentation, incremental selection,
-- rainbow parentheses, autotags, and better text objects.
-- ============================================================================

return {
  -- =========================================================
  -- Core Treesitter Setup
  -- =========================================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "HiPhish/rainbow-delimiters.nvim", -- Modern rainbow brackets
      "nvim-treesitter/nvim-treesitter-textobjects", -- Smart motions and selections
      "windwp/nvim-ts-autotag", -- Auto-close HTML/JSX tags
      "JoosepAlviste/nvim-ts-context-commentstring", -- Context-aware commenting
    },

    config = function()
      -- ========================================
      -- Basic Setup
      -- ========================================
      vim.g.skip_ts_context_commentstring_module = true
      
      require("nvim-treesitter").setup({
        ensure_installed = {
          -- Frontend / Web
          "html", "css", "javascript", "typescript", "tsx", "svelte", "vue", "json", "jsdoc",

          -- Backend
          "python",

          -- Config / Infra
          "yaml", "dockerfile", "gitignore",

          -- Docs
          "markdown", "markdown_inline",

          -- Neovim / Lua
          "lua", "vim", "vimdoc", "query",

          -- Shell / CLI
          "bash",
        },
        sync_install = false,
        auto_install = true,

        -- ========================================
        -- Highlighting
        -- ========================================
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 200 * 1024 -- 200 KB limit
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true -- Disable Treesitter for huge files
            end
          end,
          additional_vim_regex_highlighting = false,
        },

        -- ========================================
        -- Indentation
        -- ========================================
        indent = {
          enable = true,
          disable = { "yaml", "python" }, -- keep control for tricky formats
        },

        -- ========================================
        -- Incremental Selection
        -- ========================================
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            node_decremental = "<bs>",
          },
        },

        -- ========================================
        -- Text Objects (functions, classes, etc.)
        -- ========================================
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
            goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
          },
        },
      })        

      -- ========================================
      -- Rainbow Delimiters
      -- ========================================
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

      -- ========================================
      -- Autotag (HTML / JSX / Svelte)
      -- ========================================
      require("nvim-ts-autotag").setup({
        enable = true,
        filetypes = {
          "html",
          "xml",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "svelte",
          "vue",
        },
      })
    end,
  },
  -- =========================================================
  -- Context-aware Comment Strings (JSX, HTML, Svelte, Vue)
  -- =========================================================
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    config = function()
      require("ts_context_commentstring").setup({
        enable_autocmd = false,
        languages = {
          typescript = "// %s",
          typescriptreact = "{/* %s */}",
          javascript = "// %s",
          javascriptreact = "{/* %s */}",
          lua = "-- %s",
          html = "<!-- %s -->",
          svelte = "<!-- %s -->",
          vue = "<!-- %s -->",
          css = "/* %s */",
          scss = "/* %s */",
          json = "// %s",
        },
      })
    end,
  },
  -- =========================================================
  -- Treesitter Context (Sticky Header for Current Function)
  -- =========================================================
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 4, -- limit context height
        trim_scope = "inner",
        mode = "cursor", -- show context for cursor scope
        line_numbers = true,
      })
    end,
  },
}

