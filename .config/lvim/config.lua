-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4    -- insert 4 spaces for a tab

lvim.plugins = {
    -- {
    --   "briones-gabriel/darcula-solid.nvim",
    --   dependencies = {
    --     "rktjmp/lush.nvim"
    --   }
    -- },
    { 'echasnovski/mini.splitjoin', version = false },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
    },
    {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end,
    },
    { 'simrat39/rust-tools.nvim' },
}

-- lvim.colorscheme = "darcula-solid"

require('mini.splitjoin').setup()

reload "user.rust_tools"
reload "user.keymaps"
reload "user.dap"
reload "user.formatters"
reload "user.copilot"
