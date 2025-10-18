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
      require("lualine").setup({
        sections = {
          lualine_x = { require("action-hints").statusline },
        },
      })
    end,
  },
}
