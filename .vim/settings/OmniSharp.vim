""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings for OmniSharp
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:Omnisharp_start_server = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom slimv keybindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup OmniSharp_settings
    autocmd!

    " autocmd BufWritePost *.cs call OmniSharp#AddToProject()
    autocmd FileType cs call SetCSharpKeyBindings()
augroup END

function! SetCSharpKeyBindings()
    nnoremap ,fg :OmniSharpGotoDefinition<cr>
    nnoremap ,fi :OmniSharpFindImplementations<cr>
    nnoremap ,ft :OmniSharpFindType<cr>
    nnoremap ,fs :OmniSharpFindSymbol<cr>
    nnoremap ,fu :OmniSharpFindUsages<cr>
    "finds members in the current buffer
    nnoremap ,fm :OmniSharpFindMembers<cr>
    " cursor can be anywhere on the line containing an issue
    nnoremap ,fx  :OmniSharpFixIssue<cr>
    nnoremap ,fy :OmniSharpFixUsings<cr>
    nnoremap ,fl :OmniSharpTypeLookup<cr>
    nnoremap ,fd :OmniSharpDocumentation<cr>
    nnoremap ,f. :OmniSharpGetCodeActions<cr>

    " navigate by method/property/field
    "nnoremap <C-J> :OmniSharpNavigateDown<cr> 
    "nnoremap <C-K> :OmniSharpNavigateUp<cr>

    " Test commands
    nnoremap ,tr :wa!\|:OmniSharpRunTests<cr>
    nnoremap ,tf :wa!\|:OmniSharpRunTestFixture<cr>
    nnoremap ,ta :wa!\|:OmniSharpRunAllTests<cr>
    nnoremap ,tl :wa!\|:OmniSharpRunLastTests<cr>
endfunction


