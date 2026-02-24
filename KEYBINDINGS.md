# Neovim Keybindings Reference

> **Leader key** = `Space`
> Source: `~/.config/nvim/`

---

## Table of Contents

- [General](#general)
- [File Explorer (Neo-tree)](#file-explorer-neo-tree)
- [Buffers & Tabs](#buffers--tabs)
- [Windows](#windows)
- [Navigation](#navigation)
- [Search & Find (Snacks Picker)](#search--find-snacks-picker)
- [LSP (Language Server)](#lsp-language-server)
- [Git](#git)
- [Code Editing](#code-editing)
- [Diagnostics](#diagnostics)
- [Flash (Jump Navigation)](#flash-jump-navigation)
- [Surround (mini.surround)](#surround-minisurround)
- [UI Toggles](#ui-toggles)
- [Terminal](#terminal)
- [Themes](#themes)
- [Miscellaneous](#miscellaneous)

---

## General

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `Ctrl+s` | n, i | Save file | keymaps.lua |
| `Space Q` | n | Quit all | keymaps.lua |
| `Space f` | n, v | Format file (conform.nvim) | keymaps.lua |
| `Esc` | n | Clear search highlight | keymaps.lua |
| `p` | v | Paste without yanking | keymaps.lua |
| `:` | n | Open floating command line | cmdline.lua |
| `/` | n | Open floating search | cmdline.lua |
| `?` | n | Open floating reverse search | cmdline.lua |
| `Space ?` | n | Show buffer keymaps (which-key) | whichkey.lua |
| `Space N` | n | Neovim News | snacks.lua |

---

## File Explorer (Neo-tree)

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `Ctrl+n` | n | Toggle Neo-tree | neoTree.lua |
| `Space e` | n | Focus Neo-tree | neoTree.lua |
| `Space E` | n | Reveal current file in Neo-tree | neoTree.lua |
| `H` | (in tree) | Toggle hidden files | neoTree.lua |

---

## Buffers & Tabs

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `Space bd` | n | Delete buffer (smart) | snacks.lua |
| `Space bD` | n | Force close buffer | keymaps.lua |
| `Space bw` | n | Wipe buffer | keymaps.lua |
| `Ctrl+q` | n | Quick close buffer | keymaps.lua |
| `Space bp` | n | Toggle pin buffer | bufferline.lua |
| `Space bP` | n | Delete non-pinned buffers | bufferline.lua |
| `Space bo` | n | Delete other buffers | bufferline.lua |
| `Space br` | n | Delete buffers to the right | bufferline.lua |
| `Space bl` | n | Delete buffers to the left | bufferline.lua |
| `Shift+h` | n | Previous buffer | bufferline.lua |
| `Shift+l` | n | Next buffer | bufferline.lua |
| `[b` | n | Previous buffer | bufferline.lua |
| `]b` | n | Next buffer | bufferline.lua |
| `[B` | n | Move buffer left | bufferline.lua |
| `]B` | n | Move buffer right | bufferline.lua |
| `Space ,` | n | Open buffer picker | snacks.lua |
| `Space fb` | n | Find buffers | snacks.lua |

---

## Windows

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `Ctrl+h` | n | Go to left window | keymaps.lua |
| `Ctrl+j` | n | Go to lower window | keymaps.lua |
| `Ctrl+k` | n | Go to upper window | keymaps.lua |
| `Ctrl+l` | n | Go to right window | keymaps.lua |
| `Space wc` | n | Close window | keymaps.lua |
| `Space wo` | n | Close other windows | keymaps.lua |
| `Space ws` | n | Split horizontal | keymaps.lua |
| `Space wv` | n | Split vertical | keymaps.lua |
| `Space z` | n | Toggle Zen mode | snacks.lua |
| `Space Z` | n | Toggle Zoom | snacks.lua |
| `Ctrl+w Space` | n | Window hydra mode (repeat) | whichkey.lua |

---

## Navigation

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `Alt+j` | n | Move line down | keymaps.lua |
| `Alt+k` | n | Move line up | keymaps.lua |
| `Alt+j` | v | Move selected lines down | keymaps.lua |
| `Alt+k` | v | Move selected lines up | keymaps.lua |
| `<` | v | Indent left (stay in visual) | keymaps.lua |
| `>` | v | Indent right (stay in visual) | keymaps.lua |
| `]q` | n | Next quickfix item | keymaps.lua |
| `[q` | n | Previous quickfix item | keymaps.lua |
| `]]` | n, t | Next word reference | snacks.lua |
| `[[` | n, t | Previous word reference | snacks.lua |

---

## Search & Find (Snacks Picker)

### Quick Access

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `Space Space` | n | Smart find files | snacks.lua |
| `Ctrl+p` | n | Find files | snacks.lua |
| `Space /` | n | Grep (search text) | snacks.lua |
| `Space ,` | n | Switch buffers | snacks.lua |
| `Space :` | n | Command history | snacks.lua |

### Find (`Space f`)

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `Space fb` | n | Find buffers | snacks.lua |
| `Space fc` | n | Find config file | snacks.lua |
| `Space fp` | n | Find projects | snacks.lua |
| `Space fr` | n | Find recent files | snacks.lua |

### Search (`Space s`)

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `Space sb` | n | Buffer lines | snacks.lua |
| `Space sB` | n | Grep open buffers | snacks.lua |
| `Space sg` | n | Grep | snacks.lua |
| `Space sw` | n, x | Grep word/selection | snacks.lua |
| `Space s"` | n | Registers | snacks.lua |
| `Space s/` | n | Search history | snacks.lua |
| `Space sa` | n | Autocmds | snacks.lua |
| `Space sc` | n | Command history | snacks.lua |
| `Space sC` | n | Commands | snacks.lua |
| `Space sd` | n | Diagnostics (all) | snacks.lua |
| `Space sD` | n | Buffer diagnostics | snacks.lua |
| `Space sh` | n | Help pages | snacks.lua |
| `Space sH` | n | Highlights | snacks.lua |
| `Space si` | n | Icons | snacks.lua |
| `Space sj` | n | Jumps | snacks.lua |
| `Space sk` | n | Keymaps | snacks.lua |
| `Space sl` | n | Location list | snacks.lua |
| `Space sm` | n | Marks | snacks.lua |
| `Space sM` | n | Man pages | snacks.lua |
| `Space sp` | n | Plugin specs | snacks.lua |
| `Space sq` | n | Quickfix list | snacks.lua |
| `Space sR` | n | Resume last search | snacks.lua |
| `Space ss` | n | LSP symbols | snacks.lua |
| `Space sS` | n | LSP workspace symbols | snacks.lua |
| `Space su` | n | Undo history | snacks.lua |

---

## LSP (Language Server)

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `gd` | n | Go to definition | snacks.lua |
| `gD` | n | Go to declaration | snacks.lua |
| `gI` | n | Go to implementation | snacks.lua |
| `gy` | n | Go to type definition | snacks.lua |
| `gr` | n | Show references | lsp.lua |
| `K` | n | Hover documentation | lsp.lua |
| `Space ca` | n | Code action | lsp.lua |
| `Space rn` | n | Rename symbol | lsp.lua |
| `Space cR` | n | Rename file | snacks.lua |

---

## Git

### Snacks Git (`Space g`)

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `Space gg` | n | Open Lazygit | snacks.lua |
| `Space gb` | n | Git branches | snacks.lua |
| `Space gl` | n | Git log | snacks.lua |
| `Space gL` | n | Git log (line) | snacks.lua |
| `Space gs` | n | Git status | snacks.lua |
| `Space gS` | n | Git stash | snacks.lua |
| `Space gd` | n | Git diff (hunks) | snacks.lua |
| `Space gf` | n | Git log (file) | snacks.lua |
| `Space gB` | n, v | Git browse (open in browser) | snacks.lua |

### Gitsigns (`Space h`)

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `]h` | n | Next git hunk | gitsigns.lua |
| `[h` | n | Previous git hunk | gitsigns.lua |
| `Space hs` | n, v | Stage hunk | gitsigns.lua |
| `Space hr` | n, v | Reset hunk | gitsigns.lua |
| `Space hS` | n | Stage buffer | gitsigns.lua |
| `Space hu` | n | Undo stage hunk | gitsigns.lua |
| `Space hR` | n | Reset buffer | gitsigns.lua |
| `Space hp` | n | Preview hunk | gitsigns.lua |
| `Space hb` | n | Blame line (full) | gitsigns.lua |
| `Space hB` | n | Toggle line blame | gitsigns.lua |
| `Space hd` | n | Diff against index | gitsigns.lua |
| `Space hD` | n | Diff against HEAD~ | gitsigns.lua |
| `ih` | o, x | Select git hunk (text object) | gitsigns.lua |
| `Space htl` | n | Toggle line highlight | gitsigns.lua |
| `Space htn` | n | Toggle number highlight | gitsigns.lua |
| `Space htw` | n | Toggle word diff | gitsigns.lua |

---

## Code Editing

### Formatting

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `Space f` | n, v | Format file/selection | keymaps.lua |
| `Space ll` | n | Trigger linting | nvim-lint.lua |
| `Space cw` | n | Trim trailing whitespace | mini.lua |

### Split/Join

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `sj` | n, x | Join arguments (one line) | mini.lua |
| `sk` | n, x | Split arguments (multi-line) | mini.lua |

---

## Diagnostics

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `]d` | n | Next diagnostic | keymaps.lua |
| `[d` | n | Previous diagnostic | keymaps.lua |
| `Space de` | n | Show diagnostic float | keymaps.lua |
| `dgl` | n | Open diagnostic float | autocmd.lua |
| `Space sd` | n | Search all diagnostics | snacks.lua |
| `Space sD` | n | Search buffer diagnostics | snacks.lua |

---

## Flash (Jump Navigation)

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `s` | n, x, o | Flash jump (type to jump anywhere) | flash.lua |
| `S` | n, x, o | Flash treesitter (select by syntax) | flash.lua |
| `r` | o | Remote flash (operator pending) | flash.lua |
| `R` | o, x | Treesitter search | flash.lua |
| `Ctrl+s` | c | Toggle flash in search mode | flash.lua |

---

## Surround (mini.surround)

| Key | Mode | Action | Example |
|-----|------|--------|---------|
| `sa` | n, v | **Add** surrounding | `saiw"` → wrap word in `"` |
| `ds` | n | **Delete** surrounding | `ds"` → remove `"` |
| `sr` | n | **Replace** surrounding | `sr"'` → change `"` to `'` |
| `sf` | n | **Find** surrounding (right) | |
| `sF` | n | **Find** surrounding (left) | |
| `sh` | n | **Highlight** surrounding | |
| `sn` | n | Update `n_lines` search range | |

---

## UI Toggles (`Space u`)

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `Space us` | n | Toggle spelling | snacks.lua |
| `Space uw` | n | Toggle word wrap | snacks.lua |
| `Space uL` | n | Toggle relative numbers | snacks.lua |
| `Space ud` | n | Toggle diagnostics | snacks.lua |
| `Space ul` | n | Toggle line numbers | snacks.lua |
| `Space uc` | n | Toggle conceal level | snacks.lua |
| `Space uT` | n | Toggle treesitter | snacks.lua |
| `Space ub` | n | Toggle dark background | snacks.lua |
| `Space uh` | n | Toggle inlay hints | snacks.lua |
| `Space ug` | n | Toggle indent guides | snacks.lua |
| `Space uD` | n | Toggle dim mode | snacks.lua |
| `Space uC` | n | Colorscheme picker | snacks.lua |
| `Space un` | n | Dismiss all notifications | snacks.lua |

---

## Terminal

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `Ctrl+/` | n | Toggle terminal | snacks.lua |

---

## Themes

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `Space ths` | n | Theme switcher (live preview) | telescope.lua |
| `Space uC` | n | Colorscheme picker | snacks.lua |

---

## Miscellaneous

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `Space .` | n | Toggle scratch buffer | snacks.lua |
| `Space S` | n | Select scratch buffer | snacks.lua |
| `Space n` | n | Notification history | snacks.lua |

---

## Which-Key Groups

Press `Space` and wait to see all available groups:

| Prefix | Group |
|--------|-------|
| `Space b` | **buffer** — Buffer operations |
| `Space c` | **code** — Code actions |
| `Space d` | **debug** — Debugging |
| `Space f` | **file/find** — File operations |
| `Space g` | **git** — Git operations |
| `Space gh` | **hunks** — Git hunks |
| `Space h` | **gitsigns** — Git signs |
| `Space q` | **quit/session** — Quit/session |
| `Space s` | **search** — Search operations |
| `Space u` | **ui** — UI toggles |
| `Space x` | **diagnostics/quickfix** — Diagnostics |
| `Space w` | **windows** — Window management |
| `[` | **prev** — Previous navigation |
| `]` | **next** — Next navigation |
| `g` | **goto** — Go to commands |
| `gs` | **surround** — Surround operations |
| `z` | **fold** — Folding commands |

---

## Mode Legend

| Abbrev | Mode |
|--------|------|
| `n` | Normal |
| `i` | Insert |
| `v` | Visual |
| `x` | Visual (charwise) |
| `o` | Operator-pending |
| `c` | Command-line |
| `t` | Terminal |

---

*Generated on 2026-02-24. Run `Space sk` in Neovim to search all keymaps interactively.*
