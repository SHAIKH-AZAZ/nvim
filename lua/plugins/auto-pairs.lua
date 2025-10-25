-- ============================================================================
-- Auto-pairs - Automatic Bracket/Quote Pairing
-- ============================================================================
-- Automatically closes brackets, quotes, and parentheses as you type
-- Integrates with nvim-cmp for smart completion
-- ============================================================================

return {
	"windwp/nvim-autopairs",
	event = { "InsertEnter" }, -- Load when entering insert mode
	dependencies = {
		"hrsh7th/nvim-cmp", -- Completion plugin integration
	},
	config = function()
		local autopairs = require("nvim-autopairs")

		-- ========================================
		-- Setup Auto-pairs
		-- ========================================
		autopairs.setup({
			check_ts = true, -- Use treesitter for smarter pairing
			ts_config = {
				-- Don't add pairs inside these treesitter nodes
				lua = { "string" }, -- Don't pair inside Lua strings
				-- javascript = { "template_string" }, -- Don't pair in JS template strings
				java = false, -- Disable treesitter check for Java
			},
		})

		-- ========================================
		-- Integration with nvim-cmp
		-- ========================================
		-- Makes autopairs work with completion menu
		-- Example: Selecting a function completion will add () automatically
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")

		-- Trigger autopairs when confirming completion
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
