--[[
-- IPython development and interaction.
-- created 09/27/2025
-- + depends on `molten-nvim`, see docs for more information:
--   it works via quarto docs; this should make it a bit more agile
--   for editing ipython files in terminal (rather than using `vscodium`.
--
-- + editing notebooks via quarto is also provided
--]]

return {
    -- molten.nvim
    {
        "benlubas/molten-nvim",
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        priority = 1000,
        init = function()
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 20
            vim.g.molten_wrap_output = true -- wrap output
            vim.g.molten_virt_text_output = true -- output as virtual text
            vim.g.molten_virt_lines_off_by_1 = true

            -- setup keybindings
            vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize the plugin" })
            vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>", { desc = "evaluate operator", silent = true })
            vim.keymap.set("n", "<localleader>os", ":noautocmd MoltenEnterOutput<CR>", { desc = "open output window", silent = true })

            vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", { desc = "re-eval cell", silent = true })
            vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "execute visual selection", silent = true })
            vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })
            vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })

            -- if you work with html outputs:
            vim.keymap.set("n", "<localleader>mx", ":MoltenOpenInBrowser<CR>", { desc = "open output in browser", silent = true })
        end,
        ft = { "quarto", "markdown" },
    },

    -- image display in terminal
    {
        "3rd/image.nvim",
        opts = {
            backend = "kitty",
            max_width = 100,
            max_height = 12,
            max_height_window_percentage = math.huge,
            max_width_window_percentage = math.huge,
            window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        },
    },

    -- quarto
    {
        "quarto-dev/quarto-nvim",
        dependencies = {
            "jmbuhr/otter.nvim",
            "nvim-treesitter/nvim-treesitter",
        },

        init = function()
            local quarto = require("quarto")
            quarto.setup({
                lspFeatures = {
                    -- NOTE: put whatever languages you want here:
                    languages = { "r", "python", "rust" },
                    chunks = "all",
                    diagnostics = {
                        enabled = true,
                        triggers = { "BufWritePost" },
                    },
                    completion = {
                        enabled = true,
                    },
                },
                keymap = {
                    -- NOTE: setup your own keymaps:
                    hover = "H",
                    definition = "gd",
                    rename = "<leader>rn",
                    references = "gr",
                    format = "<leader>gf",
                },
                codeRunner = {
                    enabled = true,
                    default_method = "molten",
                },
            })

            local runner = require("quarto.runner")
            vim.keymap.set("n", "<localleader>rc", runner.run_cell,  { desc = "run cell", silent = true })
            vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
            vim.keymap.set("n", "<localleader>rA", runner.run_all,   { desc = "run all cells", silent = true })
            vim.keymap.set("n", "<localleader>rl", runner.run_line,  { desc = "run line", silent = true })
            vim.keymap.set("v", "<localleader>r",  runner.run_range, { desc = "run visual range", silent = true })
            vim.keymap.set("n", "<localleader>RA", function()
              runner.run_all(true)
            end, { desc = "run all cells of all languages", silent = true })
        end,
    }
}
