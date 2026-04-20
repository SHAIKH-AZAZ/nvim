-- Treesitter / syntax plugins
-- Based on: https://github.com/rafi/vim-config

local has_git = vim.fn.executable("git") == 1

return {
  ---------------------------------------------------------------------------
  -- Extra Vim syntax / indent plugins
  { "iloginow/vim-stylus", ft = "stylus" },
  { "mustache/vim-mustache-handlebars", ft = { "mustache", "handlebars" } },
  { "lifepillar/pgsql.vim", ft = "pgsql" },
  { "MTDL9/vim-log-highlighting", ft = "log" },
  { "reasonml-editor/vim-reason-plus", ft = { "reason", "merlin" } },

  ---------------------------------------------------------------------------
  -- which-key label for treesitter decrement selection
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "V", desc = "Decrement Selection", mode = "x" },
      },
    },
  },

  ---------------------------------------------------------------------------
  -- Auto close / rename HTML and JSX tags
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },

  ---------------------------------------------------------------------------
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    keys = {
      { "<bs>", false, mode = "x" },
      { "V", desc = "Decrement Selection", mode = "x" },
    },
    dependencies = {
      {
        "andymass/vim-matchup",
        opts = {
          matchparen = {
            offscreen = {},
          },
        },
      },
    },
    opts = {
      sync_install = has_git,

      highlight = {
        enable = true,
        disable = function(_, buf)
          local max_filesize = 1024 * 1024 -- 1 MB
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          return ok and stats and stats.size > max_filesize
        end,
      },

      refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = true },
      },

      matchup = {
        enable = true,
        include_match_words = true,
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "V",
        },
      },

      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["a,"] = "@parameter.outer",
            ["i,"] = "@parameter.inner",
          },
        },

        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
            ["],"] = "@parameter.inner",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[,"] = "@parameter.inner",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
          },
        },

        swap = {
          enable = true,
          swap_next = {
            [">,"] = "@parameter.inner",
          },
          swap_previous = {
            ["<,"] = "@parameter.inner",
          },
        },
      },

      ensure_installed = {
        "comment",
        "css",
        "csv",
        "cue",
        "dtd",
        "editorconfig",
        "fish",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "graphql",
        "http",
        "json5",
        "just",
        "make",
        "readline",
        "scss",
        "sql",
        "ssh_config",
        "svelte",
        "vhs",
        "zig",
        "zsh",
      },
    },
  },
}
