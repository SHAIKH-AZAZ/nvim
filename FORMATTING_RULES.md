# Auto-Formatting Rules

## 🎯 What Gets Formatted

Auto-formatting is **enabled** for:
- ✅ Regular code files (`.js`, `.ts`, `.lua`, `.py`, etc.)
- ✅ Configuration files without dots (e.g., `config.json`)
- ✅ Files tracked by git

## 🚫 What Doesn't Get Formatted

Auto-formatting is **disabled** for:

### 1. Dotfiles (Files starting with `.`)
- ❌ `.env` (all variants)
- ❌ `.gitignore`
- ❌ `.dockerignore`
- ❌ `.npmrc`
- ❌ `.yarnrc`
- ❌ `.eslintrc.js`
- ❌ `.prettierrc`
- ❌ Any file starting with `.`

### 2. Git-Ignored Files
- ❌ Files listed in `.gitignore`
- ❌ Files ignored by git

### 3. Lock Files
- ❌ `package-lock.json`
- ❌ `yarn.lock`
- ❌ `pnpm-lock.yaml`

---

## 🔧 How It Works

### Conform.nvim (Primary Formatter)
- Checks filename before formatting
- Skips dotfiles automatically
- Checks git ignore status
- Shows warning if formatting is disabled

### None-ls (Secondary Formatter)
- Same exclusion rules
- Disables formatting capability for excluded files
- Works with LSP format command

---

## 💡 Manual Formatting

### Format Allowed Files
```vim
<leader>lf          " Format with conform
<leader>gf          " Format with LSP/none-ls
```

### Force Format (Override Exclusions)
If you really need to format a dotfile:

```vim
:lua require("conform").format({ force = true })
```

Or use external tool:
```bash
prettier --write .prettierrc
```

---

## 🎨 Formatters Used

| File Type | Formatter |
|-----------|-----------|
| JavaScript/TypeScript | prettier |
| React (JSX/TSX) | prettier |
| HTML/CSS | prettier |
| JSON | prettier |
| YAML | prettier |
| Markdown | prettier |
| Lua | stylua |
| Python | isort + black |
| Shell (sh/bash/zsh) | shfmt |

---

## ⚙️ Configuration

### Add More Exclusions

Edit `lua/plugins/conform.lua` and add to `excluded_files`:

```lua
local excluded_files = {
  ".env",
  ".gitignore",
  "your-file-here",  -- Add your file
}
```

### Exclude by Pattern

Add pattern matching:

```lua
-- Don't format if filename matches pattern
if basename:match("%.config$") then
  return false
end
```

### Exclude Specific Directories

```lua
-- Don't format files in node_modules
if filename:match("node_modules") then
  return false
end
```

---

## 🐛 Troubleshooting

### "My dotfile is being formatted"
1. Check if it's actually a dotfile (starts with `.`)
2. Restart Neovim to reload config
3. Check `:messages` for errors

### "Regular file is not being formatted"
1. Check if file type is supported
2. Check if formatter is installed: `:Mason`
3. Try manual format: `<leader>lf`

### "Git-ignored file is being formatted"
1. Make sure file is in `.gitignore`
2. Test: `git check-ignore filename`
3. Restart Neovim

### "Format on save not working"
1. Check if conform is loaded: `:Lazy`
2. Check for errors: `:messages`
3. Try manual format: `<leader>lf`

---

## 📋 Quick Reference

### Check if File Will Be Formatted

```vim
" In the file you want to check
:lua print(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t"))
```

If it starts with `.`, it won't be formatted.

### Test Git Ignore

```bash
git check-ignore filename
```

If it returns the filename, it's ignored and won't be formatted.

---

## 🎯 Examples

### Will Format ✅
```
src/index.js
components/Button.tsx
config.json
README.md
main.py
```

### Won't Format ❌
```
.env
.env.local
.gitignore
.prettierrc
package-lock.json
node_modules/anything.js
```

---

## 🔄 Disable Auto-Format Completely

If you want to disable auto-format on save:

### Option 1: Disable in Conform
Edit `lua/plugins/conform.lua`:

```lua
format_on_save = nil,  -- Disable auto-format
```

### Option 2: Disable for Current Session
```vim
:lua vim.g.disable_autoformat = true
```

### Option 3: Disable for Specific Buffer
```vim
:lua vim.b.disable_autoformat = true
```

---

## 💾 Save Without Formatting

### Temporary (One Time)
```vim
:noautocmd w
```

### Permanent (Disable Auto-Format)
```vim
:lua vim.g.disable_autoformat = true
:w
```

---

## 📚 Related Commands

```vim
:ConformInfo           " Show conform status
:Mason                 " Install formatters
:Lazy                  " Check plugin status
:messages              " View error messages
```

---

## ✨ Summary

**Auto-formatting is smart:**
- ✅ Formats your code files
- ❌ Skips dotfiles and config files
- ❌ Skips git-ignored files
- ⚠️ Shows warning when disabled

**Manual formatting always works:**
- Use `<leader>lf` to format manually
- Works even on excluded files (with warning)

**Customize as needed:**
- Edit `lua/plugins/conform.lua`
- Add files to `excluded_files` list
- Restart Neovim
