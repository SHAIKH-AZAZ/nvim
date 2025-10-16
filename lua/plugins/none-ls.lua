
return {
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" },
        config = function()
            -- ✅ Use the new module name
            local null_ls = require("none-ls")

            -- ✅ Create a formatting group
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

            null_ls.setup({
                sources = {
                    -- =========================
                    -- Formatting
                    -- =========================
                    null_ls.builtins.formatting.prettier, -- JS, TS, JSX, CSS, Tailwind, HTML, JSON, Markdown
                    null_ls.builtins.formatting.stylua,   -- Lua

                    -- =========================
                    -- Diagnostics
                    -- =========================
                    require("none-ls.diagnostics.eslint_d"),   -- JS/TS linting (moved to none-ls-extras)
                    require("none-ls.diagnostics.stylelint"),  -- CSS/SCSS/Tailwind linting
                    require("none-ls.diagnostics.markdownlint"),
                    -- ❌ jsonlint removed — deprecated (use `jq` or `jsonls` LSP for JSON)

                    -- =========================
                    -- Code Actions
                    -- =========================
                    require("none-ls.code_actions.eslint_d"),  -- JS/TS fixable actions
                    null_ls.builtins.code_actions.gitsigns,    -- Git actions
                    null_ls.builtins.completion.spell,         -- Spell checking
                },

                -- =========================
                -- Autoformat on save
                -- =========================
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end
                end,
            })

            -- optional manual format keymap
            vim.keymap.set("n", "<leader>gf", function()
                vim.lsp.buf.format({ async = true })
            end, {})
        end,
    },
}

