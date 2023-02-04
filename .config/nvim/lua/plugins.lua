-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- colorschemes
  use { 'catppuccin/nvim', as = 'catppuccin' }

  -- language support
  use { 'lervag/vimtex' }
  use { 'vim-python/python-syntax' }
  use { 'JuliaEditorSupport/julia-vim' }
  use { 'dag/vim-fish' }
  use { 'fatih/vim-go' }
  use { 'vim-pandoc/vim-pandoc-syntax' }
  use { 'quarto-dev/quarto-vim' }

  -- productivity
  use { 'nvim-lualine/lualine.nvim' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-fugitive' }
  use { 'dense-analysis/ale' }
  use { 'neoclide/coc.nvim', branch = 'release' }
  use { 'godlygeek/tabular' }
  use { 'preservim/vim-markdown' }

end)

