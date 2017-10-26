set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set autoindent
set fileformat=unix
" Enable folding
set foldmethod=indent
set foldlevel=99

" SimpylFold
"Show docstrings for folded code
let g:SimpylFold_docstring_preview=1

" In order for SimpylFold to load in certain cases
augroup SimpylFold
    autocmd!
    autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
    autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<
augroup END
