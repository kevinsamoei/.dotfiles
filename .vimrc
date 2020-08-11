syntax on
set number
set tabstop=4
set shiftwidth=4
set expandtab
set ai
set hlsearch
set ruler
set paste
highlight Comment ctermfg=green
set backspace=indent,eol,start

" vim-plug section

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
" Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release'}
" Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'connorholyday/vim-snazzy'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
call plug#end()

" fzf
nnoremap <C-f> :FZF <CR>

" YouCompleteMe settings

" let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
" let g:ycm_key_list_select_completion = [ '<C-n>', '<Down>' ]
" let g:ycm_key_list_previous_completion = [ '<C-p>', '<Up>' ]
" let g:SuperTabDefaultCompletionType = '<C-n>'
" set completeopt-=preview
" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

set background=dark
colorscheme snazzy

