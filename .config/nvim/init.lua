--[[ init.lua ]]
-- references:
-- * https://mattermost.com/blog/how-to-install-and-set-up-neovim-for-code-editing/

-- LEADER
-- These keybindings need to be defined before the first /
-- is called; otherwise, it will default to "\"
vim.g.mapleader = "'"
vim.g.localleader = "\\"

-- [[ imports ]]
require('vars')      -- Variables
require('opts')      -- Options
require('keys')      -- Keymaps
require('plugins')   -- Plugins
require('lsp')

-- [[ imports // plugin config ]]

-- [[ imports // plugin config // lualine ]]
require('lualine').setup({
    options = {
        theme = 'auto',
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '', right = ''},
    }
})

-- [[ imports // plugin config // nvim-tree ]]
require("nvim-tree").setup()

-- [[ imports // plugin config // nvim-treesitter ]]
require'nvim-treesitter.configs'.setup {
  auto_install = true,
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
