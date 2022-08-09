require("indent_blankline").setup {
    char = "|",
    buftype_exclude = { "terminal", 'nofile' },
    filetype_exclude = {
        "help",
        "NvimTree",
        "Trouble",
    }
}
