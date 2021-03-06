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
set ignorecase
set smartcase

" Highlight the current line
set cursorline

" Align function arguments
:set cino+=(0

" Copy to the end of line
noremap Y y$

" Split new windows below or to the right
set splitbelow
set splitright

" Live substitutions
set inccommand=nosplit

" Make things such as git gutter update more quickly
set updatetime=100

" Always show sign column/git gutter
set signcolumn=yes

" Highlight lines overflowing 120 characters
call matchadd('ErrorMsg', "\\%120v.\\+", 100)

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid, when inside an event handler
" (happens when dropping a file on gvim) and for a commit message (it's
" likely a different one than last time).
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" Only show cursor line in active window
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" Fuzzy-find git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}),
  \   <bang>0)

" Always preview
let g:fzf_preview_window = 'right:50%'

" Use space as leader key
let mapleader = "\<Space>"

" Finding files
:nmap <leader>ff :FZF <CR>
:nmap <leader>fF :FZF <C-R>=expand("%:p:h")<CR>
:nmap <leader>fr :FZF %:p:h<CR>

" Jumping between header and source
:nmap <leader>fa :call CurtineIncSw()<CR>

" Git greping
:nmap <leader>fg :GGrep 
:nmap <leader>/ :GGrep <C-R>=expand("<cword>")<CR>
:nmap <leader>* :GGrep <C-R>=expand("<cword>")<CR><CR>

" Git blaming
:nmap <leader>gb :Gblame<CR>

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

" Less snappy window switching
:nmap <leader>wh <C-w>h
:nmap <leader>wj <C-w>j
:nmap <leader>wk <C-w>k
:nmap <leader>wl <C-w>l
:nmap <leader>wp <C-w>p

" Opening and closing windows
:nmap <leader>wc <C-w>c
:nmap <leader>w/ :vs<CR>
:nmap <leader>w- :sp<CR>

" Navigating tabs
:nmap <leader>t :tabnew<CR>
:nmap <leader>T :tabclose<CR>
:nmap <leader>n gt
:nmap <leader>p gT
:nmap <leader>1 1gt
:nmap <leader>2 2gt
:nmap <leader>3 3gt
:nmap <leader>4 4gt
:nmap <leader>5 5gt
:nmap <leader>6 6gt
:nmap <leader>7 7gt
:nmap <leader>8 8gt
:nmap <leader>9 9gt

" Save all files and build
":nmap <leader>cc :AsyncRun -save=2 BUILDCOMMAND<CR>
":nmap <leader>cC :AsyncRun -save=2 BUILDCOMMAND

" Open and close the quickfix window
:nmap <leader>co :copen<CR>
:nmap <leader>ch :cclose<CR>

" Previous buffer
:nmap <leader><Tab> <C-^>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Enable smart pairs (e.g. parenthesis, brackets and stuff)
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

" Open quickfix window when building and let it scroll
let g:asyncrun_open = 20
let g:asyncrun_last = 2

" Customize git gutter
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_diff_args = '--diff-algorithm=histogram'

" Vim-plug
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'             " Sensible default settings.
Plug 'tpope/vim-commentary'           " Comment out stuff with gc.
Plug 'tpope/vim-unimpaired'           " More bindings for square brackets.
Plug 'tpope/vim-repeat'               " Let plugins repeatsuff with dot.
Plug 'tpope/vim-abolish'              " Preserve case substitute neatly with :S.
Plug 'machakann/vim-sandwich'         " Surround stuff with sa, sd and sr.
Plug 'junegunn/vim-easy-align'        " Align stuff with ga.
Plug 'junegunn/vim-peekaboo'          " See what's stored in registers.
Plug 'ntpeters/vim-better-whitespace' " StripWhitespace for trailing spaces
Plug 'nathanalderson/yang.vim'        " YANG syntax.
Plug 'wellle/targets.vim'             " Add more targets, like cia (in argument).
Plug 'ericcurtin/CurtineIncSw.vim'    " Toggle header/src (C/C++).
Plug 'moll/vim-bbye'                  " Close and delete buffers (Bdelete/Bwipeout).
Plug 'tmsvg/pear-tree'                " Pair parenthesis automagically (alt. jiangmiao/auto-pairs).
Plug 'chaoren/vim-wordmotion'         " Delimit words by underscores and camelcases.
Plug 'sheerun/vim-polyglot'           " Massive language pack (syntax highlight everything).
Plug 'tpope/vim-fugitive'             " A lot of GIT.
Plug 'skywind3000/asyncrun.vim'       " Asyncronous building.
Plug 'itchyny/lightline.vim'          " Status line.
Plug 'vim-scripts/DoxygenToolkit.vim' " Generate doxygen headers.
Plug 'arcticicestudio/nord-vim'       " Nord theme.
Plug 'airblade/vim-gitgutter'         " Git diff in the sign column.

