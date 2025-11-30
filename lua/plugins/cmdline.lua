return {
	{
		"VonHeikemen/fine-cmdline.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = function()
			-- Setup fine-cmdline
			require("fine-cmdline").setup({
				cmdline = {
					prompt = ": ",
					smart_completion = true,
				},
				popup = {
					position = {
						row = "20%", -- or absolute number
						col = "50%",
					},
					border = {
						style = "rounded",
					},
					size = {
						width = "60%",
						height = "20%",
					},
				},
			})

			-- Keymap to open fine-cmdline instead of :
			vim.keymap.set("n", ":", "<cmd>FineCmdline<CR>", { noremap = true })
		end,
	},
}
