set nocompatible              " required
filetype off                  " required

let mapleader = "`"
" set the runtime path to include Vundle and initialize
"------------------------------------------------------------------------------
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Bundle 'SirVer/ultisnips'
Bundle 'rhysd/vim-clang-format'
Bundle 'honza/vim-snippets'
Bundle 'majutsushi/tagbar'
Bundle 'Gundo'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'

Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'

" linter for python
Plugin 'w0rp/ale'

Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Bundle 'flazz/vim-colorschemes'
Bundle 'davidhalter/jedi-vim'
Bundle 'Conque-GDB'
Bundle 'DirDiff.vim'
Plugin 'gmarik/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
" Must be clang package installed
Bundle 'Rip-Rip/clang_complete'
"Lean & mean status/tabline for vim that's light as air.
"Bundle 'powerline/powerline'
Bundle 'powerline/fonts'

" Add all your plugins here (note older versions of Vundle used Bundle instead
" of Plugin)

" All of your Plugins must be added before the following line
call vundle#end()            " required
"------------------------------------------------------------------------------
filetype plugin indent on    " required

set splitbelow
set splitright

"split navigations
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

" Enable folding
"------------------------------------------------------------------------------
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

let g:SimpylFold_docstring_preview=1
"------------------------------------------------------------------------------

" Basic configuration
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
set autoread
set backspace=indent,eol,start
set lcs=trail:·,tab:>>,nbsp:·
set softtabstop=2
set tabstop=8
set autoindent
set shiftwidth=2
set smarttab
set smartindent
set expandtab
set list
set number
set laststatus=2
set notextmode
set ignorecase
set smartcase
set encoding=utf-8
set nu

" Highlight search results
set hlsearch
map <F3> :set invhlsearch<CR>

" C-s to save
:nmap <C-s> :update<CR>
:imap <C-s> <Esc>:update<CR>

"Scroll the tabs
map <F5> :tabp<CR>
map <F6> :tabn<CR>
map <F12> :%s/\\n/\r/g<CR>

nnoremap <Leader>f :grep -r <cword> <CR>

"Mouse support
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

""There is an awesome script that loads some cscope mappings. Source it here
if !empty(glob("~/.vim/cscope_maps.vim"))
     source ~/.vim/cscope_maps.vim
 endif

" Man pages in Vim!
runtime! ftplugin/man.vim
set tags=./tags; "Recursively look for tags

"Commonly used tags: stl, libc...
set tags+=$HOME/.vim/cpp_tags
set tags+=$HOME/.vim/asio_tags
set path=.,,,** "Path is buffer path, current path (<**> means recursive)
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

"NerdTree configuration
"------------------------------------------------------------------------------
map <F6> :NERDTreeFind<CR>

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
" Encoding to utf-8 and NERDTree to use + and - instead of fancy arrows
let g:NERDTreeDirArrows=0
"------------------------------------------------------------------------------

" Pathogen pluggin
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 execute pathogen#infect()
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

" Persistent undo
"------------------------------------------------------------------------------
try
    set undodir=$HOME/.vim/.undodir
    set undofile
    set undolevels=500
catch
endtry
"------------------------------------------------------------------------------

"python with virtualenv support

let python_highlight_all=1
syntax on

call togglebg#map("<F5>")

" Change register by default while copy
" We have to check if we have the correct version
" vim --version | grep clipboard
" http://vim.wikia.com/wiki/Accessing_the_system_clipboard
" Section Checking for X11-clipboard support in terminal
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
set clipboard=unnamedplus

"Change register when delete
nnoremap x "-x
nnoremap X "-X
nnoremap d "-d
nnoremap D "-D
vnoremap d "-d

"Paste register - when push - key before paste
nnoremap -p "-p
nnoremap -P "-P
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

"set editing-mode vi

" Remove trailing spaces on save file
autocmd FileType * autocmd BufWritePre <buffer> :%s/\s\+$//e

" colors
"------------------------------------------------------------------------------
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

if match($TERMCAP, 'Co#256:') == 0 || match($TERMCAP, ':Co#256:') > 0
    set t_Co=256
endif

let simplecolor=$AM_VIM_SIMPLECOLOR
if simplecolor == '1'
    colorscheme desert
else
    colorscheme jelleybeans
endif

if &diff
    colorscheme jellybeans
endif
"------------------------------------------------------------------------------

"Ultisnippets configuration
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
let &path.="~/projects/tecos,/usr/include,/usr/include/AL"

let g:UltiSnipsExpandTrigger="<Leader>s"
let g:UltiSnipsJumpForwardTrigger="<Leader>d"
let g:UltiSnipsJumpBackwardTrigger="<Leader>a"
let g:UltiSnipsEditSplit="vertical"

let g:SimplyFold_docstring_preview=1

let python_highlight_all=1

set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

" Clang complete configuration (autocompletion)
"------------------------------------------------------------------------------
" clang
let g:clang_library_path='/usr/lib/llvm-5.0/lib/libclang.so.1'

set conceallevel=2
set concealcursor=vin
let g:clang_snippets=1
let g:clang_conceal_snippets=1
let g:clang_snippets_engine='clang_complete'
let g:clang_user_options="-std=c++14 -stdlib=libc++"
let g:clang_user_options.=" -I."
let g:clang_user_options.=" -I/usr/include/c++/"

" Complete options (disable preview scratch window, longest removed to aways show menu)
set completeopt=menu,menuone

" Limit popup menu height
set pumheight=20

" SuperTab completion fall-back
let g:SuperTabDefaultCompletionType='<c-x><c-u><c-p>'
"------------------------------------------------------------------------------

" Clang format configurator
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
let g:clang_format#style_options = {
            \ "BasedOnStyle": "LLVM",
            \ "BreakBeforeBraces": "Allman",
            \ "ColumnLimit": 80,
            \ "IndentCaseLabels": "true",
            \ "PointerAlignment": "Left"}

" map to <Leader>a in C++ code
autocmd FileType c,cpp,hpp,h nnoremap <buffer><Leader>a :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,hpp,h vnoremap <buffer><Leader>a :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,hpp,h map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

let g:clang_format#auto_format = 1

map <F2> :noh<CR>
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

" Ctrlp configuration
"------------------------------------------------------------------------------
map <Leader>b :CtrlPBuffer<CR>
map <Leader>w :CtrlPMixer<CR>
"------------------------------------------------------------------------------

" Vim-Airline configuration
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Enable the list of buffers
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"


let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

" Tabs configuration to show upwindow
"------------------------------------------------------------------------------
" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>
"------------------------------------------------------------------------------

"Toggle Configuration
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
map <F4> :TagbarToggle<CR>
nnoremap <Leader>u :GundoToggle<CR>
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

"Lintern for python
"------------------------------------------------------------------------------
let b:ale_linters = ['flake8', 'pylint']
let g:ale_emit_conflict_warnings = 0
"------------------------------------------------------------------------------
