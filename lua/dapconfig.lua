local pypath = vim.g.current_python_path
-- local dap = require('dap')
require('dap-python').setup(pypath)
require('nvim-dap-virtual-text').setup()


vim.keymap.set("n", "<Leader>dc", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<Leader>dov", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<Leader>dsi", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<Leader>dso", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<Leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
-- vim.keymap.set("n", "<Leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
-- vim.keymap.set("n", "<Leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
vim.keymap.set("n", "<Leader>dr", ":lua require'dap'.repl.open()<CR>")
vim.keymap.set("n", "<Leader>dl", ":lua require'dap'.run_last()<CR>")
vim.keymap.set("n", "<Leader>du", ":lua require'dapui'.toggle()<CR>")
vim.keymap.set("v", "<Leader>de", ":lua require'dapui'.eval()<CR>")

require("dapui").setup({
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    -- Expand lines larger than the window
    -- Requires >= 0.7
    expand_lines = vim.fn.has("nvim-0.7"),
    sidebar = {
        -- You can change the order of elements in the sidebar
        elements = {
            -- Provide as ID strings or tables with "id" and "size" keys
            {
                id = "scopes",
                size = 0.25, -- Can be float or integer > 1
            },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 00.25 },
        },
        size = 40,
        position = "left", -- Can be "left", "right", "top", "bottom"
    },
    tray = {
        elements = { "repl" },
        size = 10,
        position = "bottom", -- Can be "left", "right", "top", "bottom"
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
    }
})
