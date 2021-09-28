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
" Plug 'lifepillar/vim-gruvbox8'
" Plug 'Rigellute/rigel'
" Plug 'whatyouhide/vim-gotham'

""" language support """""""""""""""""""""""""""""
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'vim-python/python-syntax'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'lervag/vimtex'

""" productivity """""""""""""""""""""""""""""""""
Plug 'vim-airline/vim-airline' 
Plug 'tpope/vim-commentary'
Plug 'vim-syntastic/syntastic'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jmcantrell/vim-virtualenv'
Plug 'sillybun/vim-repl'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

call plug#end()
""" end vim-plug

""" general settings """""""""""""""""""""""""""""
" settings.colorscheme
set termguicolors
set background=dark
syntax enable
colorscheme solarized8 
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

" chezmoi
" Source: https://www.chezmoi.io/docs/how-to/#integrate-chezmoi-with-your-editor
" autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path %

""" plugin settings """"""""""""""""""""""""""""""
" plugin.vim-airline
let g:airline_theme='base16_solarized_dark'
let g:airline_powerline_fonts = 1
let g:airline_highlighting_cache = 1
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#tabline#enabled = 1

" plugin.python-mode
let g:pymode_lint_cwindow = 0
let g:pymode_virtualenv = 1

" plugin.vim-markdown-preview
let vim_markdown_preview_use_xdg_open=1
let vim_markdown_preview_browser='Firefox'

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
            \   'matplotlib': 'from matplotlib import pyplot as plt'
            \   }
let g:repl_position = 0 """ bottom
let g:repl_python_pre_launch_command = 'source ~/.venv/replenv/bin/activate'
let g:repl_python_auto_import = 0

" plugin.vimtex
let g:vimtex_view_method = 'zathura'
let g:vimtex_format_enabled = 1

" plugin.vim-slime
let g:slime_target = 'kitty'

" plugin.markdown-preview
let g:mkdp_browser = 'luakit'
