return {
	{
		"roobert/action-hints.nvim",
		dependencies = { "nvim-lualine/lualine.nvim" },
		config = function()
			local ah = require("action-hints")
			ah.setup({
				template = {
					definition = { text = " ⊛", color = "#add8e6" },
					references = { text = " ↱%s", color = "#ff6666" },
				},
				use_virtual_text = true,
			})

			-- Function to get live counts for Lualine
			local function action_hints_status()
				local ok, state = pcall(require, "action-hints.state")
				if not ok or not state then
					return "AH: off"
				end

				local def_count = 0
				local ref_count = 0

				if state.cache and state.cache.definitions then
					def_count = #state.cache.definitions
				end
				if state.cache and state.cache.references then
					ref_count = #state.cache.references
				end

				return string.format("⊛ %d | ↱ %d", def_count, ref_count)
			end

			-- Lualine setup
			local ok, lualine = pcall(require, "lualine")
			if ok then
				lualine.setup({
					sections = {
						lualine_x = { action_hints_status },
					},
				})
			end
		end,
	},
}
