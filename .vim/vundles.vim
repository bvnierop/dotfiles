""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle plugin configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" required by Vundle
filetype off 

set rtp+=~/.vim/bundle/Vundle.vim
let path='~/.vim/bundle'
call vundle#begin(path)

Bundle 'gmarik/vundle.vim'

Bundle 'tpope/vim-commentary.git'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-surround'
Bundle 'kien/ctrlp.vim.git'
Bundle 'Valloric/YouCompleteMe'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lisp
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'kovisoft/slimv'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSharp
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'OmniSharp/omnisharp-vim'

call vundle#end()

" required by Vundle
filetype plugin indent on
