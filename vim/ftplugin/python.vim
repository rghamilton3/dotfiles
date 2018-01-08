set fileformat=unix

set autoindent nosmartindent
set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Show the 80th char column
set colorcolumn=80
highlight ColorColumn ctermbg=5

set listchars=eol:¬,tab:▷\ ,

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

" Format using yapf
nnoremap <LocalLeader>= :0,$!yapf<CR>

let g:vim_isort_python_version = 'python3'

let g:formatter_yapf_style = 'pep8'
