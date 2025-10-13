
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "auto", -- automatically match your colorscheme (better than hardcoding)
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
      globalstatus = true, -- use a single statusline across all windows (Neovim 0.9+)
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_c = { "filename" },
      lualine_x = { "location" },
    },
    extensions = { "neo-tree", "quickfix" },
  },
  config = function(_, opts)
    require("lualine").setup(opts)
  end,
}

