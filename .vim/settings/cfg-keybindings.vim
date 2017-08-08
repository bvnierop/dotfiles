""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom keybindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ctrl-C to exit insert mode
imap <C-c> <Esc>

" Insert a blank line and do not go to insert mode
nmap <silent>o k:put=''<cr>

" User <leader><leader> to toggle buffers
nnoremap <leader><leader> <c-^>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Better carret movement
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move up and down in bigger steps
" nnoremap <silent> <C-u> :exec 'norm ' . &scroll . 'k'<cr>
" nnoremap <silent> <C-d> :exec 'norm ' . &scroll . 'j'<cr>
nnoremap <silent> <C-u> 20k
nnoremap <silent> <C-d> 20j

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do not use arrow keys
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <Left> <nop>
noremap <Right> <nop>
noremap <Up> <nop>
noremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>

