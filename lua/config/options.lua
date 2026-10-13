vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.g.lazyvim_picker = "snacks"
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

local opt = vim.opt
opt.signcolumn = "yes"
opt.tabstop = 4
opt.softtabstop = 4
opt.swapfile = false
opt.wrap = true

vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)

vim.filetype.add({
  extension = {
    jinja = "jinja",
    jinja2 = "jinja",
    j2 = "jinja",
  },
})
