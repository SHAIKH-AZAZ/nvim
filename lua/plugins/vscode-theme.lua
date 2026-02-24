-- ============================================================================
-- VS Code Theme — Dark+ / Light+ for Neovim
-- ============================================================================
-- Faithful recreation of VS Code's default Dark+ and Light+ themes
-- Switch with: <leader>ths or <leader>uC
-- Variants: "dark" (Dark+), "light" (Light+)
-- ============================================================================

return {
  "Mofiqul/vscode.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local vscode = require("vscode")

    vscode.setup({
      -- Style: "dark" (VS Code Dark+) or "light" (VS Code Light+)
      style = "dark",

      -- Enable transparent background (set to true if using terminal transparency)
      transparent = false,

      -- Enable italic comments
      italic_comments = true,

      -- Disable nvim-tree background color
      disable_nvimtree_bg = true,

      -- Better colors for specific highlight groups
      group_overrides = {
        -- Make line numbers less distracting
        LineNr = { fg = "#858585" },
        CursorLineNr = { fg = "#c6c6c6", bold = true },
      },
    })

    -- Uncomment to make VS Code theme the default:
    -- vim.cmd.colorscheme("vscode")
  end,
}
