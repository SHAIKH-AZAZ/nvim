# Neovim Configuration Guide

## 📁 File Structure

```
~/.config/nvim/
├── init.lua                    # Main entry point
├── lua/
│   ├── vim-options.lua         # Basic editor settings
│   ├── config/
│   │   ├── autocmds.lua        # Auto commands
│   │   └── keymaps.lua         # Key mappings
│   └── plugins/
│       ├── lsp-config.lua      # LSP server configuration
│       ├── blinkcmp.lua        # Completion engine
│       ├── telescope.lua       # Fuzzy finder
│       ├── neo-tree.lua        # File explorer
│       ├── treesitter.lua      # Syntax highlighting
│       └── ... (other plugins)
```

## 🚀 What Each File Does

### `init.lua` - Main Entry Point
- Bootstraps the Lazy.nvim plugin manager
- Loads basic vim settings
- Loads all plugins from `lua/plugins/`
- Loads custom autocommands

### `lua/vim-options.lua` - Basic Settings
- **Indentation**: 2 spaces, no tabs
- **Line numbers**: Absolute + relative
- **Colors**: 24-bit RGB support
- **Mouse**: Enabled in all modes
- **Search**: Case-insensitive by default
- **Splits**: Open right and below
- **Undo**: Persistent across sessions

### `lua/plugins/lsp-config.lua` - Language Servers
Configures LSP servers for code intelligence:

| Server | Language | Features |
|--------|----------|----------|
| `ts_ls` | JavaScript/TypeScript/React | Autocomplete, type checking, refactoring |
| `tailwindcss` | Tailwind CSS | Class autocomplete, color previews |
| `html` | HTML | Tag autocomplete, validation |
| `cssls` | CSS | Property autocomplete |
| `emmet_ls` | Emmet | Abbreviations (div>ul>li*3) |
| `lua_ls` | Lua | Neovim API support |
| `pyright` | Python | Type checking |

**LSP Keymaps:**
- `K` - Show documentation
- `gd` - Go to definition
- `gr` - Show references
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `<leader>th` - Toggle inlay hints

### `lua/plugins/blinkcmp.lua` - Completion Engine
Modern, fast completion powered by Rust.

**Features:**
- LSP-based autocomplete
- Snippet expansion (friendly-snippets)
- Emoji completion (`:smile:`)
- SQL completion
- Ghost text (inline suggestions)

**Keymaps:**
- `Enter` - Accept suggestion
- `Tab` - Accept + jump to next snippet field
- `Shift+Tab` - Jump back in snippet
- `Up/Down` or `Ctrl+n/p` - Navigate suggestions
- `Ctrl+Space` - Show/hide documentation
- `Ctrl+e` - Close menu
- `Ctrl+k` - Toggle signature help

### `lua/plugins/telescope.lua` - Fuzzy Finder
Fast file and text search.

**Keymaps:**
- `Ctrl+p` - Find files
- `<leader>fg` - Live grep (search in files)

### `lua/plugins/neo-tree.lua` - File Explorer
Visual file tree navigation.

**Keymaps:**
- `Ctrl+n` - Toggle file tree

### `lua/plugins/treesitter.lua` - Syntax Highlighting
Advanced syntax highlighting and code understanding.

**Features:**
- Better syntax highlighting
- Rainbow parentheses
- Incremental selection
- Smart indentation

### `lua/config/keymaps.lua` - Custom Keymaps
Additional keyboard shortcuts for navigation and editing.

**Key Features:**
- Better up/down movement (respects wrapped lines)
- Window navigation with `Ctrl+hjkl`
- Save file with `Ctrl+s`
- Better indenting in visual mode
- Tab management
- Diagnostic navigation

### `lua/config/autocmds.lua` - Auto Commands
Automatic actions triggered by events.

**Features:**
- Auto-reload files when changed externally
- Highlight yanked text
- Auto-resize splits on window resize
- Remember cursor position
- Close certain windows with `q`
- Enable spell check in text files
- Auto-create directories when saving

## 🎨 Theme
**Catppuccin** - Modern, pastel color scheme

## 📦 Plugin Manager
**Lazy.nvim** - Fast, modern plugin manager
- Run `:Lazy` to open the UI
- Automatically checks for updates

## 🔧 LSP Management
**Mason** - LSP server installer
- Run `:Mason` to install/manage servers
- Servers auto-install when you open files

## ⚡ Quick Start

### Install LSP Servers
```vim
:Mason
```
Then press `i` on servers you want to install.

### Update Plugins
```vim
:Lazy sync
```

### Check LSP Status
```vim
:LspInfo
```

### Toggle File Tree
```
Ctrl+n
```

### Find Files
```
Ctrl+p
```

### Search in Files
```
Space + fg
```

## 🐛 Troubleshooting

### Completion not working?
1. Check LSP is running: `:LspInfo`
2. Restart LSP: `:LspRestart`
3. Check Mason installed servers: `:Mason`

### Inlay hints not showing?
1. Press `Space + th` to toggle
2. Check Neovim version: `:version` (needs 0.10+)
3. Only works in TypeScript/JavaScript files

### Snippets not expanding?
1. Make sure you're in insert mode
2. Press `Tab` after typing snippet trigger
3. Check friendly-snippets is installed: `:Lazy`

## 📚 Learn More

- Neovim docs: `:help`
- LSP docs: `:help lsp`
- Lazy.nvim: `:help lazy.nvim`
- Telescope: `:help telescope`
- Treesitter: `:help treesitter`
