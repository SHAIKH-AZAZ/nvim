# Plugin Documentation

## 📦 All Plugins Explained

### Core Functionality

#### 🔧 LSP & Completion
- **lsp-config.lua** - Language servers (TypeScript, Python, Lua, HTML, CSS, Tailwind, Emmet)
- **blinkcmp.lua** - Fast completion engine with snippets
- **none-ls.lua** - Formatting (prettier, stylua) and linting (eslint, stylelint)

#### 🎨 UI & Appearance
- **catppuccin.lua** - Color scheme (4 flavors: Latte, Frappe, Macchiato, Mocha)
- **lualine.lua** - Statusline (shows mode, git, diagnostics, file info)
- **bufferline.lua** - Buffer tabs at the top
- **which-key.lua** - Keymap helper popup

#### 📁 File Management
- **neo-tree.lua** - File explorer (Ctrl+n)
- **telescope.lua** - Fuzzy finder for files and text

#### 🌳 Code Understanding
- **treesitter.lua** - Advanced syntax highlighting and code parsing
- **auto-pairs.lua** - Auto-close brackets and quotes

#### 🔀 Git Integration
- **gitsigns.lua** - Git changes in gutter, hunk navigation, blame

## 🎯 Quick Reference

### File Explorer (Neo-tree)
```
Ctrl+n          Toggle file tree
```

### Fuzzy Finder (Telescope)
```
Ctrl+p          Find files
<leader>fg      Search in files (live grep)
<leader>ff      Find files
<leader>fb      List buffers
<leader>fh      Search help docs
<leader>pr      Recent files
<leader>ths     Theme switcher
```

### LSP
```
K               Show documentation
gd              Go to definition
gr              Show references
<leader>ca      Code actions
<leader>rn      Rename symbol
<leader>th      Toggle inlay hints
<leader>gf      Format file
```

### Completion (Blink.cmp)
```
Enter           Accept suggestion
Tab             Accept + jump to next field
Shift+Tab       Jump back in snippet
Ctrl+Space      Show/hide docs
Ctrl+e          Close menu
Ctrl+n/p        Navigate suggestions
Up/Down         Navigate suggestions
```

### Git (Gitsigns)
```
]h              Next hunk
[h              Previous hunk
<leader>ghs     Stage hunk
<leader>ghr     Reset hunk
<leader>ghp     Preview hunk
<leader>ghb     Blame line
<leader>ghd     Diff file
```

### Buffers (Bufferline)
```
Shift+h         Previous buffer
Shift+l         Next buffer
[b / ]b         Previous/Next buffer
<leader>bp      Pin buffer
<leader>bo      Close other buffers
<leader>br      Close buffers to right
<leader>bl      Close buffers to left
```

### Which-key
```
<leader>?       Show buffer keymaps
<leader>        Wait to see all leader keymaps
```

## 🔍 What Each Plugin Does

### LSP Servers Installed
| Server | Language | What it does |
|--------|----------|--------------|
| ts_ls | JavaScript/TypeScript/React | Autocomplete, type checking, refactoring |
| tailwindcss | Tailwind CSS | Class autocomplete, color previews |
| html | HTML | Tag autocomplete, validation |
| cssls | CSS | Property autocomplete |
| emmet_ls | Emmet | Abbreviations (div>ul>li*3) |
| lua_ls | Lua | Neovim API support |
| pyright | Python | Type checking |

### Formatters & Linters
| Tool | Purpose |
|------|---------|
| prettier | Format JS/TS/CSS/HTML/JSON |
| stylua | Format Lua |
| eslint_d | Lint & fix JS/TS |
| stylelint | Lint CSS/SCSS/Tailwind |
| markdownlint | Lint Markdown |
| jsonlint | Validate JSON |

## 🎨 Treesitter Languages
Syntax highlighting for:
- Web: JavaScript, TypeScript, TSX, HTML, CSS, Svelte, GraphQL
- Backend: Python, Go, Java, Rust, C
- Config: JSON, YAML, TOML, Dockerfile
- Docs: Markdown
- Shell: Bash
- Neovim: Lua, Vim

## 💡 Tips

### Discover Keymaps
1. Press `<leader>` and wait - which-key shows all options
2. Press `<leader>?` to see buffer-specific keymaps
3. Press `s` to see all 's' keymaps

### Format on Save
Already configured! Files auto-format when you save.

### Git Workflow
1. Make changes
2. Press `]h` to jump to next change
3. Press `<leader>ghp` to preview
4. Press `<leader>ghs` to stage
5. Commit from terminal

### Theme Switching
Press `<leader>ths` to open theme switcher with live preview!

### Snippet Usage
1. Type snippet trigger (e.g., `for`, `if`, `func`)
2. Press `Tab` to expand
3. Press `Tab` to jump between fields
4. Press `Shift+Tab` to go back

## 🐛 Troubleshooting

### LSP not working?
```vim
:LspInfo          " Check LSP status
:LspRestart       " Restart LSP
:Mason            " Check installed servers
```

### Formatter not working?
```vim
:Mason            " Install prettier/stylua/eslint_d
<leader>gf        " Manual format
```

### Completion not showing?
1. Check LSP is running: `:LspInfo`
2. Check blink.cmp is loaded: `:Lazy`
3. Restart Neovim

### Git signs not showing?
Make sure you're in a git repository:
```bash
git status
```

## 📚 Learn More

Each plugin file now has detailed inline comments explaining:
- What it does
- How to configure it
- All available keymaps
- Common use cases

Open any file in `lua/plugins/` to see the documentation!
