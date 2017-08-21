"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" This is Bart van Nierop's .vimrc file.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Vim settings, rather than Vi settings.
set nocompatible

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" Determine platform
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
silent function! WINDOWS()
    return (has('win32') || has('win64'))
endfunction

" MS Windows behaviour. 
if WINDOWS()
    if has('gui_running')
        behave mswin
    endif
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" We must set leader before running Vundle, so that plugins know that it is
" set.
let mapleader="\\"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vim/vundles.vim"))
  source ~/.vim/vundles.vim
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                          " Line numbers are awesome
set numberwidth=5
set history=1000                    " Lots of :cmdline history
set backspace=indent,eol,start      " Allow backspacing in insert mode
set showmode                        " Display current mode
set showcmd                         " Display incomplete commands
set autoread                        " Automatically reload changed files
if $TMUX == ''
  set clipboard=unnamed               " Allow copy/pasting between other applications
endif
set encoding=utf-8                  " Support UTF-8
set cursorline                      " Highlight current line
set laststatus=2                    " Always show status line
set showtabline=2                   " Always show line with tab pages
set showmatch                       " Show matching brackets
set cmdheight=2                     " Two lines of command-line
set gcr:a:blinkon0                  " Prevent cursor blinking
set regexpengine=1                  " Syntax highlighting is slow with new regexpengine
set formatoptions-=or               " Disable automatic comment prefix on 'o' and return.
syntax on                           " Enable syntax highlighting
" Shamelessly stolen from GRB: Put useful info in status line
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
:hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red

" Allow unsaved buffers and remember marks/undo for them
set hidden

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent                      " Automatic indentation
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Auto indent pasted text
" nnoremap p p=`]<C-o>
" nnoremap P P=`]<C-o>

filetype plugin on
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
filetype indent on
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folds
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=indent               " Fold based on indent
set foldnestmax=3                   " Deepest fold is 3 levels
set nofoldenable                    " Do not fold by default

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Backup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backup
set backupdir=~/.vim-tmp,~/.tmp
set directory=~/.vim-tmp,~/.tmp

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set incsearch                       " Find match while typing
set hlsearch                        " Highlight search results
set ignorecase                      " Ignore case when searching...
set smartcase                       " ...unless we type a capital
" Clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Scrolling
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set scrolloff=8                     " Keep 8 lines visible at edges
set sidescrolloff=15                " Keep 15 columns visible at edges
set sidescroll=1                    " Scroll 1 column at a time

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic editing settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set switchbuf=useopen
set winwidth=79

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom autocmd's
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
    " Clear all autocmds in the group
    autocmd!
    autocmd FileType text setlocal textwidth=78
    " Jump to last cursor position unless it's invalid or in an event handler
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup wildignore
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildignore+=.git,.hg,.svn " Source control
set wildignore+=*.o,*.obj,*.a,*.lib,*.exe,*.com,*.dll " Binaries
set wildignore+=*.P " Used for determining depencies
set wildignore+=*.javac,*.class,*.pyc " Compiled files
set wildignore+=*.bmp,*.png,*.jpg,*.gif " Images
set wildignore+=*.doc,*.docx,*.xls,*.xlsx,*.ppt,*.pptx " MS Office files
set wildignore+=*.sln,*.vcproj,*.vcprojx " Visual Studio solution/project files.
set wildignore+=boost/* " Ignore boost.
set wildignore+=*.ap_,*.apk " Android binaries
set wildignore+=gmock/** " Google mock files

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Run settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vim/settings.vim"))
  source ~/.vim/settings.vim
endif
