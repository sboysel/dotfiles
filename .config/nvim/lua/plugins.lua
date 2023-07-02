-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- colorschemes
  use { 'catppuccin/nvim', as = 'catppuccin' }
  use { 'rebelot/kanagawa.nvim' }
  use { 'neanias/everforest-nvim' }

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
  use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
  use ({ 'hrsh7th/nvim-cmp',
    -- config = [[require('config.cmp')]], -- may very based on config
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-vsnip', -- may very based on config
      'hrsh7th/vim-vsnip',
    }
  })
  use { 'nvim-lualine/lualine.nvim' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'nvim-tree/nvim-tree.lua' }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-fugitive' }
  use { 'jpalardy/vim-slime' }
  -- use { 'dense-analysis/ale' }
  -- use { 'neoclide/coc.nvim', branch = 'release' }
  use { 'godlygeek/tabular' }
  use { 'preservim/vim-markdown' }
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    -- or                            , branch = '0.1.x',
    requires = { 
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim'
    }
  }
  use {
      'nvim-treesitter/nvim-treesitter',
      run = function()
          local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
          ts_update()
      end,
  }
  use { 'folke/zen-mode.nvim' }
  use { 'preservim/vim-pencil' }

end)

