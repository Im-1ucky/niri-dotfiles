return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                pyright = {
                    settings = {
                        python = {
                            analysis = {
                                typeCheckingMode = "basic", -- or "strict"
                                autoSearchPaths = true,
                                useLibraryCodeForTypes = true,
                            },
                        },
                    },
                },
                ruff_lsp = {},
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                python = { "ruff_format", "isort" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            }
        },
    },
    {
        "mfussenegger/nvim-dap-python",
        config = function()
            require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
        end,
    },
    {
        "linux-cultist/venv-selector.nvim",
        dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
        opts = {},
        keys = {
            { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
        },
    },
}
