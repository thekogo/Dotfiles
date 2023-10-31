-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4    -- insert 2 spaces for a tab


local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {
        name = "gofumpt",
        filetypes = { "go" }
    },
    {
        name = "goimports",
        filetypes = { "go" }
    },
    {
        name = "prettier",
        filetypes = { "tmpl" }
    },
}

lvim.plugins = {
    {
        "briones-gabriel/darcula-solid.nvim",
        dependencies = {
            "rktjmp/lush.nvim"
        }
    },
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
}

lvim.colorscheme = "darcula-solid"

lvim.format_on_save.enabled = true

lvim.keys.normal_mode["<leader>|"] = ":vsplit<CR>"
lvim.keys.normal_mode["<leader>y"] = '"+y'
lvim.keys.normal_mode["<leader>p"] = '"+p'
lvim.keys.normal_mode["<Tab>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-Tab>"] = ":BufferLineCyclePrev<CR>"
lvim.builtin.dap.active = true

local dap = require('dap')
dap.adapters.go = function(callback, _)
    local stdout = vim.loop.new_pipe(false)
    local handle
    local pid_or_err
    local port = 38697
    local opts = {
        stdio = { nil, stdout },
        args = { "dap", "-l", "127.0.0.1:" .. port },
        detached = true,
    }
    handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
        stdout:close()
        handle:close()
        if code ~= 0 then
            print("dlv exited with code", code)
        end
    end)
    assert(handle, "Error running dlv: " .. tostring(pid_or_err))
    stdout:read_start(function(err, chunk)
        assert(not err, err)
        if chunk then
            vim.schedule(function()
                require("dap.repl").append(chunk)
            end)
        end
    end)
    vim.defer_fn(function()
        callback { type = "server", host = "127.0.0.1", port = port }
    end, 100)
end

local get_args = function()
    -- 获取输入命令行参数
    local cmd_args = vim.fn.input('CommandLine Args:')
    local params = {}
    -- 定义分隔符(%s在lua内表示任何空白符号)
    for param in string.gmatch(cmd_args, "[^%s]+") do
        table.insert(params, param)
    end
    return params
end;

dap.configurations.go = {
    -- 普通文件的debug
    {
        type = "go",
        name = "Debug",
        request = "launch",
        -- args = get_args,
        program = "${file}",
    },
    -- 测试文件的debug
    {
        type = "go",
        name = "Debug test", -- configuration for debugging test files
        request = "launch",
        args = get_args,
        mode = "test",
        program = "${file}",
    },
}

require('mini.splitjoin').setup()

local ok, copilot = pcall(require, "copilot")
if not ok then
    return
end

copilot.setup {
    suggestion = {
        keymap = {
            accept = "<c-l>",
            next = "<c-j>",
            prev = "<c-k>",
            dismiss = "<c-h>",
        },
    },
}

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<c-s>", "<cmd>lua require('copilot.suggestion').toggle_auto_trigger()<CR>", opts)
