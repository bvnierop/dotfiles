""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle plugin configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" required by Vundle
filetype off 

set rtp+=~/.vim/bundle/Vundle.vim
let path='~/.vim/bundle'
call vundle#begin(path)

Bundle 'VundleVim/Vundle.vim'

Bundle 'tpope/vim-commentary.git'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-surround'
Bundle 'kien/ctrlp.vim.git'
Bundle 'Valloric/YouCompleteMe'

Bundle 'altercation/vim-colors-solarized'
Bundle 'morhetz/gruvbox'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lisp
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'kovisoft/slimv'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSharp
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'OmniSharp/omnisharp-vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ruby
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'vim-ruby/vim-ruby'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Javascript
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'pangloss/vim-javascript'
Bundle 'mxw/vim-jsx'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HTML
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'tpope/vim-ragtag'


call vundle#end()

" required by Vundle
filetype plugin indent on
