set nocompatible
" filetype off
filetype plugin indent on

set ttyfast

set laststatus=2
set statusline=
set statusline +=%4*\ %<%f%*            "full path
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines

set encoding=utf-8              " Set default encoding to UTF-8
set autoread                    " Automatically reread changed files without asking me anything
set autoindent
set tabstop=2                   " Set tab size to 2 spaces
set shiftwidth=2                " Set indent size to 2 spaces
set expandtab                   " Use spaces instead of tabs
set backspace=indent,eol,start  " Makes backspace key more powerful.
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set mouse=                       "disable mouse mode

set noerrorbells             " No beeps
set number                   " Show line numbers
set showcmd                  " Show me what I'm typing
set noswapfile               " Don't use swapfile
set nobackup                 " Don't create annoying backup files
set splitright               " Split vertical windows right to the current windows
set splitbelow               " Split horizontal windows below to the current windows
set autowrite                " Automatically save before :next, :make etc.
set hidden
set ignorecase               " Search case insensitive...
set smartcase                " ... but not it begins with upper case
set nocursorcolumn           " speed up syntax highlighting
set nocursorline
set updatetime=300
set cmdheight=2
set pumheight=10             " Completion window max size
set conceallevel=2           " Concealed text is completely hidden
" set colorcolumn=120

set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " If Vim beeps during completion

set lazyredraw

"http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
" set clipboard^=unnamed
" set clipboard^=unnamedplus

" increase max memory to show syntax highlighting for large files
set maxmempattern=20000

" ~/.viminfo needs to be writable and readable. Set oldfiles to 1000 last
" recently opened files, :FzfHistory uses it
set viminfo='1000
" set list
" set listchars=tab:>-

let mapleader = ","

command! -nargs=* W w


" PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/molokai'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'sunaku/vim-ruby-minitest'
Plug 'github/copilot.vim'
Plug 'junegunn/goyo.vim'
Plug 'prisma/vim-prisma'
Plug 'junegunn/seoul256.vim'
Plug 'wakatime/vim-wakatime'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
call plug#end()

" colorscheme
syntax enable
set re=0

" set signcolumn=yes
highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
highlight clear SignColumn
highlight Pmenu ctermbg=240 ctermfg=7

set termguicolors
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_sign_column = "dark0_hard"

let g:seoul256_background = 236
let g:seoul256_srgb = 1
colorscheme seoul256
set background=dark

" fzf
nnoremap <silent> <C-p> :GFiles --cached --others --exclude-standard<CR>
nnoremap <silent> <C-z> :FZF<CR>
" nnoremap <silent> <C-p> :FZF<CR>
let g:fzf_layout = { 'down': '~20%' }

" vim-go

let g:go_fmt_fail_silently = 1
let g:go_debug_windows = {
      \ 'vars':  'leftabove 35vnew',
      \ 'stack': 'botright 10new',
\ }

let g:go_test_show_name = 1
let g:go_list_type = "quickfix"

let g:go_autodetect_gopath = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_enabled = ['vet', 'golint']

let g:go_gopls_complete_unimported = 1

" 2 is for errors and warnings
let g:go_diagnostics_level = 2
let g:go_doc_popup_window = 1

let g:go_imports_mode="gopls"
let g:go_imports_autosave=1

let g:go_highlight_build_constraints = 1
let g:go_highlight_operators = 1
" let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_def_mapping_enabled = 0
let g:go_fold_enable = []

autocmd FileType go nmap <Leader>i <Plug>(go-info)

" copilot
" disable by default
let g:copilot_enabled = v:false

" COC
let g:coc_global_extensions = ['coc-tsserver', 'coc-pyright', 'coc-diagnostic']

inoremap <silent><expr> <c-@> coc#refresh()	" Use <c-space> to trigger completion.

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gv :vsp<cr><Plug>(coc-definition)

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" map rails commands
autocmd User Rails nmap <buffer> <Leader>f :vert sfind <Plug><cfile><CR>
" map alternate file command :A to open in vertical split
nmap <Leader>a :vsp<cr>:A<CR>
nmap <Leader>r :vsp<cr>:R<CR>
