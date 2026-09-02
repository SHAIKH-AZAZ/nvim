-- Treesitter / syntax plugins

return {
  ---------------------------------------------------------------------------
  -- Extra Vim syntax / indent plugins
  { "iloginow/vim-stylus", ft = "stylus" },
  { "mustache/vim-mustache-handlebars", ft = { "mustache", "handlebars" } },
  { "lifepillar/pgsql.vim", ft = "pgsql" },
  { "MTDL9/vim-log-highlighting", ft = "log" },
  { "reasonml-editor/vim-reason-plus", ft = { "reason", "merlin" } },

  ---------------------------------------------------------------------------
  -- Auto close / rename HTML and JSX tags
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },

  ---------------------------------------------------------------------------
  -- Matchup — configured via globals now that the treesitter module is gone
  {
    "andymass/vim-matchup",
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      vim.g.matchup_matchparen_offscreen = {}
    end,
  },

  ---------------------------------------------------------------------------
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false, -- the main branch does not support lazy-loading
    config = function()
      require("nvim-treesitter").install({
        -- core / nvim itself
        "lua",
        "luadoc",
        "vim",
        "vimdoc",
        "query",
        "regex",
        "diff",
        -- languages with an LSP configured in lsp.lua
        "javascript",
        "jsdoc",
        "typescript",
        "tsx",
        "python",
        "html",
        "css",
        "json", -- jsonc filetypes map onto this parser
        "svelte",
        -- markup / config
        "markdown",
        "markdown_inline",
        "yaml",
        "toml",
        "bash",
        "dockerfile",
        -- previously in ensure_installed
        "comment",
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
        "vhs",
        "zig",
        "zsh",
      })
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("ts_highlight", { clear = true }),
        callback = function(event)
          local lang = vim.treesitter.language.get_lang(event.match)
          if lang and vim.treesitter.language.add(lang) then
            pcall(vim.treesitter.start, event.buf, lang)
          end
        end,
      })
    end,
  },

  ---------------------------------------------------------------------------
  -- Treesitter textobjects — was configured but never installed, so af/if/ac/
  -- ic and the ]f/[f motions have never actually worked. The main branch has
  -- no keymap table either; they are set by hand.
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")
      local swap = require("nvim-treesitter-textobjects.swap")

      -- Select: af/if (function), ac/ic (class), a,/i, (parameter)
      local selects = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["a,"] = "@parameter.outer",
        ["i,"] = "@parameter.inner",
      }
      for lhs, query in pairs(selects) do
        vim.keymap.set({ "x", "o" }, lhs, function()
          select.select_textobject(query, "textobjects")
        end, { desc = "Select " .. query })
      end

      -- Move: ]f/[f and ]F/[F (function), ]c/[c and ]C/[C (class), ],/[, (param)
      local moves = {
        { move.goto_next_start, { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["],"] = "@parameter.inner" } },
        { move.goto_next_end, { ["]F"] = "@function.outer", ["]C"] = "@class.outer" } },
        { move.goto_previous_start, { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[,"] = "@parameter.inner" } },
        { move.goto_previous_end, { ["[F"] = "@function.outer", ["[C"] = "@class.outer" } },
      }
      for _, spec in ipairs(moves) do
        local goto_fn, maps = spec[1], spec[2]
        for lhs, query in pairs(maps) do
          vim.keymap.set({ "n", "x", "o" }, lhs, function()
            goto_fn(query, "textobjects")
          end, { desc = "Goto " .. query })
        end
      end

      -- Swap parameters
      vim.keymap.set("n", ">,", function()
        swap.swap_next("@parameter.inner")
      end, { desc = "Swap Next Parameter" })
      vim.keymap.set("n", "<,", function()
        swap.swap_previous("@parameter.inner")
      end, { desc = "Swap Previous Parameter" })
    end,
  },
}
