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
