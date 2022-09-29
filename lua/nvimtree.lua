require 'nvim-tree'.setup {
    disable_netrw = true,
    hijack_netrw = true,
    diagnostics = {
        enable = false,
    },
    filters = {
        custom = { "^.git$",
            ".*.aux$",
            ".*.bbl$",
            ".*.fls$",
            ".*.fdb_latexmk$",
            ".*.toc$",
            ".*.out$",
            ".*.bcf$",
            ".*.lbx$",
            ".*.run.xml$",
            ".*.synctex.gz$" },
        exclude = { "data", ".env" },
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