" Clang format with bug fix for Neovim 0.5.0.
Plug 'Kypert/vim-clang-format', { 'branch' : 'fix/issues/98' }

" LSP client for references, definitions, renaming etc.
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Fuzzy find.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

" Colorscheme
let g:nord_cursor_line_number_background = 1
let g:lightline = { 'colorscheme': 'nord' }
colorscheme nord

" Give git gutter reasonable key bindings.
:nmap ghs <Plug>(GitGutterStageHunk)
:nmap ghu <Plug>(GitGutterUndoHunk)
:nmap ghp <Plug>(GitGutterPreviewHunk)

" Make targets.vim prefer multiline targets, in order to correctly operate
" on the first argument after a line break in a multiline argument list.
let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr lb ar ab lB Ar aB Ab AB rr ll rb al rB Al bb aa bB Aa BB AA'

" Make vim-sandwich use vim-surround keybindings in order to not steal 's'.
runtime macros/sandwich/keymap/surround.vim

" Make vim-peekaboo live in a floating window instead of in a split.
function! CreateCenteredFloatingWindow()
    let width = float2nr(&columns * 0.6)
    let height = float2nr(&lines * 0.6)
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}
    let top = '╭' . repeat('─', width - 2) . '╮'
    let mid = '│' . repeat(' ', width - 2) . '│'
    let bot = '╰' . repeat('─', width - 2) . '╯'
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction
let g:peekaboo_window = 'call CreateCenteredFloatingWindow()'
let g:peekaboo_delay = 0

" CCLS LSP Setup
"let ccls_path = '/path/to/ccls'
"let g:LanguageClient_serverCommands = {
"    \ 'c': [ccls_path, '--log-file=/tmp/cc.log'],
"    \ 'cpp': [ccls_path, '--log-file=/tmp/cc.log'],
"    \ }

"let g:LanguageClient_loadSettings = 1
"let g:LanguageClient_settingsPath = expand('~/.config/nvim/lsp_settings.json')

" https://github.com/autozimu/LanguageClient-neovim/issues/379 LSP snippet is not supported
let g:LanguageClient_hasSnippetSupport = 0

:nmap <leader>gg :call LanguageClient_contextMenu()<CR>
:nmap <leader>gd :call LanguageClient#textDocument_definition()<CR>
:nmap <leader>gr :call LanguageClient#textDocument_references({'includeDeclaration': v:false})<CR>
:nmap <leader>gR :call LanguageClient#findLocations({'method':'$ccls/call'})<CR>
nn <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
let g:LanguageClient_hoverPreview = 'Always'
let g:LanguageClient_useVirtualText = 'Diagnostics'

" Clang format setup
" let g:clang_format#detect_style_file = 1
" let g:clang_format#auto_formatexpr = 1 " Added as gq
" let g:clang_format#command = '/path/to/clang-format'

" let g:clang_format#style_options = {
"             \ "AccessModifierOffset" : -4,
"             \ "AllowShortIfStatementsOnASingleLine" : "true",
"             \ "AlwaysBreakTemplateDeclarations" : "true",
"             \ "Standard" : "C++11",
"             \ "BreakBeforeBraces" : "Stroustrup"}
