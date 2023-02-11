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

nnoremap <leader>fl <cmd>Telescope find_files<cr>
nnoremap <leader>fr <cmd>Telescope file_browser<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fk <cmd>Telescope keymaps<cr>
nnoremap <leader>ft <cmd>TroubleToggle<cr>
nnoremap z= <cmd>Telescope spell_suggest<cr>
nnoremap <leader>fo <cmd>SymbolsOutline<cr>
