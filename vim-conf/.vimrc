" 行号
set number
" 语法高亮 
syntax on
" 主题
colorscheme default
" 搜索高亮
set hlsearch
" tab 空格的长度，默认8
set tabstop=4
" 表示在编辑模式的时候按退格键的时候退回缩进的长度，当使用 expandtab时特别有用。
set softtabstop=4
" 表示每一级缩进的长度
set shiftwidth=4
" 当设置成 expandtab 时，缩进用空格来表示，noexpandtab 则是用制表符表示一个缩进
set expandtab

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

let mapleader=','
let g:mapleader=','


" 窗口切换
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" buffer切换
nnoremap <silent> [b :bprevious<cr>
nnoremap <silent> [n :bnext<CR>

inoremap <leader>w <Esc>:w<cr>
inoremap jj <Esc> 
inoremap zz <Esc>:wq<cr> 

" 添加文件表头
autocmd BufNewFile *.[ch],*.hpp,*.cpp exec ":call SetTitle()" 
function! SetFileDesc()
    call setline(1,"/**") 
    call append(line("."),   " * author  :luo")
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

" 插件
call plug#begin('~/.vim/plugged')
source $HOME/.vim/plugins.vim
call plug#end()


