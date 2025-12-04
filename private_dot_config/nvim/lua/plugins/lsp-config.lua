--[[
-- nvim lsp-config configuration file
-- created 09/27/2025
-- + added mason & lspconfig; former for lsp management, and latter for easy setup
--
-- 09/28/2025
-- + adding code completion
--
-- 09/30/2025
-- + added type hints inline
-- + added texlab
--]]


return {
    -- mason.nvim
    {
        "mason-org/mason.nvim",
        opts = {},
    },

    -- mason-lspconfig
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",
                "basedpyright",
                "ts_ls",
                "clangd",
            },
        },
    },

    {
        "mrcjkb/rustaceanvim",
        version = "^6",
        lazy = false,
    },

    -- Inline type hints
    {
        "chrisgrieser/nvim-lsp-endhints",
        event = "LspAttach",
        opts = {},
    },

    -- nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("basedpyright")

            -- based pyright settings
            local basedpyright_config = {
                analysis = {
                diagnosticMode = "openFilesOnly",
                inlayHints = {
                  callArgumentNames = true
                }
              }
            }
            vim.lsp.config("basedpyright", basedpyright_config)

            vim.lsp.enable("ts_ls")
            vim.lsp.enable("clangd")
            vim.lsp.enable("texlab")

            -- Show line diagnostics automatically in hover window
            vim.o.updatetime = 1000
            vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
        end,
    },

    -- code completion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        opts = function()
            vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
            vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

            local cmp = require("cmp")
            local defaults = require("cmp.config.default")()
            local auto_select = true
            return {
                auto_brackets = {
                    -- add filetypes with auto-brackets here
                    "rust",
                    "lua",
                },
                completion = {
                    completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
                },
                preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
                mapping = cmp.mapping.preset.insert({
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm({
                      behavior = cmp.ConfirmBehavior.Insert,
                      select = true,
                    })
                }),
                sources = cmp.config.sources(
                    {
                        { name = "nvim_lsp" },
                        { name = "path" },
                    },
                    {
                        { name = "buffer" },
                    }
                ),
                sorting = defaults.sorting,
            }
        end
    },
}

