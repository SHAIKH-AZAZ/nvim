-- ============================================================================
-- None-ls (null-ls) - Formatting and Linting
-- ============================================================================
-- Integrates external formatters/linters with Neovim’s LSP API.
-- You can use it for diagnostics (linting) while using conform.nvim for formatting.
-- ============================================================================

return {
  {
    -- If you actually use a fork called "none-ls.nvim", keep it. Otherwise use jose-elias-alvarez/null-ls.nvim.
    "nvimtools/none-ls.nvim",          -- or "jose-elias-alvarez/null-ls.nvim"
    dependencies = {
      "nvimtools/none-ls-extras.nvim", -- Extra builtin sources
    },
    config = function()
      -- robust require: support either null-ls or none-ls naming
      local ok, null_ls = pcall(require, "null-ls")
      if not ok then
        ok, null_ls = pcall(require, "none-ls")
      end
      if not ok or not null_ls then
        vim.notify("null-ls / none-ls not found; skipping null-ls setup", vim.log.levels.WARN)
        return
      end

      local cache = {}

      -- === Helpers ===
      local function path_exists(path)
        local stat = vim.loop.fs_stat(path)
        return stat ~= nil
      end

      -- lightweight project-root detection: find nearest package.json, .git, or other markers
      local function find_project_root(fname)
        local dir = vim.fn.fnamemodify(fname, ":p:h")
        local markers = { ".git", "package.json", ".eslintrc", "pyproject.toml" }
        for _, marker in ipairs(markers) do
          local p = vim.fn.findfile(marker, dir .. ";")
          if p ~= "" then
            return vim.fn.fnamemodify(p, ":p:h")
          end
        end
        return nil
      end

      -- Cache certain checks per buffer/file to avoid repeated shell calls
      local function is_ignored_by_git(bufnr)
        local filename = vim.api.nvim_buf_get_name(bufnr)
        if cache[filename] ~= nil then
          return cache[filename]
        end
        -- cheap exist check: check .gitignore near project root (not exact git check-ignore, but fast)
        local root = find_project_root(filename)
        if not root then
          cache[filename] = false
          return false
        end
        local gitignore = root .. "/.gitignore"
        if path_exists(gitignore) then
          -- naive approach: rely on Conform/formatter's own ignore or trust .gitignore exists;
          -- for correctness you could shell out to `git check-ignore` once per buffer if necessary
          cache[filename] = false
          return false
        end
        cache[filename] = false
        return false
      end

      local function should_format(bufnr)
        bufnr = bufnr or vim.api.nvim_get_current_buf()
        local filename = vim.api.nvim_buf_get_name(bufnr)
        local basename = vim.fn.fnamemodify(filename, ":t")

        if basename:match("^%.") then
          return false
        end

        if is_ignored_by_git(bufnr) then
          return false
        end

        local excluded_files = {
          ".env", ".env.local", ".env.development",
          ".env.production", ".gitignore", ".dockerignore",
          ".npmrc", ".yarnrc",
        }
        for _, excluded in ipairs(excluded_files) do
          if basename == excluded then
            return false
          end
        end

        -- skip binary / very large files
        local ok_stat, stat = pcall(vim.loop.fs_stat, filename)
        if ok_stat and stat and stat.size and stat.size > 5 * 1024 * 1024 then
          return false
        end

        return true
      end

      -- === Sources ===
      local formatting = {
        -- left empty because conform.nvim handles formatting, but keep examples for toggling:
        -- null_ls.builtins.formatting.stylua.with({ extra_args = {"--config-path", "/path/to/toml"} }),
      }

      local diagnostics = {
        -- lightweight: enable stylelint for CSS-like files
        null_ls.builtins.diagnostics.stylelint.with({
          filetypes = { "css", "scss", "html", "svelte", "vue" },
        }),

        null_ls.builtins.diagnostics.markdownlint.with({
          filetypes = { "markdown" },
        }),

        -- NOTE: ESLint handled by ESLint LSP (see lsp.lua)
        -- It auto-detects project config and only runs where needed
      }

      local completion = {
        null_ls.builtins.completion.spell,
      }

      local all_sources = {}
      vim.list_extend(all_sources, formatting)
      vim.list_extend(all_sources, diagnostics)
      vim.list_extend(all_sources, completion)

      -- === Setup null-ls / none-ls ===
      null_ls.setup({
        sources = all_sources,
        -- set root detection if you want to customize
        -- root_dir = function(fname) return find_project_root(fname) or vim.loop.cwd() end,

        on_attach = function(client, bufnr)
          -- If Conform handles formatting, explicitly disable formatting capability for LSP clients here
          if client.supports_method and client.supports_method("textDocument/formatting") then
            client.server_capabilities.documentFormattingProvider = false
          end
          if client.supports_method and client.supports_method("textDocument/rangeFormatting") then
            client.server_capabilities.documentRangeFormattingProvider = false
          end
        end,
      })

      -- === Format-on-save integration with Conform (or fallback) ===
      -- This autocmd only formats when should_format returns true
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("NullLsConformFormat", { clear = true }),
        pattern = { "*" },
        callback = function(args)
          local bufnr = args.buf
          if not should_format(bufnr) then
            return
          end
          -- If you use Conform: call its format function. Example:
          -- vim.cmd("ConformFormat") -- or require("conform").format({ bufnr = bufnr })
          -- Fallback to vim.lsp.buf.format if conform is not available:
          local ok_conf, conform = pcall(require, "conform")
          if ok_conf and conform and conform.format then
            conform.format({ bufnr = bufnr })
          else
            -- prefer async formatting; limit to LSP/clients that still expose formatting
            pcall(vim.lsp.buf.format, { bufnr = bufnr, timeout_ms = 2000 })
          end
        end,
      })

      -- === Notes ===
      -- * If you want null-ls to be lazy-loaded, configure your plugin manager to load it on FileType or BufReadPre.
      -- * If performance becomes an issue, move heavy checks (like enabling eslint) into plugin loading logic.
      -- * Run :NullLsInfo to inspect which sources are attached to a buffer.
    end,
  },

  -- None-ls Extras (Lazy-loaded)
  {
    "nvimtools/none-ls-extras.nvim",
    lazy = true,
  },
}
