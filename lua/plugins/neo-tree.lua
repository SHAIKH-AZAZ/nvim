return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- optional, but recommended
	},
	opts = {
		filesystem = {
			filtered_items = {
				visible = false, -- hide filtered items on open
				hide_gitignored = true,
			},
		},
	},
	lazy = false,
	config = function()
		-- vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true })
	end,
}
