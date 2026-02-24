-- ============================================================================
-- Conform.nvim - Smart Code Formatting
-- ============================================================================
-- Project-aware: detects Biome, Prettier, or falls back to LSP
-- ============================================================================

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    -- ========================================
    -- Helper: detect which formatter to use
    -- ========================================
    -- Checks for project-specific config files to pick the right formatter
    local function detect_js_formatter()
      -- Check for Biome config (biome.json or biome.jsonc)
      local biome_config = vim.fs.find(
        { "biome.json", "biome.jsonc" },
        { upward = true, path = vim.fn.expand("%:p:h") }
      )
      if #biome_config > 0 then
        return { "biome" }
      end

      -- Check for dprint config
      local dprint_config = vim.fs.find(
        { "dprint.json", ".dprint.json" },
        { upward = true, path = vim.fn.expand("%:p:h") }
      )
      if #dprint_config > 0 then
        return { "dprint" }
      end

      -- Default to prettier (most common)
      return { "prettier" }
    end

    conform.setup({
      formatters_by_ft = {
        javascript = detect_js_formatter,
        typescript = detect_js_formatter,
        javascriptreact = detect_js_formatter,
        typescriptreact = detect_js_formatter,
        svelte = detect_js_formatter,
        vue = detect_js_formatter,
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        json = detect_js_formatter,
        jsonc = detect_js_formatter,
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
      },

      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })

    -- NOTE: <leader>lf removed — use <leader>f from keymaps.lua instead
  end,
}
