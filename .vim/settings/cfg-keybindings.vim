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
" TODO: Skip til next blank line instead of just 10 lines
nnoremap <C-j> 10j
nnoremap <C-k> 10k

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


