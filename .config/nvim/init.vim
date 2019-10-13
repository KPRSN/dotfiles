if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=utf-8,latin1
endif

set list listchars=tab:>\ ,trail:-,eol:$
set nolist

" Relative/hybrid line numbering
set relativenumber
set number

" Tabs are four spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Case insensitive-ish search
set smartcase

" Copy to the end of line
noremap Y y$

" Split new windows below or to the right
set splitbelow
set splitright

" Use space as leader key
let mapleader = "\<Space>"

" Finding
:nmap <leader>fr :FZF
:nmap <leader>fF :FZF <c-r>=expand("%:p:h")<CR>
:nmap <leader>ff :FZF %:p:h<CR>
:nmap <leader>fa :call CurtineIncSw()<CR>

" Buffers
:nmap <leader>bb :Buffers<CR>
:nmap <leader>bd :Bdelete<CR>
:nmap <leader>bD :Bwipeout<CR>

" Saving and quitting
:nmap <leader>qa :qa<CR>
:nmap <leader>qa! :qa!<CR>
:nmap <leader>q! :q!<CR>
:nmap <leader>w! :w!<CR>

" Snappy window switching
:nmap <leader>h <C-w>h
:nmap <leader>j <C-w>j
:nmap <leader>k <C-w>k
:nmap <leader>l <C-w>l
:nmap <leader>p <C-w>p

" Previous buffer
:nmap <leader><Tab> <C-^>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAl

" Enable smart pairs (e.g. parenthesis, brackets and stuff)
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

" Vim-plug
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'          " Sensible default settings.
Plug 'tpope/vim-commentary'        " Comment out stuff with gc.
Plug 'tpope/vim-unimpaired'        " More bindings for square brackets.
Plug 'tpope/vim-repeat'            " Let plugins repeatsuff with dot.
Plug 'machakann/vim-sandwich'      " Surround stuff with sa, sd and sr.
Plug 'junegunn/vim-easy-align'     " Align stuff with ga.
Plug 'nathanalderson/yang.vim'     " YANG syntax.
Plug 'wellle/targets.vim'          " Add more targets, like cia (change in argument).
Plug 'ericcurtin/CurtineIncSw.vim' " Toggle header/src (C/C++).
Plug 'moll/vim-bbye'               " Close and delete buffers (Bdelete/Bwipeout).
Plug 'tmsvg/pear-tree'             " Pair parenthesis automagically.
Plug 'itchyny/lightline.vim'       " Status line.
Plug 'arcticicestudio/nord-vim'    " Nord theme.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'            " Fuzzy find.
call plug#end()

" Colorscheme
colorscheme nord
let g:lightline = { 'colorscheme': 'nord' }
