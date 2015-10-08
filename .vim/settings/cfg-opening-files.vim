""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings for opening files without CtrlP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folder of current file expand
cnoremap %% <C-R>=expand('%:h').'/'<cr>
" Change working folder to folder of current file
command! CDC :cd %:p:h
" Change working folder of active window to folder of current file
command! LCDC :lcd %:p:h
"Open files in same folder as current
map <leader>e :edit %%
map <leader>v :view %%

" Use emacs-style tab completion when selecting files, etc...
set wildmode=longest,list
" Make tab coompletion for files/buffers act like bash
set wildmenu
