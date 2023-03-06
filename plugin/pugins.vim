" Pandoc
let g:pandoc#syntax#conceal#use = 0

"JS beautyfy
" autocmd Filetype htmldjango nnoremap <silent> <leader>b :!js-beautify -f % -r --type html  -q <enter><CR>
"
" Tex
let g:tex_flavor = 'latex'
let g:vimtex_view_method='zathura'

" Rainbow Brackets
let g:rainbow_active = 1
let g:rainbow_conf = {'separately': {'htmldjango': 0}}

" Closetag.vim
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
let g:closetag_emptyTags_caseSensitive = 1

" Disables auto-close if not in a "valid" region (based on filetype)
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '<leader>>'

let g:polyglot_disabled = ['python']


" let g:doge_mapping='<Leader>t'
" let g:doge_doc_standard_python = 'google'

set completeopt=menu,menuone,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

let g:nvim_tree_tree_ignore = ['.git', '__pycache__', 'Session.vim']
