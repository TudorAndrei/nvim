local M = {}

local wincmds = { left = "h", down = "j", up = "k", right = "l" }

local function in_herdr()
  return vim.env.HERDR_PANE_ID ~= nil and vim.env.HERDR_PANE_ID ~= ""
end

function M.move(dir)
  if not in_herdr() then
    require("tmux")["move_" .. dir]()
    return
  end

  local prev = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. wincmds[dir])
  if vim.api.nvim_get_current_win() ~= prev then
    return
  end

  local herdr = vim.env.HERDR_BIN_PATH
  if herdr == nil or herdr == "" then
    herdr = "herdr"
  end
  vim.fn.system({ herdr, "pane", "focus", "--direction", dir, "--pane", vim.env.HERDR_PANE_ID })
end

return M
