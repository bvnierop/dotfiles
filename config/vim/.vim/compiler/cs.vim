" Vim compiler file
" Compiler: msbuild
" Compiler for C# files

if exists("current_compiler")
    finish
endif

let current_compiler = "cs"

if exists(":CompilerSet") != 2 "older Vim always used :setlocal
    command -nargs=* CompilerSet setlocal <args>
endif

" default error format
CompilerSet errorformat=\ %#%f(%l\\\,%c):\ %m

" default make
CompilerSet makeprg=msbuild

