local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.racket = {
    install_info = {
        url = "~/cave/tree-sitter-racket", -- local path or git repo
        files = { "src/parser.c" },
    },
    filetype = "rkt", -- if filetype does not agrees with parser name
    used_by = { "sicp" }
}

