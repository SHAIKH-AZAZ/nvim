# Hidden Files Guide - Why They're Not Showing

## 🔍 Understanding the Problem

Hidden files (files starting with `.`) might not show in neo-tree for several reasons:

### 1. **Neo-tree Settings**
Your config has `hide_dotfiles = false`, which means hidden files SHOULD show.

### 2. **Git Ignore**
If files are in `.gitignore`, they might be hidden by `hide_gitignored` setting.

### 3. **Neo-tree State**
Neo-tree remembers your toggle state. If you pressed `H` to hide files, they stay hidden.

### 4. **File System Permissions**
Some files might not be readable by Neovim.

---

## ✅ How to Show Hidden Files

### Method 1: Toggle in Neo-tree (Easiest)
1. Open neo-tree: `Ctrl+n`
2. Press `H` to toggle hidden files
3. Press `I` to toggle git-ignored files

### Method 2: Use Commands
```vim
:NeoTreeShowHidden     " Force refresh and show hidden
:ListHiddenFiles       " List all hidden files in directory
:NeoTreeDebug          " Check current settings
```

### Method 3: Restart Neo-tree
```vim
:Neotree close
:Neotree show
```

---

## 🐛 Diagnostic Commands

### Check What's Hidden
```vim
:NeoTreeDebug          " Shows current hide_dotfiles setting
:ListHiddenFiles       " Lists all hidden files in current dir
```

### Verify Files Exist
```bash
# In terminal
ls -la                 # List all files including hidden
ls -la | grep "^\."    # List only hidden files
```

---

## 📋 Current Configuration

Your neo-tree is configured to:

✅ **SHOW** these files:
- `.env` (all variants)
- `.gitignore`
- `.eslintrc.js`
- `.prettierrc`
- All other dotfiles

❌ **HIDE** these files:
- `.DS_Store`
- `thumbs.db`

### Settings:
```lua
hide_dotfiles = false      -- Show hidden files
hide_gitignored = false    -- Show git-ignored files
hide_hidden = false        -- Show hidden files
visible = true             -- Show filtered items (dimmed)
```

---

## 🎯 Common Issues & Solutions

### Issue 1: "I pressed H and now files are hidden"
**Solution:** Press `H` again to toggle them back

### Issue 2: ".env file not showing"
**Possible causes:**
1. File doesn't exist (check with `ls -la`)
2. Neo-tree state is cached
3. Git-ignored and `hide_gitignored = true`

**Solution:**
```vim
:NeoTreeShowHidden
```

### Issue 3: "Some hidden files show, others don't"
**Cause:** Files in `never_show` list or matching `never_show_by_pattern`

**Solution:** Check config in `lua/plugins/neo-tree.lua`

### Issue 4: "Hidden files show dimmed/grayed out"
**This is normal!** `visible = true` shows filtered items in gray.

**To hide them completely:**
```lua
visible = false  -- In neo-tree.lua
```

---

## 🔧 Manual Fix

If hidden files still don't show, edit `lua/plugins/neo-tree.lua`:

```lua
filesystem = {
  filtered_items = {
    hide_dotfiles = false,        -- Must be false
    hide_gitignored = false,      -- Must be false
    hide_hidden = false,          -- Must be false
    visible = true,               -- Show filtered items
    hide_by_name = {},            -- Empty = don't hide by name
    never_show = {},              -- Empty = don't hide anything
  },
}
```

Then restart Neovim.

---

## 📊 Test Your Setup

### 1. Create a test hidden file
```bash
cd your-project
touch .test-hidden-file
```

### 2. Open neo-tree
```vim
:Neotree show
```

### 3. Check if `.test-hidden-file` appears
- ✅ If YES: Config is working!
- ❌ If NO: Run `:NeoTreeDebug` and check settings

### 4. Toggle with H
- Press `H` in neo-tree
- File should disappear/reappear

---

## 🎨 Visual Indicators

In neo-tree, files appear with different colors:

- **White/Normal** - Regular files
- **Gray/Dimmed** - Filtered but visible files
- **Green** - New/added files (git)
- **Orange** - Modified files (git)
- **Red** - Deleted files (git)

---

## 💡 Pro Tips

### Always Show Specific Files
Add to `always_show` in config:
```lua
always_show = {
  ".env",
  ".gitignore",
  ".prettierrc",
  -- Add your files here
}
```

### Hide Specific Files
Add to `never_show` in config:
```lua
never_show = {
  ".DS_Store",
  "thumbs.db",
  -- Add files to hide
}
```

### Pattern Matching
```lua
always_show_by_pattern = {
  ".env*",        -- Show all .env files
}

never_show_by_pattern = {
  "*.log",        -- Hide all .log files
}
```

---

## 🆘 Still Not Working?

1. **Check file exists:**
   ```bash
   ls -la | grep .env
   ```

2. **Check permissions:**
   ```bash
   ls -l .env
   ```

3. **Check neo-tree state:**
   ```vim
   :NeoTreeDebug
   ```

4. **Force refresh:**
   ```vim
   :NeoTreeShowHidden
   ```

5. **Check git ignore:**
   ```bash
   git check-ignore .env
   ```
   If it returns the filename, it's git-ignored.

6. **Restart Neovim:**
   Sometimes a fresh start helps!

---

## 📚 Quick Reference

| Command | Description |
|---------|-------------|
| `H` (in neo-tree) | Toggle hidden files |
| `I` (in neo-tree) | Toggle git-ignored files |
| `:NeoTreeDebug` | Check settings |
| `:ListHiddenFiles` | List hidden files |
| `:NeoTreeShowHidden` | Force show hidden |
| `Ctrl+n` | Toggle neo-tree |

---

## ✨ Expected Behavior

After the fixes:

1. Open neo-tree: `Ctrl+n`
2. You should see:
   - `.env` files
   - `.gitignore`
   - `.eslintrc.js`
   - Other dotfiles
3. Press `H` to toggle them on/off
4. Press `I` to toggle git-ignored files

If this doesn't work, run `:NeoTreeDebug` and share the output!
