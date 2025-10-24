return {
	"echasnovski/mini.diff",
	version = false,
	event = { "BufReadPre", "BufNewFile" },
	cond = function()
		-- Only enable if NOT inside a Git repository
		local gitdir = vim.fn.finddir(".git", ".;")
		return gitdir == ""
	end,
	config = function()
		require("mini.diff").setup({
			view = {
				style = "sign", -- show in sign column (like gitsigns)
				signs = { add = "▎", change = "▎", delete = "" },
			},
			mappings = {
				apply = "gh", -- apply change hunk
				reset = "gr", -- reset hunk
				textobject = "ih", -- select hunk
			},
		})

		-- Optional navigation mappings (same as gitsigns)
		vim.keymap.set("n", "]h", function()
			require("mini.diff").jump("forward")
		end, { desc = "Next Change" })
		vim.keymap.set("n", "[h", function()
			require("mini.diff").jump("backward")
		end, { desc = "Prev Change" })
	end,
}
