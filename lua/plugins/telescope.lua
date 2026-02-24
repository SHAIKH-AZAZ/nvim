-- ============================================================================
-- Telescope - Fuzzy Finder + Theme Switcher
-- ============================================================================
-- Powerful, extensible fuzzy finder for files, text, buffers, help, etc.
-- Includes live theme switcher with persistent saving.
-- ============================================================================

return {
  "nvim-telescope/telescope.nvim",
  branch = "master", -- Use latest to avoid deprecated warnings
  dependencies = {
    "nvim-lua/plenary.nvim", -- Core dependency
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- Faster fuzzy matching (C)
    "nvim-tree/nvim-web-devicons", -- File icons
    "andrew-george/telescope-themes", -- Theme switcher extension
    "lewis6991/gitsigns.nvim" ,
  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    -- Load Telescope extensions
    telescope.load_extension("fzf")
    telescope.load_extension("themes")

    -- Telescope setup
    telescope.setup({
      defaults = {
        prompt_prefix = "🔍 ",
        selection_caret = " ",
        path_display = { "smart" },
        layout_config = { horizontal = { preview_width = 0.55 } },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          },
        },
      },
      extensions = {
        themes = {
          enable_previewer = true,
          enable_live_preview = true,
          persist = {
            enabled = true,
            path = vim.fn.stdpath("config") .. "/lua/colorscheme.lua", -- Save selected theme here
          },
        },
      },
    })

    -- ================================================================
    -- Keymaps
    -- ================================================================

    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- NOTE: Most Telescope keymaps removed — Snacks.picker handles:
    --   <leader>ff (find files), <leader>fg (live grep), <leader>fb (buffers),
    --   <leader>fh (help), <leader>fr (recent), <leader>fw (grep word)
    -- Only theme switcher remains (Snacks doesn't have one)
    keymap("n", "<leader>ths", "<cmd>Telescope themes<CR>", { desc = "Open Theme Switcher", unpack(opts) })

    -- ================================================================
    -- Load persisted theme (auto-apply on startup)
    -- ================================================================
    -- local theme_file = vim.fn.stdpath("config") .. "/lua/colorscheme.lua"
    -- if vim.fn.filereadable(theme_file) == 1 then
    --   local ok, theme = pcall(dofile, theme_file)
    --   if ok and theme and theme.name then
    --     vim.cmd.colorscheme(theme.name)
    --   else
    --     vim.cmd.colorscheme("tokyonight") -- fallback
    --   end
    -- else
    --   vim.cmd.colorscheme("tokyonight") -- default fallback
    -- end
  end,
}
