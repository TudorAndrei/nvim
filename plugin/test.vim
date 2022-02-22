nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tT :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>


let test#strategy = 'vimux'
let test#python#runner = 'pytest'
let test#python#pytest#options = '--html=report.html --self-contained-html'
