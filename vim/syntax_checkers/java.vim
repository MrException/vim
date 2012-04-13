if exists("loaded_java_syntax_checker")
    finish
endif
let loaded_java_syntax_checker = 1

"bail if the user doesnt have ruby installed
if !executable("javac")
    finish
endif

function! SyntaxCheckers_java_GetLocList()
    let makeprg = 'javac '.shellescape(expand('%'))
    let errorformat = '%f:%l: %m,'
    "let errorformat = '%-GSyntax OK,%E%f:%l: syntax error\, %m,%Z%p^,%W%f:%l: warning: %m,%Z%p^,%-C%.%#'

    return SyntasticMake({ 'makeprg': makeprg, 'errorformat': errorformat })
endfunction
