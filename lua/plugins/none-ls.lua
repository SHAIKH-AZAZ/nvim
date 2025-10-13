
return {
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    -- =========================
                    -- Formatting
                    -- =========================
                    null_ls.builtins.formatting.prettier, -- JS, TS, JSX, CSS, Tailwind, HTML, JSON, Markdown
                    null_ls.builtins.formatting.stylua, -- Lua
                    null_ls.builtins.formatting.eslint_d, -- JS/TS autofix

                    -- =========================
                    -- Diagnostics
                    -- =========================
                    null_ls.builtins.diagnostics.eslint_d, -- JS/TS linting
                    null_ls.builtins.diagnostics.stylelint, -- CSS/SCSS/Tailwind linting
                    null_ls.builtins.diagnostics.markdownlint, -- Markdown linting
                    null_ls.builtins.diagnostics.jsonlint, -- JSON linting

                    -- =========================
                    -- Code Actions
                    -- =========================
                    null_ls.builtins.code_actions.eslint_d, -- JS/TS fixable actions
                    null_ls.builtins.code_actions.gitsigns, -- Git actions (optional)
                    null_ls.builtins.completion.spell, -- Spell checking
                },

                -- =========================
                -- Autoformat on save
                -- =========================
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = 0, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = 0,
                            buffer = bufnr,
                            callback = function()
                                -- modern replacement for formatting_sync
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

    {
        "nvimtools/none-ls-extras.nvim", -- required for eslint diagnostics
    },
}

