-- ============================================================================
-- Catppuccin - Color Scheme
-- ============================================================================
-- Modern, pastel color scheme with 4 flavors: Latte, Frappe, Macchiato, Mocha
-- Supports transparent backgrounds and extensive customization
-- ============================================================================

return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000, -- Load before other plugins (colorscheme needs to be first)
	opts = {
		transparent_background = false,
	},
	config = function(_, opts)
		require("catppuccin").setup({
			-- ========================================
			-- Flavor Selection
			-- ========================================
			flavour = "auto", -- auto, latte, frappe, macchiato, mocha
			background = {
				light = "latte", -- Use latte for light mode
				dark = "mocha", -- Use mocha for dark mode
			},

			-- ========================================
			-- Transparency
			-- ========================================
			transparent_background = true, -- Make background transparent
			float = {
				transparent = false, -- Floating windows have solid background
				solid = false, -- Use border styling
			},

			-- ========================================
			-- Visual Settings
			-- ========================================
			show_end_of_buffer = false, -- Hide '~' after file end
			term_colors = false, -- Don't set terminal colors
			dim_inactive = {
				enabled = false, -- Don't dim inactive windows
				shade = "dark",
				percentage = 0.15,
			},

			-- ========================================
			-- Font Styles
			-- ========================================
			no_italic = false, -- Allow italic text
			no_bold = false, -- Allow bold text
			no_underline = false, -- Allow underlines

			-- Style overrides for different syntax elements
			styles = {
				comments = { "italic" }, -- Italic comments
				conditionals = { "italic" }, -- Italic if/else
				loops = {}, -- Default style for loops
				functions = {}, -- Default style for functions
				keywords = {}, -- Default style for keywords
				strings = {}, -- Default style for strings
				variables = {}, -- Default style for variables
				numbers = {}, -- Default style for numbers
				booleans = {}, -- Default style for true/false
				properties = {}, -- Default style for object properties
				types = {}, -- Default style for types
				operators = {}, -- Default style for +, -, etc.
			},

			-- ========================================
			-- LSP Styles
			-- ========================================
			lsp_styles = {
				-- Virtual text (inline diagnostics)
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
					ok = { "italic" },
				},
				-- Underlines for diagnostics
				underlines = {
					errors = { "underline" },
					hints = { "underline" },
					warnings = { "underline" },
					information = { "underline" },
					ok = { "underline" },
				},
				-- Inlay hints styling
				inlay_hints = {
					background = true, -- Show background for inlay hints
				},
			},

			-- ========================================
			-- Color Overrides
			-- ========================================
			color_overrides = {}, -- Custom color palette (empty = use defaults)

			-- ========================================
			-- Highlight Overrides
			-- ========================================
			-- Customize specific highlight groups per flavor
			highlight_overrides = {
				all = function(colors)
					return {
						NvimTreeNormal = { fg = colors.none }, -- File tree text color
						CmpBorder = { fg = "#3e4145" }, -- Completion menu border
					}
				end,
				latte = function(latte)
					return {
						Normal = { fg = latte.base }, -- Light mode text
					}
				end,
				frappe = function(frappe)
					return {
						["@comment"] = { fg = frappe.surface2, style = { "italic" } }, -- Comments
					}
				end,
				macchiato = function(macchiato)
					return {
						LineNr = { fg = macchiato.overlay1 }, -- Line numbers
					}
				end,
				mocha = function(mocha)
					return {
						Comment = { fg = mocha.flamingo }, -- Dark mode comments
					}
				end,
			},

			-- ========================================
			-- Custom Highlights
			-- ========================================
			-- Apply to all flavors
			custom_highlights = function(colors)
				return {
					Comment = { fg = colors.flamingo }, -- Comment color
					TabLineSel = { bg = colors.pink }, -- Selected tab background
					CmpBorder = { fg = colors.surface2 }, -- Completion border
					Pmenu = { bg = colors.none }, -- Popup menu background
				}
			end,

			-- ========================================
			-- Plugin Integrations
			-- ========================================
			default_integrations = true, -- Enable default plugin support
			auto_integrations = false, -- Don't auto-detect plugins
			integrations = {
				cmp = true, -- nvim-cmp completion
				gitsigns = true, -- Git signs in gutter
				nvimtree = true, -- File tree
				notify = false, -- Notification plugin
				mini = {
					enabled = true, -- mini.nvim plugins
					indentscope_color = "", -- Use default color
				},
				-- More integrations available at:
				-- https://github.com/catppuccin/nvim#integrations
			},
		})

		-- ========================================
		-- Apply Colorscheme
		-- ========================================
		vim.cmd.colorscheme("catppuccin")
	end,
}
