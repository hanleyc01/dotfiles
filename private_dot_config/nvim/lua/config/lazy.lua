--[[
-- Structured setup for `lazy.nvim`.
--
-- Created 09/26/2025
-- + added initialization script
-- + added plugins/colorscheme.lua, set to `tokyonight-night`
--]]

--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    -- Repository path.
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"

    -- Clone the repository into the path.
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath
    })

    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo(
            {
                { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
                { out, "WarningMsg" },
                { "\nPress any key to exit ..." },
            },
            true,
            {}
        )

        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before loading lazy.nvim so that
-- mappings are correct.
-- This is also a good place to setup other settings (vim.opt).
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.termguicolors = true
opt.background = "dark"

vim.g.python3_host_prog = vim.fn.expand("/home/connorh/.venvs/neovim/bin/python3")

-- relative line numbering
vim.wo.relativenumber = true


-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- Import your plugins
        { import = "plugins" },
    },

    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "tokyonight-night" } },

    -- Automatically check for plugin updates.
    checker = { enabled = true },
})
