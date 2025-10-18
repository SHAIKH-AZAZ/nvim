
return {
    "nvim-tree/nvim-web-devicons",
    lazy = true, -- load only when needed
    opts = {
        color_icons = true,
        default = true,
        strict = true,
        override = {
            zsh = {        -- you missed the key for override!
                icon = "",
                color = "#428850",
                cterm_color = "65",
                name = "Zsh",
            },
        },
    },
    config = function(_, opts)
        require("nvim-web-devicons").setup(opts)
    end,
}

