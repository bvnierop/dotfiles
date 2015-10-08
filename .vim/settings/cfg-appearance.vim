""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings for appearance
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Setting the colorscheme
set t_Co=256
colorscheme oceandeep_bn

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Window stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable fluff
set guioptions-=m " Menu
set guioptions-=T " Toolbar
set guioptions-=L " Scrollbars
set guioptions-=r
" Resize
if has("gui_running")
    set guifont=Consolas
    set lines=999
    set columns=999
endif

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif
