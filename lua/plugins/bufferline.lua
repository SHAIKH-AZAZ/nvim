return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",

	config = function()
		vim.opt.termguicolors = true
		require("bufferline").setup({
			options = {
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
				offsets = {
					filetype = "Neo-tree",
					text = function()
						return vim.fn.getcwd()
					end,
					highlights = "Directory",
					text_align = "left",
				},
				buffer_close_icon = "󰅖",
				modified_icon = "● ",
				close_icon = " ",
				left_trunc_marker = " ",
				right_trunc_marker = " ",
				color_icons = true,
				show_buffer_icons = true, -- disable filetype icons for buffers
				show_buffer_close_icons = true,
				show_close_icon = true,
				show_tab_indicators = true,
				separator_style = "thick",
				highlights = {
					fill = {
						bg = {
							attribute = "fg",
							highlight = "Pmenu",
						},
					},
				},
			},
		})
	end,
}
