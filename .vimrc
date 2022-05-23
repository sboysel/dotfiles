""""""""""""""""""""""""""""""""""""""""""""""""""
"
" @@@  @@@  @@@  @@@@@@@@@@   @@@@@@@    @@@@@@@  
" @@@  @@@  @@@  @@@@@@@@@@@  @@@@@@@@  @@@@@@@@  
" @@!  @@@  @@!  @@! @@! @@!  @@!  @@@  !@@       
" !@!  @!@  !@!  !@! !@! !@!  !@!  @!@  !@!       
" @!@  !@!  !!@  @!! !!@ @!@  @!@!!@!   !@!       
" !@!  !!!  !!!  !@!   ! !@!  !!@!@!    !!!       
" :!:  !!:  !!:  !!:     !!:  !!: :!!   :!!       
"  ::!!:!   :!:  :!:     :!:  :!:  !:!  :!:       
"   ::::     ::  :::     ::   ::   :::   ::: :::  
"    :      :     :      :     :   : :   :: :: :                                 
"
" ~/.vimrc
" Author: Sam Boysel
""""""""""""""""""""""""""""""""""""""""""""""""""

" make ale and coc.nvim play nicely
" https://github.com/dense-analysis/ale#5iii-how-can-i-use-ale-and-cocnvim-together
let g:ale_disable_lsp = 1

""" install vim-plug """""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $VIMRC
endif

""" being vim-plug """""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

""" colorschemes """""""""""""""""""""""""""""""""
Plug 'lifepillar/vim-solarized8'
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline-themes' 
Plug 'lifepillar/vim-gruvbox8'
Plug 'sainnhe/everforest'
" Plug 'tribela/vim-transparent'
" Plug 'Rigellute/rigel'
" Plug 'whatyouhide/vim-gotham'

""" language support """""""""""""""""""""""""""""
Plug 'vim-python/python-syntax'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'lervag/vimtex'
Plug 'cespare/vim-toml', { 'branch': 'main' }
Plug 'dag/vim-fish'

""" productivity """""""""""""""""""""""""""""""""
Plug 'vim-airline/vim-airline' 
Plug 'tpope/vim-commentary'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jmcantrell/vim-virtualenv'
Plug 'jupyter-vim/jupyter-vim'
Plug 'sillybun/vim-repl'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'vimwiki/vimwiki'

""" other """"""""""""""""""""""""""""""""""""""""
" Plug 'ryanoasis/vim-devicons'

call plug#end()
""" end vim-plug

""" general settings """""""""""""""""""""""""""""
set nocompatible
filetype plugin on

" settings.colorscheme
set termguicolors
set background=dark
syntax enable
colorscheme gruvbox8

let g:python_highlight_all=1

" settings.editor
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set textwidth=80	" width of text area limited to 80 char
set colorcolumn=80
set cursorline		" highlight cursor line
set number 		" line numbers
set noswapfile
set foldmethod=indent	" enable code folding
set foldlevel=99

""" filetype settings """"""""""""""""""""""""""""
" filetype.python
autocmd FileType python setlocal tabstop=4 shiftwidth=4 smarttab expandtab

" filetype.yaml
autocmd FileType yaml setlocal textwidth=60 colorcolumn=60

""" plugin settings """"""""""""""""""""""""""""""
" plugin.vim-gruvbox8
let g:gruvbox_transp_bg = 1

" plugin.vim-airline
let g:airline_theme = 'gruvbox8'
let g:airline_highlighting_cache = 1
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#tabline#enabled = 1
" let g:airline_powerline_fonts = 1

" plugin.vim-repl
let g:repl_program = {
            \   'python': 'python',
            \   'default': 'zsh',
            \   'r': 'R',
            \   'lua': 'lua',
            \   'vim': 'vim -e',
	    \   'julia': 'julia',
            \   }
let g:repl_predefine_python = {
            \   'numpy': 'import numpy as np',
            \   'matplotlib': 'from matplotlib import pyplot as plt',
            \   'pandas': 'import pandas as pd'
            \   }
let g:repl_position = 0 """ bottom
let g:repl_python_pre_launch_command = 'source ~/.venv/replenv/bin/activate'
let g:repl_python_auto_import = 0

" plugin.vimtex
let g:vimtex_view_method = 'zathura'
let g:vimtex_format_enabled = 1

" plugin.markdown-preview
let g:mkdp_browser = 'chromium'

" plugin.ale
let g:ale_linters = {
\   'python': ['pyright'],
\   'r': ['lintr'],
\}
