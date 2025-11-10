-- ============================================================================
-- Blink.nvim - Next-gen Auto-Completion Engine
-- ============================================================================
-- Provides ultra-fast, async, and fuzzy completion using a Rust core.
-- Replaces nvim-cmp with:
--   • LSP + snippets + buffer + path + emoji + SQL completion
--   • Ghost text, documentation popups, and signature help
--   • Smart VS Code-style keymaps
-- Docs: https://github.com/Saghen/blink.cmp
-- ============================================================================

return {
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
    opts = {},
  },

  {
    "saghen/blink.cmp",
    version = "v0.*",

    dependencies = {
      "rafamadriz/friendly-snippets",
      "moyiz/blink-emoji.nvim",
    },

    event = "InsertEnter",

    opts = {
      keymap = {
        preset = "enter",
        ["<CR>"] = { "accept", "fallback" },
        ["<C-y>"] = { "accept", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<Tab>"] = { "select_and_accept", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      completion = {
        accept = {
          auto_brackets = { enabled = true },
        },
        menu = {
          border = "rounded",
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          window = { border = "rounded" },
        },
        ghost_text = { enabled = true },
      },

      signature = {
        enabled = true,
        window = { border = "rounded" },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer", "emoji" },
        providers = {
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15,
          },
        },
      },
    },

    opts_extend = { "sources.default" },
  },
}


