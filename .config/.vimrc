call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'
call plug#end()

set t_Co=256
set background=dark

colorscheme gruvbox

set nu
set rnu

" Enable search highlighting & make escape clear highlights
set hlsearch
nnoremap <silent> <Esc> :nohlsearch<CR>

set tabstop=2
set shiftwidth=2
set syntax=on
set backspace=indent,eol,start

let mapleader=" "

" Normal mode map
nnoremap <silent> <Leader>f :Ex<CR>
