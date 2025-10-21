# Neovim Configuration Structure

## Overview
This is a modern, modular Neovim configuration using lazy.nvim as the plugin manager.

## Directory Structure

```
~/.config/nvim/
├── init.lua                    # Entry point - bootstraps lazy.nvim
├── lazy-lock.json             # Plugin version lock file
├── lua/
│   ├── core/
│   │   └── options.lua        # All Vim options and settings
│   ├── config/
│   │   └── autocmd.lua        # Autocommands
│   └── plugins/               # Plugin configurations (auto-loaded by lazy.nvim)
│       ├── init.lua
│       ├── lsp.lua
│       ├── blinkcmp.lua
│       ├── treesitter.lua
│       ├── bufferline.lua
│       ├── lualine.lua
│       ├── catppuccin.lua
│       ├── telescope.lua
│       ├── fzflua.lua
│       ├── neo-tree.lua
│       ├── snacks.lua
│       ├── gitsigns.lua
│       ├── conform.lua
│       ├── trouble.lua
│       ├── which-key.lua
│       ├── mini.lua
│       ├── auto-pairs.lua
│       ├── autotags.lua
│       ├── autosessions.lua
│       ├── project.lua
│       ├── undotree.lua
│       ├── dressing.lua
│       ├── eyeliner.lua
│       ├── breadcrumb.lua
│       ├── action-hints.lua
│       ├── lsp-status.lua
│       ├── lsp-utils.lua
│       ├── nvim-ligthbulb.lua
│       ├── referencer.lua
│       ├── devicons.lua
│       ├── neo-tree-icon.lua
│       └── nonels/
│           ├── init.lua
│           ├── formatting.lua
│           ├── diagnostics.lua
│           └── completion.lua
```

## Configuration Files

### init.lua
- Bootstraps lazy.nvim
- Loads core options
- Initializes plugin system
- Loads autocommands

### lua/core/options.lua
**Consolidated Vim settings including:**
- Leader keys (space and backslash)
- UI settings (line numbers, cursor, colors)
- Indentation (2 spaces, smart indent)
- Search (smart case, incremental)
- Split behavior (right/below)
- Performance optimizations
- Clipboard integration
- Folding with treesitter
- Disabled built-in plugins

### lua/config/autocmd.lua
**Autocommands for:**
- File reload on focus
- Highlight on yank
- Window resize handling
- Last cursor position restoration
- Quick close for special buffers
- Spell checking for text files
- JSON conceallevel fix
- Auto-create directories on save

### lua/plugins/
Each file configures a specific plugin or group of related plugins.
All files are automatically loaded by lazy.nvim.

## Key Features

### LSP & Completion
- **blink.cmp**: Modern completion engine
- **nvim-lspconfig**: LSP configuration
- **Mason**: LSP/tool installer
- **Conform**: Code formatting

### UI
- **Catppuccin**: Color scheme with transparency
- **Lualine**: Statusline
- **Bufferline**: Buffer tabs with diagnostics
- **Snacks**: Unified picker/explorer/notifications
- **Which-key**: Keybinding hints

### Navigation
- **Telescope**: Fuzzy finder
- **fzf-lua**: Alternative fuzzy finder
- **Neo-tree**: File explorer
- **mini.files**: Alternative file explorer

### Editing
- **Treesitter**: Syntax highlighting
- **nvim-autopairs**: Auto-close brackets
- **nvim-ts-autotag**: Auto-close HTML/JSX tags
- **mini.surround**: Surround operations
- **mini.comment**: Smart commenting

### Git
- **Gitsigns**: Git decorations and operations
- **Snacks**: Lazygit integration

## Recent Changes

### Removed
- ✅ nvim-cmp and all related plugins (replaced by blink.cmp)
- ✅ lua/vim-options.lua (consolidated into core/options.lua)
- ✅ lua/core/init.lua (unused)
- ✅ lua/current-theme.lua (unused)

### Fixed
- ✅ Telescope syntax error (removed stray table)
- ✅ Bufferline configuration (proper offsets, diagnostics, keymaps)
- ✅ nvim-autopairs (removed nvim-cmp integration)

### Improved
- ✅ Consolidated all Vim options into single file
- ✅ Added comprehensive comments and organization
- ✅ Better performance settings
- ✅ Proper lazy loading configuration

## Next Steps (Optional)

1. **Separate keymaps**: Extract keymaps from plugin configs into dedicated files
2. **Group plugins**: Organize plugins into category folders (lsp/, ui/, editor/, etc.)
3. **Add keymaps file**: Create lua/config/keymaps.lua for general keybindings
4. **Clean up duplicates**: Choose between Telescope/fzf-lua/Snacks picker
5. **Choose file explorer**: Pick one between Neo-tree/mini.files/Snacks explorer
