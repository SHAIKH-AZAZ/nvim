# Keyboard Shortcuts Reference

## 🗂️ File Explorer (Neo-tree)

### Open/Close
```
Ctrl+n          Toggle neo-tree
<leader>e       Focus neo-tree
<leader>E       Reveal current file in tree
```

### Inside Neo-tree
```
H               Toggle hidden files (.dotfiles)
I               Toggle git-ignored files
a               Add file/folder
d               Delete file/folder
r               Rename
c               Copy
x               Cut
p               Paste
y               Copy filename
Y               Copy relative path
gy              Copy absolute path
?               Show all keymaps
q               Close neo-tree
```

---

## 🔍 Fuzzy Finder (Telescope)

```
Ctrl+p          Find files
<leader>ff      Find files
<leader>fg      Live grep (search in files)
<leader>fb      List buffers
<leader>fh      Search help docs
<leader>pr      Recent files
<leader>ft      Find TODOs
<leader>ths     Theme switcher
<leader>lg      Find word under cursor
```

### Inside Telescope
```
Ctrl+j/k        Navigate up/down
Ctrl+n/p        Navigate up/down
Enter           Select
Esc             Close
Ctrl+c          Close
```

---

## 📝 Buffer Management

```
<leader>bd      Close current buffer
<leader>bD      Force close buffer
Ctrl+q          Quick close buffer
<leader>bo      Close all OTHER buffers
<leader>br      Close buffers to RIGHT
<leader>bl      Close buffers to LEFT
<leader>bp      Pin/unpin buffer
<leader>bP      Close all unpinned buffers
Shift+h         Previous buffer
Shift+l         Next buffer
[b              Previous buffer
]b              Next buffer
```

---

## 💾 Save & Quit

```
<leader>w       Save file
<leader>q       Quit window
<leader>Q       Quit all
Ctrl+s          Save file (normal/insert mode)
:w              Save
:q              Quit
:wq             Save and quit
:qa             Quit all
```

---

## 🪟 Window Management

```
<leader>wc      Close current window
<leader>wo      Close all other windows
<leader>ws      Split horizontal
<leader>wv      Split vertical
Ctrl+h          Go to left window
Ctrl+j          Go to lower window
Ctrl+k          Go to upper window
Ctrl+l          Go to right window
```

---

## 🔧 LSP (Code Intelligence)

```
K               Show documentation / Peek fold
gd              Go to definition
gr              Show references
gi              Go to implementation
<leader>ca      Code actions
<leader>rn      Rename symbol
<leader>th      Toggle inlay hints
<leader>gf      Format file
<leader>e       Show diagnostic
]d              Next diagnostic
[d              Previous diagnostic
```

---

## ✨ Completion (Blink.cmp)

```
Enter           Accept suggestion
Tab             Accept + jump to next field
Shift+Tab       Jump back in snippet
Ctrl+Space      Show/hide docs
Ctrl+e          Close menu
Ctrl+n          Next suggestion
Ctrl+p          Previous suggestion
Up/Down         Navigate suggestions
```

---

## 🌳 Code Folding (UFO)

```
za              Toggle fold under cursor
zo              Open fold
zc              Close fold
zR              Open ALL folds
zM              Close ALL folds
zr              Open folds one level
zm              Close folds one level
zj              Next fold
zk              Previous fold
```

---

## 🔀 Git (Gitsigns)

```
]h              Next hunk (change)
[h              Previous hunk
]H              Last hunk
[H              First hunk
<leader>ghs     Stage hunk
<leader>ghr     Reset hunk
<leader>ghS     Stage buffer
<leader>ghR     Reset buffer
<leader>ghp     Preview hunk
<leader>ghb     Blame line
<leader>ghB     Blame buffer
<leader>ghd     Diff file
```

---

## 🚀 Navigation (Flash)

```
s               Flash jump (jump anywhere)
S               Flash treesitter (select by syntax)
```

---

## 📋 Editing

### Indenting
```
>               Indent right (visual mode)
<               Indent left (visual mode)
>>              Indent line right
<<              Indent line left
```

### Moving Lines
```
Alt+j           Move line down
Alt+k           Move line up
```

### Copy/Paste
```
y               Yank (copy)
yy              Yank line
p               Paste after
P               Paste before
d               Delete (cut)
dd              Delete line
```

### Visual Mode
```
v               Visual mode (character)
V               Visual line mode
Ctrl+v          Visual block mode
```

---

## 🔎 Search

```
/               Search forward
?               Search backward
n               Next match
N               Previous match
*               Search word under cursor
#               Search word under cursor (backward)
Esc             Clear search highlight
```

---

## 📌 TODO Comments

```
]t              Next TODO
[t              Previous TODO
<leader>ft      Find all TODOs
```

---

## 🎨 Which-key (Help)

```
<leader>        Wait to see all leader keymaps
<leader>?       Show buffer keymaps
<leader>b       Buffer commands
<leader>f       File/find commands
<leader>g       Git commands
<leader>w       Window commands
<leader>x       Diagnostics
```

---

## 🔧 Diagnostic Commands

```
:CheckPlugins       Check all plugins
:CheckLSP          Check LSP status
:CheckTreesitter   Check syntax highlighting
:CheckCompletion   Check autocomplete
:FixLineNumbers    Restore line numbers
:ConfigInfo        Show config info
:Lazy              Plugin manager
:Mason             LSP installer
:LspInfo           LSP status
:TSUpdate          Update Treesitter parsers
```

---

## 💡 Tips

### Discover More Keymaps
- Press `<leader>` and wait → which-key shows all options
- Press `?` in neo-tree → shows all file explorer commands
- Press `:map` → shows all keymaps

### Leader Key
- Leader = `Space`
- Example: `<leader>ff` = `Space` then `f` then `f`

### Quick Actions
- `<leader>w` → Save
- `<leader>q` → Quit
- `Ctrl+n` → File tree
- `Ctrl+p` → Find files
- `K` → Documentation
- `gd` → Go to definition

### Visual Mode Tricks
- Select text with `v`
- `>` to indent
- `<` to outdent
- `y` to copy
- `d` to delete
- `p` to paste

### Buffer Navigation
- `Shift+h` / `Shift+l` → Previous/Next buffer (easy!)
- `<leader>bd` → Close buffer
- `<leader>bo` → Close all others
