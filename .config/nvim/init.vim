if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=utf-8,latin1
endif

set list listchars=tab:>\ ,trail:-,eol:$
set nolist

" Relative/hybrid line numbering.
set relativenumber
set number

" Tabs are four spaces.
set tabstop=4
set shiftwidth=4
set expandtab

" Case insensitive-ish search.
set ignorecase
set smartcase

" Highlight the current line.
set cursorline

" Align function arguments.
set cino+=(0

" Split new windows below or to the right.
set splitbelow
set splitright

" Live substitutions.
set inccommand=nosplit

" Make things such as git gutter update more quickly.
set updatetime=100

" Always show sign column/git gutter.
set signcolumn=yes

" Remap movement keys to use CamelCaseMotion
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge
omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie

" Spell check comments please.
set spell

" Vim-plug.
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'             " Sensible default settings.
Plug 'tpope/vim-commentary'           " Comment out stuff with gc.
Plug 'tpope/vim-unimpaired'           " More bindings for square brackets.
Plug 'tpope/vim-repeat'               " Let plugins repeatsuff with dot.
Plug 'tpope/vim-abolish'              " Preserve case substitute neatly with :S.
Plug 'machakann/vim-sandwich'         " Surround stuff with sa, sd and sr.
Plug 'junegunn/vim-easy-align'        " Align stuff with ga.
Plug 'junegunn/vim-peekaboo'          " See what's stored in registers.
Plug 'ntpeters/vim-better-whitespace' " StripWhitespace for trailing spaces.
Plug 'nathanalderson/yang.vim'        " YANG syntax.
Plug 'wellle/targets.vim'             " Add more targets, like cia (in argument).
Plug 'ericcurtin/CurtineIncSw.vim'    " Toggle header/src (C/C++).
Plug 'tmsvg/pear-tree'                " Pair parenthesis automagically (alt. jiangmiao/auto-pairs).
Plug 'bkad/CamelCaseMotion'           " Delimit words by underscores without redrawing the terminal.
Plug 'sheerun/vim-polyglot'           " Massive language pack (syntax highlight everything).
Plug 'tpope/vim-fugitive'             " A lot of GIT.
Plug 'itchyny/lightline.vim'          " Status line.
Plug 'vim-scripts/DoxygenToolkit.vim' " Generate doxygen headers.
Plug 'arcticicestudio/nord-vim'       " Nord theme.
Plug 'airblade/vim-gitgutter'         " Git diff in the sign column.
Plug 'neovim/nvim-lspconfig'          " Decent default configs for the builtin LSP.

" Telescope and friends.
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Clang format with bug fix for Neovim 0.5.0.
Plug 'Kypert/vim-clang-format', { 'branch' : 'fix/issues/98' }

call plug#end()

" Highlight lines overflowing 120 characters.
autocmd FileType c,cpp,python,vim,bash,yaml call matchadd('ErrorMsg', "\\%120v.\\+", 100)

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid, when inside an event handler
" (happens when dropping a file on gvim) and for a commit message (it's
" likely a different one than last time).
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" Only show cursor line in active window.
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" Copy to the end of line.
noremap Y y$

" Use space as leader key.
let mapleader = "\<Space>"

" Quickly remove search highlighting.
nnoremap <leader><leader> :nohlsearch<CR>

" Jumping between header and source.
nnoremap <leader>fa :call CurtineIncSw()<CR>

" Git blaming.
nnoremap <leader>gb :Git blame<CR>

" Saving and quitting.
nnoremap <leader>qa :qa<CR>
nnoremap <leader>qa! :qa!<CR>
nnoremap <leader>q! :q!<CR>
nnoremap <leader>w! :w!<CR>

" Snappy window switching.
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" Less snappy window switching.
nnoremap <leader>wh <C-w>h
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k
nnoremap <leader>wl <C-w>l
nnoremap <leader>wp <C-w>p

" Opening and closing windows.
nnoremap <leader>wc <C-w>c
nnoremap <leader>w/ :vs<CR>
nnoremap <leader>w- :sp<CR>

" Navigating tabs.
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>T :tabclose<CR>
nnoremap <leader>n gt
nnoremap <leader>p gT
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

" Open and close the quickfix window.
nnoremap <leader>co :copen<CR>
nnoremap <leader>ch :cclose<CR>

" Previous buffer.
nnoremap <leader><Tab> <C-^>

" Telescope navigation.
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>bb :Telescope buffers<CR>
nnoremap <leader>fe :Telescope file_browser dir_icon=+<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>* :Telescope grep_string search=<C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>/ :Telescope grep_string search=<C-R>=expand("<cword>")<CR>

" LSP actions.
nnoremap <leader>gr :Telescope lsp_references<CR>
nnoremap <leader>gd :Telescope lsp_definitions<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga).
xnoremap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip).
nnoremap ga <Plug>(EasyAlign)

" Enable smart pairs (e.g. parenthesis, brackets and stuff).
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1
let g:pear_tree_ft_disabled = ["TelescopePrompt"]

" Customize git gutter
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_diff_args = '--diff-algorithm=histogram'

" Colorscheme.
let g:nord_cursor_line_number_background = 1
let g:lightline = { 'colorscheme': 'nord' }
colorscheme nord

" Give git gutter reasonable key bindings.
nnoremap ghs <Plug>(GitGutterStageHunk)
nnoremap ghu <Plug>(GitGutterUndoHunk)
nnoremap ghp <Plug>(GitGutterPreviewHunk)

" Make targets.vim prefer multiline targets, in order to correctly operate.
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

lua << EOS
-- LSP keybindings.
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

-- Fuzzy finding in telescope.
require('telescope').load_extension('fzf')

-- Attempt to run CCLS with builtin LSP. Make sure CCLS is in the path.
require('lspconfig').clangd.setup{}

-- Map ESC to quit telescope when in insert mode.
local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous
      },
    },
  }
}
EOS
