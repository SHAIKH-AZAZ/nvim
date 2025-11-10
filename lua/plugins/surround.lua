
-- ============================================================================
-- nvim-surround - Fast and Powerful Surround Editing
-- ============================================================================
-- This plugin lets you add, delete, or replace surrounding characters
-- (quotes, brackets, parentheses, HTML tags, etc.) quickly and intuitively.
--
-- EXAMPLES:
--   Old:  (hello)   →  Add:  "hello"   →  Change:  [hello]   →  Delete:  hello
--
-- It mimics vim-surround but works in Lua with Treesitter awareness.
-- Documentation: https://github.com/kylechui/nvim-surround
-- ============================================================================

return {
  "kylechui/nvim-surround",
  event = "VeryLazy", -- Load only when needed (saves startup time)
  config = function()
    require("nvim-surround").setup({})
  end,
}

