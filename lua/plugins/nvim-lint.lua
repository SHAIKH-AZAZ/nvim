-- ============================================================================
-- nvim-lint - External Linting
-- ============================================================================
-- NOTE: JS/TS linting now handled by ESLint LSP (see lsp.lua)
-- This file handles linting for filetypes NOT covered by an LSP linter
-- ============================================================================

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },

  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      -- NOTE: javascript/typescript eslint removed — ESLint LSP handles it
      -- (lsp.lua now properly starts ESLint LSP when config exists)
      css = { "stylelint" },
      scss = { "stylelint" },
      python = { "pylint" },
      markdown = { "markdownlint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>ll", function()
      lint.try_lint()
    end, { desc = "Trigger linting" })
  end,
}
