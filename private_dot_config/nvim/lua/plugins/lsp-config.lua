--[[
-- nvim lsp-config configuration file
-- created 09/27/2025
-- + added mason & lspconfig; former for lsp management, and latter for easy setup
--
-- 09/28/2025
-- + adding code completion
--]]

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

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
                "rust_analyzer",
                "clangd",
            },
        },
    },

    -- nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("basedpyright")
            vim.lsp.enable("ts_ls")
            vim.lsp.enable("rust_analyzer")
            vim.lsp.enable("clangd")

            -- Show line diagnostics automatically in hover window
            vim.o.updatetime = 1000
            vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
        end
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
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<CR>"] = cmp.mapping({
                        i = function(fallback)
                            if cmp.visible() and cmp.get_active_entry() then
                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                            else
                                fallback()
                            end
                        end,
                        s = cmp.mapping.confirm({ select = true }),
                        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                    }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({ select = true })
                            else
                                cmp.select_next_item()
                            end
                        elseif has_words_before() then
                            cmp.complte()
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({ select == true })
                            end
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
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

