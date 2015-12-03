""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settinggs for CtrlP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>f :CtrlP<cr>
map <leader>F :CtrlP %%<cr>
map ,ff :CtrlP<cr>
map ,fF :CtrlP %%<cr>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$\|debug\|release',
    \ 'file': '\.exe$\|\.so$\|\.dat$\|\.tlog$\|\.a$\|\.log$\|\.sdf$\|\.dll$\|\.d$\|\.o$'
    \ }

" Set the CtrlP results window to show:
"   - A minimum of 1 line
"   - A maximum of 50 lines
"   - At most 100 results
let g:ctrlp_match_window='min:1,max:50,results:100'
