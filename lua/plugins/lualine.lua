
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },  -- optional, adds file icons
  config = function()
    require('lualine').setup({
      options = {
        theme = 'dracula',      -- automatically picks your colorscheme
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        globalstatus = true, -- Neovim 0.9+ global statusline
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      extensions = {'neo-tree', 'quickfix'}
    })
  end
}

