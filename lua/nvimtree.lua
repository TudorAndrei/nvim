vim.g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 0,
}
require'nvim-tree'.setup {
   disable_netrw= true,
  hijack_netrw = true,
    diagnostics = {
    enable = false,
  },
  view = {
    width = 30,
    side = 'left',
  }
}
