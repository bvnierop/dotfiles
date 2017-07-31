""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings for appearance
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Setting the colorscheme
if has("gui_running")
    set t_Co=256
    colorscheme oceandeep_bn
else
    set term=screen-256color
    set t_ut=
    set t_Co=256
    set background=dark
    colorscheme gruvbox
endif

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

set visualbell 
