--[[
-- nvim treesitter
-- created 09/27/2025
--]]

return {
    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "markdown",
                    "markdown_inline",
                    "python",
                },
                highlight  = {
                    enable = true,
                    additional_vim_regex_highlight = false,
                },
            })
        end
    },
}
