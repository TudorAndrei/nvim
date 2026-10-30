local M = {}

local wincmds = { left = "h", down = "j", up = "k", right = "l" }

local function set(name)
  return vim.env[name] ~= nil and vim.env[name] ~= ""
end

local function in_herdr()
  return set("HERDR_PANE_ID")
end

local function in_rex()
  return set("REX_BLOCK") and not set("TMUX")
end

local function moved_inside(dir)
  local prev = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. wincmds[dir])
  return vim.api.nvim_get_current_win() ~= prev
end

function M.move(dir)
  if in_herdr() then
    if moved_inside(dir) then
      return
    end
    local herdr = vim.env.HERDR_BIN_PATH
    if herdr == nil or herdr == "" then
      herdr = "herdr"
    end
    vim.fn.system({ herdr, "pane", "focus", "--direction", dir, "--pane", vim.env.HERDR_PANE_ID })
    return
  end

  if in_rex() then
    if moved_inside(dir) then
      return
    end
    local rex = set("REX_BIN_DIR") and (vim.env.REX_BIN_DIR .. "/rex") or "rex"
    vim.fn.system({ rex, "focus", dir })
    return
  end

  require("tmux")["move_" .. dir]()
end

return M
