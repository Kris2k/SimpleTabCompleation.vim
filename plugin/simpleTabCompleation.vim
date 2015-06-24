""""""""""""""""""""""""""""""
" => Tab completion hack, Supertab Replacement
"""""""""""""""""""""""""""""""
"set complete
function! <SID>Smart_TabComplete()
    let l:line = getline('.')                         " current line

    let l:substr = strpart(line, -1, col('.'))      " from the start of the current
                                                    " line to one character right
                                                    " of the cursor
    let l:charBefroeCurrsor = substr[strlen(substr)-1]
    if ( l:charBefroeCurrsor == ' ' || l:charBefroeCurrsor == '	' || col('.') == 1 )
        return "\<tab>"
    endif

    let l:substr =  matchstr(substr,'\s[^\s]*$')
    let l:has_slash = match(substr, '\/') != -1       " position of slash, if any
    let l:has_omnifunc = strlen(&omnifunc)

    if (!l:has_slash)
        return "\<C-X>\<C-N>"                       " existing text matching
        "return "\<C-X>\<C-P>"                       " existing text matching
    elseif (l:has_slash)
        return "\<C-X>\<C-F>"                       " file matching
    elseif (l:has_omnifunc)
        return "\<C-X>\<C-O>"                       " plug-in matching
    else
        return "\<C-X>\<C-N>"                       " existing text matching
    endif

endfunction

" use shift tab as normal tab to separate words
inoremap <silent> <s-tab> <tab>
inoremap <silent> <expr> <c-space> pumvisible() ? "\<lt>C-x><C-o>" :  '\<lt>c-p><c-r>=pumvisible() ?  : <c-x><c-p>'
inoremap <silent> <expr> <tab> pumvisible() ? "\<lt>C-N>" :  "<C-R>=<SID>Smart_TabComplete()<cr>"
inoremap <silent> <expr> <s-tab> pumvisible() ? "\<lt>C-P>" : "\<s-tab><CR>"
