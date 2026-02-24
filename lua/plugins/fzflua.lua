
return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    dependencies = { "echasnovski/mini.icons" },
    opts = {},
    -- NOTE: Most fzf-lua keymaps removed — Snacks.picker handles:
    --   <leader>fb (buffers), <leader>fr (recent), <leader><leader> (smart find)
    -- FZF-lua is kept as a dependency for some plugins but Snacks is the primary picker.
    keys = {},
}
