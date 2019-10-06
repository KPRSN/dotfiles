" Syntax highlighting
syntax on

" Relative/hybrid line numbering
set relativenumber
set number

" Tabs are four spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Indent automatically after newline
set autoindent

" Vim-plug
call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'arcticicestudio/nord-vim'
call plug#end()

" Colorscheme
colorscheme nord
let g:lightline = { 'colorscheme': 'nord' }

" Show Lightline
set laststatus=2
