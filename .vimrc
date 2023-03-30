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
" Plug 'lifepillar/vim-gruvbox8'
" Plug 'vim-airline/vim-airline-themes' 
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
" Plug 'chriskempson/base16-vim'
" Plug 'lifepillar/vim-solarized8'
" Plug 'sainnhe/everforest'
" Plug 'Rigellute/rigel'
" Plug 'whatyouhide/vim-gotham'

""" language support """""""""""""""""""""""""""""
Plug 'lervag/vimtex'
Plug 'vim-python/python-syntax'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'cespare/vim-toml', { 'branch': 'main' }
Plug 'dag/vim-fish'
Plug 'fatih/vim-go'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'quarto-dev/quarto-vim'
" Plug 'mattn/vim-sqlfmt'

""" productivity """""""""""""""""""""""""""""""""
" Plug 'vim-airline/vim-airline' 
" Plug 'nvim-lualine/lualine.nvim'
Plug 'itchyny/lightline.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'dense-analysis/ale'
" Plug 'jmcantrell/vim-virtualenv'
Plug 'vim-autoformat/vim-autoformat'
" Plug 'rhysd/vim-grammarous'
" Plug 'vimwiki/vimwiki'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'jupyter-vim/jupyter-vim'
" Plug 'sillybun/vim-repl'
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
" Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
" Plug 'nvim-tree/nvim-tree.lua'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'

""" other """"""""""""""""""""""""""""""""""""""""
" Plug 'lukas-reineke/virt-column.nvim'
" Plug 'ryanoasis/vim-devicons'
Plug 'thanthese/Tortoise-Typing'

call plug#end()
""" end vim-plug

""" general settings """""""""""""""""""""""""""""
set nocompatible
filetype plugin on

" settings.colorscheme
set termguicolors
set background=dark
syntax enable
" colorscheme gruvbox8
colorscheme catppuccin-macchiato

" settings.syntax
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
set showtabline=2
" set list
" set listchars=tab:›\ ,eol:¬,trail:⋅

""" filetype settings """"""""""""""""""""""""""""
" filetype.python
autocmd FileType python setlocal tabstop=4 shiftwidth=4 smarttab expandtab

" filetype.yaml
autocmd FileType yaml setlocal textwidth=60 colorcolumn=60

""" plugin settings """"""""""""""""""""""""""""""
" plugin.vim-gruvbox8
let g:gruvbox_transp_bg = 1

" plugin.vim-airline
" let g:airline_theme = 'gruvbox8'
let g:airline_highlighting_cache = 1
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" plugin.lightline.vim
set noshowmode
let g:lightline = {'colorscheme': 'catppuccin'}

" " plugin.vim-repl
" let g:repl_program = {
"             \   'python': 'python',
"             \   'default': 'zsh',
"             \   'r': 'R',
"             \   'lua': 'lua',
"             \   'vim': 'vim -e',
" 	    \   'julia': 'julia',
"             \   }
" let g:repl_predefine_python = {
"             \   'numpy': 'import numpy as np',
"             \   'matplotlib': 'from matplotlib import pyplot as plt',
"             \   'pandas': 'import pandas as pd'
"             \   }
" let g:repl_position = 0 """ bottom
" let g:repl_python_pre_launch_command = 'source ~/.venv/replenv/bin/activate'
" let g:repl_python_auto_import = 0

" plugin.vimtex
let g:vimtex_view_method = 'zathura'
let g:vimtex_format_enabled = 1
let g:vimtex_grammar_textidote = {
    \ 'jar': '/usr/share/java/textidote.jar',
    \ 'args': '',
    \}
" " plugin.markdown-preview
" let g:mkdp_browser = 'chromium'

" plugin.ale
let g:ale_linters = {
\   'python': ['pyright'],
\   'r': ['lintr'],
\}

" plugin.coc-ltex
let g:coc_filetype_map = {'tex': 'latex'}

" " plugin.vimwiki
" let g:vimwiki_list = [{'path': '~/.vimwiki/',
"                       \ 'syntax': 'markdown', 'ext': '.md'}]

" plugin.vim-autoformat
let g:python3_host_prog='/usr/bin/python'

" plugin.coc-nvim
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
