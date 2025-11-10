
-- ============================================================================
-- Gitsigns - Git Integration for Neovim
-- ============================================================================
-- Shows git diff markers in the sign column, enables inline blame, hunk preview,
-- staging, and more. Integrates seamlessly with Lualine and Telescope.
-- ============================================================================

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- Lazy-load when editing files
  cond = function()
    -- Only enable if inside a Git repo
    return vim.fn.isdirectory(".git") == 1
  end,

  config = function()
    local gitsigns = require("gitsigns")

    gitsigns.setup({
      -- ======================================================
      -- Appearance / Signs
      -- ======================================================
      signs = {
        add          = { text = "", hl = "GitSignsAdd" },       -- nf-fa-plus
        change       = { text = "", hl = "GitSignsChange" },    -- nf-oct-diff_modified
        delete       = { text = "", hl = "GitSignsDelete" },    -- nf-fa-minus
        topdelete    = { text = "󰍵", hl = "GitSignsDelete" },    -- nf-md-minus_box
        changedelete = { text = "󰚃", hl = "GitSignsChange" },    -- nf-md-tilde_box
        untracked    = { text = "󰐕", hl = "GitSignsAdd" },       -- nf-md-plus_box
      }
      ,

      signcolumn = true, -- Show git signs in sign column
      numhl = true, -- Highlight line numbers
      linehl = true, -- Highlight whole lines
      word_diff = false, -- Show intra-line differences (toggleable)

      -- ======================================================
      -- Blame / Performance
      -- ======================================================
      current_line_blame = false, -- Toggle with <leader>gb
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- End of line
        delay = 300,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = " <author> • <summary> (<author_time:%R>)",

      watch_gitdir = {
        follow_files = true,
      },
      update_debounce = 100,
      max_file_length = 40000, -- Don’t enable for giant files

      -- ======================================================
      -- Keymaps (buffer-local)
      -- ======================================================
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
        end

        -- Navigation between hunks
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Git Hunk")

        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Previous Git Hunk")

        -- Stage / Reset / Undo
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage")
        map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")

        -- Preview / Diff / Blame
        map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end, "Blame Line (Full)")
        map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle Line Blame")
        map("n", "<leader>hd", gs.diffthis, "Diff Against Index")
        map("n", "<leader>hD", function()
          gs.diffthis("~")
        end, "Diff Against HEAD~")

        -- Text Object for Hunks (use 'vih', 'dih', etc.)
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select Git Hunk")

        -- Toggles
        map("n", "<leader>htl", gs.toggle_linehl, "Toggle Line Highlight")
        map("n", "<leader>htn", gs.toggle_numhl, "Toggle Number Highlight")
        map("n", "<leader>htw", gs.toggle_word_diff, "Toggle Word Diff")
      end,
    })
  end,
}

