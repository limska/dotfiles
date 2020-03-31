"==============================================================================
" PLUG (MUST BE FIRST)
"==============================================================================
" bootstrap plugin installation
if empty(glob('$HOME/.vim/autoload/plug.vim'))
    silent !curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('$HOME/.vim/plugged')

"==============================================================================
" GENERAL SETTINGS
"==============================================================================
set mouse=a " Allows clicking with the mouse to move the cursor
set ttymouse=sgr " Needed for mouse to work in Windows terminal
set showcmd " Show partial commands in last line of screen
set nowrap " Display long lines as just one line
"set list listchars=tab:→\ ,nbsp:•,trail:•
set list listchars=tab:>\ 
set encoding=utf8
set nobackup " Do not create ~ files
set backupcopy=yes
set backspace=indent,eol,start " Make backspace behave correctly
set number
set laststatus=2

colorscheme koehler

nnoremap )) :set number!<CR>
nnoremap MM <esc>:make<cr>
nnoremap <F9> :call ShowTabToggle()<cr>

function! ShowTabToggle()
  if &list
    set nolist
    set tabstop=4
  else
    "set list listchars=tab:→\ ,nbsp:•,trail:•
    set list listchars=tab:>\ 
    set tabstop=2
  endif
endfunction

"==============================================================================
" SEARCH SETTINGS
"==============================================================================
set ignorecase
set smartcase
set hlsearch
set incsearch

"==============================================================================
" TAB AND INDENTATION SETTINGS
"==============================================================================
set smartindent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

"==============================================================================
" STOP BEEPING
"==============================================================================
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

"==============================================================================
" DIFF HOTKEYS
"==============================================================================
nnoremap <F12> <esc>:diffput<CR>
nnoremap <F10> <esc>:diffget<CR>

"==============================================================================
" GIT INTEGRATION
"==============================================================================
Plug 'tpope/vim-fugitive'
nnoremap gr :Ggrep <cword> <CR>

"==============================================================================
" IMPROVED QUICKFIX LIST
"==============================================================================
Plug 'romainl/vim-qf'

nmap cn <Plug>(qf_qf_next)
nmap cp <Plug>(qf_qf_previous)

"==============================================================================
" SWITCH BETWEEN HEADER AND IMPLEMENTATION
"==============================================================================
Plug 'derekwyatt/vim-fswitch'
nnoremap <F2> :FSHere<cr>

"==============================================================================
" LOCAL CONFIGURATION SUPPORT
"==============================================================================
Plug 'embear/vim-localvimrc'
let g:localvimrc_ask=0
let g:localvimrc_sandbox=0

"==============================================================================
" FUZZY FINDER
"==============================================================================
Plug 'junegunn/fzf', { 'dir': '$HOME/.fzf.git', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

nnoremap <c-p><c-p>
    \ :GFiles<CR>

nnoremap <c-p><c-b>
    \ :BLines<CR>

nnoremap <c-p><c-f>
    \ :call fzf#vim#gitfiles('.', {'options':'--query '.expand('<cword>')})<CR>

nnoremap <c-p><c-i>
    \ :call fzf#vim#grep(
    \ 'git grep --line-number '.shellescape(expand('<cword>')),
    \ 0, 0)<CR>

"==============================================================================
" OTHER PLUGINS
"==============================================================================
Plug 'scrooloose/nerdcommenter' " Commenting maps
Plug 'Valloric/vim-operator-highlight' " Operator syntax highlighting
Plug 'bfrg/vim-cpp-modern' " Improved C++ highlighting
Plug 'breuckelen/vim-resize' " Resize pane maps

"==============================================================================
" YouCompleteMe
"==============================================================================
"Plug 'valloric/youcompleteme'
"let g:ycm_global_ycm_extra_conf = "/u/cd8rit/src/starccm/dev/.ycm_extra_conf.py"

" Apply YCM FixIt
"map <F8> :YcmCompleter FixIt<CR>
=======

"---------------------------------------
" NERDTree - File system explorer plugin
"---------------------------------------
Plug 'scrooloose/nerdtree'

" CTRL-n opens file system explorer NERDTree
map <C-n> :NERDTreeToggle<CR>

" Closes window if NERDTree is last remained open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"------------------------------
" IMPROVED C++ SYNTAX HIGHLIGHT
"------------------------------
Plug 'octol/vim-cpp-enhanced-highlight'

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1

"---------------------------------------
" Vim-Airline - Status bar customization
"---------------------------------------
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'powerline/fonts'

let g:airline_theme='violet'

" use powerline fonts
let g:airline_powerline_fonts = 1


if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''

"==============================================================================
" PLUG END HOOK (MUST BE LAST)
"==============================================================================
call plug#end()
