return {
	"folke/which-key.nvim",
	event = "VeryLazy", -- Load after startup
	opts_extend = { "spec" },
	opts = {
		preset = "modern", -- Visual preset: "classic", "modern", or "helix"
		
		-- Delay before showing popup
		delay = function(ctx)
			return ctx.plugin and 0 or 200
		end,
		
		-- Filter which mappings to show
		filter = function(mapping)
			return true -- Show all mappings
		end,
		
		-- Show warnings for mapping issues
		notify = true,
		
		-- Triggers for showing popup
		triggers = {
			{ "<auto>", mode = "nxso" },
		},
		
		-- Defer popup in visual modes
		defer = function(ctx)
			return ctx.mode == "V" or ctx.mode == "<C-V>"
		end,
		
		-- Plugin integrations
		plugins = {
			marks = true, -- Shows marks on ' and `
			registers = true, -- Shows registers on " or <C-r>
			spelling = {
				enabled = true, -- Show suggestions on z=
				suggestions = 20,
			},
			presets = {
				operators = true, -- Help for d, y, etc.
				motions = true, -- Help for motions
				text_objects = true, -- Help for text objects
				windows = true, -- Help for <C-w>
				nav = true, -- Misc window bindings
				z = true, -- Fold/spelling bindings
				g = true, -- g prefix bindings
			},
		},
		
		-- Window appearance
		win = {
			no_overlap = true, -- Don't cover cursor
			padding = { 1, 2 }, -- [top/bottom, right/left]
			title = true,
			title_pos = "center",
			zindex = 1000,
			bo = {},
			wo = {
				winblend = 10, -- Slight transparency
			},
		},
		
		-- Layout
		layout = {
			width = { min = 20 },
			spacing = 3,
		},
		
		-- Scroll bindings
		keys = {
			scroll_down = "<c-d>",
			scroll_up = "<c-u>",
		},
		
		-- Sorting order
		sort = { "local", "order", "group", "alphanum", "mod" },
		
		-- Expand groups
		expand = 0, -- 0 = collapsed by default
		
		-- Label formatting
		replace = {
			key = {
				function(key)
					return require("which-key.view").format(key)
				end,
			},
			desc = {
				{ "<Plug>%(?(.*)%)?", "%1" },
				{ "^%+", "" },
				{ "<[cC]md>", "" },
				{ "<[cC][rR]>", "" },
				{ "<[sS]ilent>", "" },
				{ "^lua%s+", "" },
				{ "^call%s+", "" },
				{ "^:%s*", "" },
			},
		},
		
		-- Icons
		icons = {
			breadcrumb = "»",
			separator = "➜",
			group = "+",
			ellipsis = "…",
			mappings = true,
			rules = {},
			colors = true,
			keys = {
				Up = " ",
				Down = " ",
				Left = " ",
				Right = " ",
				C = "󰘴 ",
				M = "󰘵 ",
				D = "󰘳 ",
				S = "󰘶 ",
				CR = "󰌑 ",
				Esc = "󱊷 ",
				ScrollWheelDown = "󱕐 ",
				ScrollWheelUp = "󱕑 ",
				NL = "󰌑 ",
				BS = "󰁮",
				Space = "󱁐 ",
				Tab = "󰌒 ",
				F1 = "󱊫",
				F2 = "󱊬",
				F3 = "󱊭",
				F4 = "󱊮",
				F5 = "󱊯",
				F6 = "󱊰",
				F7 = "󱊱",
				F8 = "󱊲",
				F9 = "󱊳",
				F10 = "󱊴",
				F11 = "󱊵",
				F12 = "󱊶",
			},
		},
		
		show_help = true,
		show_keys = true,
		
		-- Disable for certain types
		disable = {
			ft = {},
			bt = {},
		},
		
		debug = false,
		
		defaults = {},

		-- ========================================
		-- Keymap Groups
		-- ========================================
		-- Organize keymaps into logical groups
		spec = {
			{
				mode = { "n", "v" }, -- Normal and visual modes
				-- Group definitions (shown in which-key popup)
				{ "<leader><tab>", group = "tabs" }, -- Tab management
				{ "<leader>c", group = "code" }, -- Code actions
				{ "<leader>d", group = "debug" }, -- Debugging
				{ "<leader>dp", group = "profiler" }, -- Performance profiling
				{ "<leader>f", group = "file/find" }, -- File operations
				{ "<leader>g", group = "git" }, -- Git operations
				{ "<leader>gh", group = "hunks" }, -- Git hunks
				{ "<leader>q", group = "quit/session" }, -- Quit/session
				{ "<leader>s", group = "search" }, -- Search operations
				{ "<leader>u", group = "ui" }, -- UI toggles
				{ "<leader>x", group = "diagnostics/quickfix" }, -- Diagnostics
				{ "[", group = "prev" }, -- Previous navigation
				{ "]", group = "next" }, -- Next navigation
				{ "g", group = "goto" }, -- Go to commands
				{ "gs", group = "surround" }, -- Surround operations
				{ "z", group = "fold" }, -- Folding commands

				-- ========================================
				-- Dynamic Groups
				-- ========================================
				-- Buffer group (shows all open buffers)
				{
					"<leader>b",
					group = "buffer",
					expand = function()
						return require("which-key.extras").expand.buf()
					end,
				},
				-- Window group (shows window commands)
				{
					"<leader>w",
					group = "windows",
					proxy = "<c-w>", -- Proxy to Ctrl+w commands
					expand = function()
						return require("which-key.extras").expand.win()
					end,
				},

				-- ========================================
				-- Better Descriptions
				-- ========================================
				{ "gx", desc = "Open with system app" }, -- Open URL/file
			},
		},
	},

	-- ========================================
	-- Keymaps
	-- ========================================
	keys = {
		-- <leader>?: Show buffer-local keymaps
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Keymaps (which-key)",
		},

		-- Ctrl+w Space: Window hydra mode (repeat window commands)
		{
			"<c-w><space>",
			function()
				require("which-key").show({ keys = "<c-w>", loop = true })
			end,
			desc = "Window Hydra Mode (which-key)",
		},

		-- s: Show all 's' keymaps
		{
			"s",
			function()
				require("which-key").show({ global = false })
			end,
			desc = " S key-maps",
		},
	},

	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		-- Legacy support (deprecated)
		if not vim.tbl_isempty(opts.defaults) then
			LazyVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
			wk.register(opts.defaults)
		end
	end,
}
