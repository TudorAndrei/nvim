nmap Q <Nop>
" Switch buffers
noremap <leader>n :bn<cr>
noremap <leader>p :bp<cr>
noremap <leader>d :Bdelete<cr>

"split navigations
nnoremap <C-h> <C-W><C-H>
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>

tnoremap <Esc> <C-\><C-n>

nnoremap <leader>/ :Commentary<CR>
vnoremap <leader>/ :Commentary<CR>

nnoremap <silent><C-n> :NvimTreeToggle<CR>
