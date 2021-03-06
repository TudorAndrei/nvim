let g:mapleader = ","


if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " TODO: Integrate nvim-dap
    " Plug 'mfussenegger/nvim-dap'
    " Plug 'rcarriga/nvim-dap-ui'
    " Plug 'theHamsta/nvim-dap-virtual-text'
    " Plug 'Pocco81/dap-buddy.nvim', {'commit': 'dfa5e810f0fa17c3fcf5c60ab066f14406be7172'}
    Plug 'mfussenegger/nvim-dap-python'
    Plug 'nvim-telescope/telescope-dap.nvim'
    Plug 'wellle/targets.vim'


    Plug 'vim-test/vim-test'
    Plug 'preservim/vimux'

    " Pretty Notifications
    Plug 'rcarriga/nvim-notify'

    " Neovim Notebooks
    " Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }

    " Plug 'preservim/vim-wordy'
    Plug 'jamestomasino/vim-writingsyntax'

    " Notes
    Plug 'renerocksai/telekasten.nvim'
    Plug 'renerocksai/calendar-vim'

    " GitSigns
    Plug 'lewis6991/gitsigns.nvim'

    "Startup time info
    Plug 'dstein64/vim-startuptime', {'on': 'StartupTime'}

    " Fast startup
    Plug 'lewis6991/impatient.nvim'

    " Navgation
    Plug 'ggandor/lightspeed.nvim'

    " Vin Session automanagement
    Plug 'tpope/vim-obsession'


    " Indent markers
    Plug 'lukas-reineke/indent-blankline.nvim'

    " Don't change layout when deleting buffer
    Plug 'famiu/bufdelete.nvim'

    " Generate Docstrings
    Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() }, 'for': ['python'] }

    " Comment lines
    Plug 'tpope/vim-commentary'

    " Colorscheme
    Plug 'Mofiqul/dracula.nvim'
    Plug 'folke/lsp-colors.nvim'



    " Autocomplete, lsp and the other shenanigans
    Plug 'neovim/nvim-lspconfig'
    Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-refactor'
    Plug 'p00f/nvim-ts-rainbow'

    Plug 'nvim-telescope/telescope.nvim'

    Plug 'nvim-telescope/telescope-media-files.nvim'
    Plug 'nvim-lua/popup.nvim'


    Plug 'nvim-lua/plenary.nvim'
    Plug 'onsails/lspkind-nvim'

    " Autocomplete sources
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-emoji'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-nvim-lua'
    Plug 'hrsh7th/cmp-omni'
    Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
    Plug 'kdheepak/cmp-latex-symbols'
    Plug 'PaterJason/cmp-conjure'
    " Plug 'jc-doyle/cmp-pandoc-references'
    " Not working
    Plug 'aspeddro/cmp-pandoc.nvim'
    " Plug 'jbyuki/nabla.nvim'

    Plug 'ray-x/lsp_signature.nvim'

    " Snipets - use utilsnips and luasnip
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'rafamadriz/friendly-snippets'

    " File icons
    Plug 'kyazdani42/nvim-web-devicons'

    " File explorer
    Plug 'kyazdani42/nvim-tree.lua'

    " Statusline and bufferline
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'arkav/lualine-lsp-progress'
    Plug 'akinsho/bufferline.nvim'

    " Pandoc, markdown and rmarkdown
    Plug 'vim-pandoc/vim-pandoc', {'for': ['markdown', 'rmd']}
    Plug 'vim-pandoc/vim-pandoc-syntax', {'for': ['markdown', 'rmd']}
    Plug 'vim-pandoc/vim-rmarkdown', {'for': ['markdown', 'rmd']}
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
    Plug 'ferrine/md-img-paste.vim', {'for': ['markdown', 'rmd']}

    " Latex
    Plug 'lervag/vimtex', {'for': 'tex'}

    " align tables
    Plug 'junegunn/vim-easy-align', {'for': ['markdown', 'rmd']}

    Plug 'norcalli/nvim-colorizer.lua'

    " Autoclose tags and ({[]})
    Plug 'windwp/nvim-autopairs'
    Plug 'windwp/nvim-ts-autotag'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'

    " Pretty errors
    Plug 'folke/trouble.nvim'

    " Other ls
    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

    " Tmux pane switching
    Plug 'christoomey/vim-tmux-navigator'

    Plug 'wlangstroth/vim-racket'
    Plug 'Olical/conjure',{ 'branch': 'develop', 'for': ['racket', 'sicp'] }

    " Todo
    Plug 'folke/todo-comments.nvim'

call plug#end()

colorscheme dracula
set termguicolors

if $CONDA_PREFIX == ""
  let g:current_python_path=$CONDA_PYTHON_EXE
else
  let g:current_python_path=$CONDA_PREFIX.'/bin/python'
endif
let g:tpipeline_cursormoved = 1

:lua require('patient')
" :lua require('racket-sitter')
:lua require("lsp")
:lua require("tele")
:lua require("nvimtree")
:lua require("statusline")
:lua require("indent")
" :lua require("null")
:lua require("treesitter")
:lua require("csscolors")
:lua require("todo")
:lua require("zet")
:lua require("git_signs")
:lua require("pairs")
" :lua require("dapconfig")

let g:conjure#filetypes = ["clojure", "fennel", "janet", "racket", "scheme", "sicp"]
let g:conjure#filetype#sicp = "conjure.client.racket.stdio"
