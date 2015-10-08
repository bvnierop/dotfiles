""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings for YouCompleteMe
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

" Map ctrl+space to omnicomlete (context-sensitive)
imap <silent><c-space> <c-x><c-o>
imap <silent><c-tab> <c-x><c-]>
