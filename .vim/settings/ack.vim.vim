""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings for ack.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" use the silver searcher, if we have it
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
