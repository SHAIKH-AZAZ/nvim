-- DISABLED: Causing errors with current setup
return {}
--[[
return {
  "nvim-lua/lsp-status.nvim",
  event = "LspAttach",
  config = function()
    local lsp_status = require("lsp-status")
    -- This works like .setup()
    lsp_status.setup({
      status_symbol = "🔧",
      current_function = true,
      show_filename = true,
    })
  end,
}
--]]

