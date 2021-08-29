
" 添加文件表头
autocmd BufNewFile *.[ch],*.hpp,*.cpp exec ":call SetTitle()" 
function! SetFileDesc()
    call setline(1,"/**") 
    call append(line("."),   " * author  :itsluo")
    call append(line(".")+1, " * file    :".expand("%:t"))
    call append(line(".")+2, " * date    :".strftime("%Y-%m-%d")) 
    call append(line(".")+3, " * describe:") 
    call append(line(".")+4, " */")
    call append(line(".")+5, " ") 
endfunc

function! SetTitle()
    call SetFileDesc()
    if expand("%:t:r") == 'main'
        return
    endif

    if expand("%:e") == 'h' 
        call append(line(".")+6, "#pragma once") 
    elseif &filetype == 'c'|| &filetype == 'cpp' 
        call append(line(".")+6, "#include \"".expand("%:t:r").".h\"") 
    endif
endfunc
