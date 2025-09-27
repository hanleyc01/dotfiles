--[[
-- nvim lsp-config configuration file
-- created 09/27/2025
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
            vim.o.updatetime = 250
            vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
        end
    },
}
