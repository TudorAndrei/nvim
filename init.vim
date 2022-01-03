let g:mapleader = ","


if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Notes
    Plug 'renerocksai/telekasten.nvim'
    Plug 'renerocksai/calendar-vim'

    " GitSigns
    Plug 'lewis6991/gitsigns.nvim'
    "Startup time info
    Plug 'dstein64/vim-startuptime'

    " Fast startup
    Plug 'lewis6991/impatient.nvim'

    " Navgation
    Plug 'ggandor/lightspeed.nvim'

    " Vin Session automanagement
    Plug 'tpope/vim-obsession'

    " Merge tmux statusline and nvim statusline
    Plug 'vimpostor/vim-tpipeline'

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

    " Autocomplete, lsp and the other shenanigans
    Plug 'neovim/nvim-lspconfig'

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
    Plug 'kdheepak/cmp-latex-symbols'
    " Plug 'tudorandrei/cmp-pandoc-references'
    " Not working
    Plug 'aspeddro/cmp-pandoc.nvim'
    " Plug 'jbyuki/nabla.nvim'


    " Snipets - use utilsnips and luasnip
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'L3MON4D3/LuaSnip'

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
    Plug 'jiangmiao/auto-pairs'
    Plug 'alvan/vim-closetag'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'

    " Pretty errors
    Plug 'folke/trouble.nvim'

    " Other ls
    Plug 'jose-elias-alvarez/null-ls.nvim'

    " Tmux pane switching
    Plug 'christoomey/vim-tmux-navigator'


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
:lua require("lsp")
:lua require("tele")
:lua require("nvimtree")
:lua require("statusline")
:lua require("indent")
:lua require("null")
:lua require("treesitter")
:lua require("trouble")
:lua require("csscolors")
:lua require("todo")
:lua require("zet")
:lua require("git_signs")

