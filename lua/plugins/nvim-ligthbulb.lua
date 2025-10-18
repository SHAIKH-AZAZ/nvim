return {
	"kosayoda/nvim-lightbulb",
	event = "LspAttach",
	config = function()
		require("nvim-lightbulb").setup({
			sign = {
				enabled = true,
				text = "💡", -- symbol in sign column
				hl = "LightBulbSign",
			},
			virtual_text = {
				enabled = false, -- show 💡 inline instead of sign column
			},
			float = {
				enabled = false, -- show 💡 in floating window
			},
			status_text = {
				enabled = false, -- set a status text
			},
			autocmd = {
				enabled = true, -- auto-update on CursorHold
			},
		})
	end,
}
