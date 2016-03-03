""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings for slimv
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:slimv_repl_split=4                    " vertical split right
let g:paredit_mode=0                        " Disable silly automatic parens
let g:slimv_keybindings=0                   " No (default) keybindings for slimv
let g:slimv_leader=",l"                     " Set slimv leader to ,l


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom slimv keybindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup slimv_settings
    autocmd!
    autocmd FileType lisp call SetLispKeyBindings()
    autocmd FileType scheme call SetLispKeyBindings()
    autocmd FileType clojure call SetLispKeyBindings()
augroup END

function! SetLispKeyBindings()
    " Edit commands
    nmap ,l) :<C-U>call SlimvCloseForm()<CR>

    " Evaluation commands
    nmap ,ld :<C-U>call SlimvEvalDefun()<CR>
    nmap ,le :<C-U>call SlimvEvalExp()<CR>
    nmap ,lr :call SlimvEvalRegion()<CR>
    nmap ,lb :<C-U>call SlimvEvalBuffer()<CR>
    nmap ,lv :call SlimvInteractiveEval()<CR>
    nmap ,lu :call SlimvUndefineFunction()<CR>

    " Debug commands
    nmap ,lk :<C-U>call SlimvMacroexpand()<CR>
    nmap ,lm :<C-U>call SlimvMacroexpandAll()<CR>
    nmap ,lt :call SlimvTrace()<CR>
    nmap ,lT :call SlimvUntrace()<CR>
    nmap ,lB :call SlimvBreak()<CR>
    nmap ,lE :call SlimvBreakOnException()<CR>
    nmap ,ll :call SlimvDisassemble()<CR>
    nmap ,li :call SlimvInspect()<CR>
    nmap ,la :call SlimvDebugAbort()<CR>
    nmap ,lq :call SlimvDebugQuit()<CR>
    nmap ,ln :call SlimvDebugContinue()<CR>
    nmap ,lN :call SlimvDebugRestartFrame()<CR>
    nmap ,lH :call SlimvListThreads()<CR>
    nmap ,lK :call SlimvKillThread()<CR>
    nmap ,lG :call SlimvDebugThread()<CR>

    " Compile commands
    nmap ,lD :<C-U>call SlimvCompileDefun()<CR>
    nmap ,lL :<C-U>call SlimvCompileLoadFile()<CR>
    nmap ,lF :<C-U>call SlimvCompileFile()<CR>
    nmap ,lR :call SlimvCompileRegion()<CR>

    " Xref commands
    nmap ,lxc :call SlimvXrefCalls()<CR>
    nmap ,lxr :call SlimvXrefReferences()<CR>
    nmap ,lxs :call SlimvXrefSets()<CR>
    nmap ,lxb :call SlimvXrefBinds()<CR>
    nmap ,lxm :call SlimvXrefMacroexpands()<CR>
    nmap ,lxp :call SlimvXrefSpecializes()<CR>
    nmap ,lxl :call SlimvXrefCallers()<CR>
    nmap ,lxe :call SlimvXrefCallees()<CR>

    " Profile commands
    nmap ,lp :<C-U>call SlimvProfile()<CR>
    nmap ,lP :<C-U>call SlimvProfileSubstring()<CR>
    nmap ,lU :<C-U>call SlimvUnprofileAll()<CR>
    nmap ,l? :<C-U>call SlimvShowProfiled()<CR>
    nmap ,lo :<C-U>call SlimvProfileReport()<CR>
    nmap ,lX :<C-U>call SlimvProfileReset()<CR>

    " Documentation commands
    nmap ,ls :call SlimvDescribeSymbol()<CR>
    nmap ,lA :call SlimvApropos()<CR>
    nmap ,lh :call SlimvHyperspec()<CR>
    nmap ,l] :call SlimvGenerateTags()<CR>

    " REPL commands
    nmap ,lc :call SlimvConnectServer()<CR>
    nmap ,lg :call SlimvSetPackage()<CR>
    nmap ,ly :call SlimvInterrupt()<CR>
    nmap ,l- :call SlimvClearReplBuffer()<CR>
    nmap ,lQ :call SlimvQuitRepl()<CR>
endfunction

