--[[ init.lua ]]
-- references:
-- * https://mattermost.com/blog/how-to-install-and-set-up-neovim-for-code-editing/

-- LEADER
-- These keybindings need to be defined before the first /
-- is called; otherwise, it will default to "\"
vim.g.mapleader = ","
-- vim.g.localleader = "\\"

-- [[ imports ]]
require('vars')      -- Variables
require('opts')      -- Options
require('keys')      -- Keymaps
require('plugins')   -- Plugins
require('lsp')

-- [[ imports // plugin config ]]
-- [[ imports // plugin config // lualine ]]
require('lualine').setup {
    options = {
        theme = "kanagawa"
    }
}
