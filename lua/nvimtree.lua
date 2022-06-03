require 'nvim-tree'.setup {
    disable_netrw = true,
    hijack_netrw = true,
    diagnostics = {
        enable = false,
    },
    view = {
        width = 30,
        side = 'left',
    },
    renderer = {
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = false,
                git = true
            }
        }
    }


}
