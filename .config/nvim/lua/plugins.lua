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
  use { 'neovim/nvim-lspconfig' }
  use ({ 'hrsh7th/nvim-cmp',
    config = [[require('config.cmp')]], -- may very based on config
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'L3MON4D3/LuaSnip', -- may very based on config
      'onsails/lspkind-nvim',
    }
  })
  use { 'nvim-lualine/lualine.nvim' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-fugitive' }
  -- use { 'dense-analysis/ale' }
  -- use { 'neoclide/coc.nvim', branch = 'release' }
  use { 'godlygeek/tabular' }
  use { 'preservim/vim-markdown' }

end)

