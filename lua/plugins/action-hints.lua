return {
  {
    "roobert/action-hints.nvim",
    config = function()
      require("action-hints").setup({
        template = {
          definition = { text = " ⊛", color = "#add8e6" },
          references = { text = " ↱%s", color = "#ff6666" },
        },
        use_virtual_text = true,
      })
      -- Don't override lualine config - it's already configured in lualine.lua
      -- If you want action-hints in lualine, add it to lua/plugins/lualine.lua instead
    end,
  },
}
