local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end
map("n", "<c-h>", "<cmd>lua require('config.nav').move('left')<cr>")
map("n", "<c-j>", "<cmd>lua require('config.nav').move('down')<cr>")
map("n", "<c-k>", "<cmd>lua require('config.nav').move('up')<cr>")
map("n", "<c-l>", "<cmd>lua require('config.nav').move('right')<cr>")
map("n", "<leader>gd", "<cmd>Difft<cr>", { desc = "Difftastic Diff (uncommitted)" })
