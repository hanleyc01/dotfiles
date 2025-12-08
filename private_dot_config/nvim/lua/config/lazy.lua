--[[
-- Structured setup for `lazy.nvim`.
--
-- Created 09/26/2025
-- + added initialization script
-- + added plugins/colorscheme.lua, set to `tokyonight-night`
--
-- Update 09/27/2025
-- + added python3 vim, see: "/home/connorh/.venvs/neovim/bin/python3" for more details;
--   on pull to new computer, make sure to reinitialize the venv
--
-- Update 12/05/2025
-- + added support for autoformatting rust files, as well as reading `*.h` files as c header files
--
-- Update 12/08/2025
-- + autoformatting and import sorting for python files using ruff
--]]

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
		lazypath,
	})

	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit ..." },
		}, true, {})

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
-- code completion
vim.cmd([[set completeopt+=menuone,noselect,popup]])

vim.g.python3_host_prog =
	vim.fn.expand("/home/connorh/.venvs/neovim/bin/python3")

-- relative line numbering
vim.wo.relativenumber = true

-- this is annoying: changing `.h` to be c rather than cpp
-- not sure why it would ever be cpp, the proper header extension
-- for cpp is `.hh` or `.hpp`.
vim.api.nvim_create_autocmd("BufRead", {
	pattern = { "*.h" },
	callback = function()
		vim.api.nvim_buf_set_option(0, "filetype", "c")
	end,
})

-- format rust files on save
vim.g.rustfmt_autosave = true

-- format python files on autosave
vim.api.nvim_create_augroup("AutoFormat", {})
vim.api.nvim_create_autocmd(
  "BufWritePost",
  {
    pattern = "*.py",
    group = "AutoFormat",
    callback = function()
      vim.cmd [[silent !uv format --quiet]]
      vim.cmd [[silent !uvx ruff check --select I --fix]]
      vim.cmd [[edit]]
    end
  }
)

-- Set tab options for Lua files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function()
		vim.opt.tabstop = 2 -- Number of spaces a tab counts for
		vim.opt.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
		vim.opt.expandtab = true -- Use spaces instead of tabs
	end,
})

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
