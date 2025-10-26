# Troubleshooting Guide

## 🐛 Common Issues & Fixes

### Line Numbers Disappearing

**Symptoms:**
- Line numbers vanish in some buffers
- Numbers don't show after opening certain files

**Fixes:**
1. **Quick Fix:** Run `:FixLineNumbers`
2. **Permanent Fix:** Already applied - autocmd forces line numbers in normal buffers
3. **Manual:** `:set number relativenumber`

**Why it happens:**
- Some plugins (neo-tree, telescope) hide line numbers
- Special buffers (help, quickfix) don't need them
- The fix ensures normal code files always show numbers

---

### Extensions Not Working

**Check Status:**
```vim
:CheckPlugins       " Check all plugins
:CheckLSP          " Check LSP servers
:CheckTreesitter   " Check syntax highlighting
:CheckCompletion   " Check autocomplete
```

**Common Issues:**

#### 1. LSP Not Working
```vim
:LspInfo           " Check LSP status
:LspRestart        " Restart LSP
:Mason             " Install missing servers
```

**Fix:**
- Make sure you're in a project with the right file type
- Check if server is installed: `:Mason`
- Restart Neovim

#### 2. Completion Not Showing
```vim
:CheckCompletion   " Verify blink.cmp is loaded
```

**Fix:**
- Press `Ctrl+Space` to manually trigger
- Check LSP is running: `:LspInfo`
- Restart Neovim

#### 3. Treesitter Not Highlighting
```vim
:CheckTreesitter   " Check parser status
:TSUpdate          " Update parsers
:TSInstall <lang>  " Install specific parser
```

**Fix:**
- Install parser: `:TSInstall javascript`
- Update all: `:TSUpdate`
- Check installed: `:TSInstallInfo`

#### 4. Git Signs Not Showing
**Requirements:**
- Must be in a git repository
- Run `git status` to verify

**Fix:**
```bash
cd your-project
git init  # If not a git repo
```

---

### Folding Not Working

**Check:**
```vim
:CheckPlugins      " Verify UFO is loaded
```

**Keymaps:**
- `za` - Toggle fold
- `zR` - Open all folds
- `zM` - Close all folds

**Fix:**
- Make sure UFO plugin is installed: `:Lazy`
- Treesitter must be working: `:CheckTreesitter`

---

### Diagnostics Showing 3 Times

**Already Fixed!**
- Duplicate filter added to tiny-inline-diagnostic
- Should only show once now

**If still happening:**
```vim
:lua vim.diagnostic.reset()  " Reset diagnostics
:LspRestart                  " Restart LSP
```

---

## 🔧 Diagnostic Commands

### Quick Health Checks
```vim
:checkhealth              " Neovim health check
:ConfigInfo              " Show config info
:CheckPlugins            " Check all plugins
:CheckLSP                " Check LSP status
:CheckTreesitter         " Check Treesitter
:CheckCompletion         " Check completion
:FixLineNumbers          " Restore line numbers
```

### Plugin Management
```vim
:Lazy                    " Plugin manager UI
:Lazy sync               " Update all plugins
:Lazy clean              " Remove unused plugins
:Lazy profile            " Check startup time
```

### LSP Management
```vim
:Mason                   " LSP installer UI
:LspInfo                 " Show LSP status
:LspRestart              " Restart LSP
:LspLog                  " View LSP logs
```

### Treesitter
```vim
:TSUpdate                " Update all parsers
:TSInstall <lang>        " Install parser
:TSInstallInfo           " Show installed parsers
:TSModuleInfo            " Show module status
```

---

## 🚀 Performance Issues

### Slow Startup
```vim
:Lazy profile            " Check plugin load times
```

**Fix:**
- Disable unused plugins in `lua/plugins/`
- Use `event = "VeryLazy"` for non-essential plugins

### Slow Typing
**Causes:**
- Too many LSP servers running
- Treesitter parsing large files
- Diagnostics updating too frequently

**Fix:**
```lua
-- In vim-options.lua (already set)
vim.opt.updatetime = 250  -- Increase if still slow
```

### High Memory Usage
```vim
:LspRestart              " Restart LSP servers
:TSBufDisable highlight  " Disable Treesitter temporarily
```

---

## 📝 Configuration Files

### Main Files
- `init.lua` - Entry point
- `lua/vim-options.lua` - Basic settings
- `lua/config/keymaps.lua` - Keyboard shortcuts
- `lua/core/autocmd.lua` - Auto commands

### Plugin Files
- `lua/plugins/*.lua` - Individual plugin configs
- Each file is auto-loaded by Lazy.nvim

### Logs
- Neovim log: `:echo stdpath('log')`
- LSP log: `:LspLog`
- Lazy log: `:Lazy log`

---

## 🆘 Emergency Reset

### If Everything Breaks

1. **Backup current config:**
```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

2. **Start fresh:**
```bash
git clone <your-repo> ~/.config/nvim
nvim
```

3. **Let Lazy install plugins:**
- Wait for installation to complete
- Restart Neovim

4. **Install LSP servers:**
```vim
:Mason
```
Press `i` on servers you need

---

## 💡 Tips

### Check What's Loaded
```vim
:lua print(vim.inspect(package.loaded))  " All loaded modules
:Lazy                                     " Plugin status
```

### Reload Config Without Restart
```vim
:source %                " Reload current file
:luafile %              " Reload Lua file
```

### View Keymaps
```vim
<leader>?               " Show buffer keymaps (which-key)
:map                    " Show all keymaps
:nmap                   " Show normal mode keymaps
```

### Debug Plugin
```vim
:Lazy load <plugin>     " Force load plugin
:Lazy reload <plugin>   " Reload plugin
```

---

## 📞 Still Having Issues?

1. Run `:checkhealth` - Shows all issues
2. Run `:ConfigInfo` - Shows config details
3. Check `:messages` - Recent error messages
4. Check `:Lazy log` - Plugin installation logs
5. Check `:LspLog` - LSP server logs

### Common Error Messages

**"module not found"**
- Plugin not installed: `:Lazy sync`

**"LSP not attached"**
- Server not installed: `:Mason`
- Wrong file type: Check `:set filetype?`

**"Treesitter parser not found"**
- Install parser: `:TSInstall <language>`

**"No completion"**
- Check LSP: `:LspInfo`
- Check blink.cmp: `:CheckCompletion`
