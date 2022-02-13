" TODO: map keys only for telekasten
autocmd FileType telekasten nnoremap <leader>zf :lua require('telekasten').find_notes()<CR>
autocmd FileType telekasten nnoremap <leader>zd :lua require('telekasten').find_daily_notes()<CR>
autocmd FileType telekasten nnoremap <leader>zg :lua require('telekasten').search_notes()<CR>
autocmd FileType telekasten nnoremap <leader>zz :lua require('telekasten').follow_link()<CR>
autocmd FileType telekasten nnoremap <leader>zT :lua require('telekasten').goto_today()<CR>
autocmd FileType telekasten nnoremap <leader>zW :lua require('telekasten').goto_thisweek()<CR>
autocmd FileType telekasten nnoremap <leader>zw :lua require('telekasten').find_weekly_notes()<CR>
autocmd FileType telekasten nnoremap <leader>zn :lua require('telekasten').new_note()<CR>
autocmd FileType telekasten nnoremap <leader>zN :lua require('telekasten').new_templated_note()<CR>
autocmd FileType telekasten nnoremap <leader>zy :lua require('telekasten').yank_notelink()<CR>
autocmd FileType telekasten nnoremap <leader>zc :lua require('telekasten').show_calendar()<CR>
autocmd FileType telekasten nnoremap <leader>zC :CalendarT<CR>
autocmd FileType telekasten nnoremap <leader>zi :lua require('telekasten').paste_img_and_link()<CR>
autocmd FileType telekasten nnoremap <leader>zt :lua require('telekasten').toggle_todo()<CR>
autocmd FileType telekasten nnoremap <leader>zb :lua require('telekasten').show_backlinks()<CR>
autocmd FileType telekasten nnoremap <leader>zF :lua require('telekasten').find_friends()<CR>
autocmd FileType telekasten nnoremap <leader>zI :lua require('telekasten').insert_img_link({ i=true })<CR>
autocmd FileType telekasten nnoremap <leader>zp :lua require('telekasten').preview_img()<CR>
autocmd FileType telekasten nnoremap <leader>zm :lua require('telekasten').browse_media()<CR>
autocmd FileType telekasten nnoremap <leader>za :lua require('telekasten').show_tags()<CR>
autocmd FileType telekasten nnoremap <leader># :lua require('telekasten').show_tags()<CR>

" on hesitation, bring up the panel
autocmd FileType telekasten nnoremap <leader>z :lua require('telekasten').panel()<CR>

" we could define [[ in **insert mode** to call insert link
autocmd FileType telekasten inoremap [[ <cmd>:lua require('telekasten').insert_link()<CR>
" alternatively: leader [
autocmd FileType telekasten inoremap <leader>[ <cmd>:lua require('telekasten').insert_link({ i=true })<CR>
autocmd FileType telekasten inoremap <leader>zt <cmd>:lua require('telekasten').toggle_todo({ i=true })<CR>
autocmd FileType telekasten inoremap <leader># <cmd>lua require('telekasten').show_tags({i = true})<cr>


" for gruvbox
" hi tklink ctermfg=72 guifg=#689d6a cterm=bold,underline gui=bold,underline
" hi tkBrackets ctermfg=gray guifg=gray

" real yellow
hi tkHighlight ctermbg=yellow ctermfg=darkred cterm=bold guibg=yellow guifg=darkred gui=bold
" gruvbox
"hi tkHighlight ctermbg=214 ctermfg=124 cterm=bold guibg=#fabd2f guifg=#9d0006 gui=bold

hi link CalNavi CalRuler
hi tkTagSep ctermfg=gray guifg=gray
hi tkTag ctermfg=175 guifg=#d3869B
