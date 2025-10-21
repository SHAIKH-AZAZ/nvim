return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",

	opts = {
		options = {
			hover = {
				enabled = true,
				delay = 200,
				reveal = { "close" },
			},
		},
	},

	config = function()
		vim.opt.termguicolors = true
		require("bufferline").setup(opts)
	end,
}
