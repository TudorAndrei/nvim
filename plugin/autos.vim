augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
augroup end
augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
augroup end
augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
augroup end
augroup _somecmds
    " Set comments for vim-commentary
    autocmd FileType rmd,md setlocal commentstring=\ <!--\ %s\ -->
    " Autoremove trailing white space
    autocmd BufWritePre * %s/\s\+$//e
    autocmd FileType python,md,rmd autocmd BufWritePre <buffer> :%s/\($\n\s*\)\+\%$//e

    " Open html in firefox
    autocmd Filetype html noremap <silent> <leader>f :!firefox %<enter>
augroup end
" After col 80 error highlight
" au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
" au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
