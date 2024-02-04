-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- Font
config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.font_size = 16

-- Colorscheme:
config.color_scheme = 'Tomorrow Night'

-- Disable tab
config.enable_tab_bar = false

-- SSH Domains

config.ssh_domains = {
  {
    -- This name identifies the domain
    name = 'augie',
    -- The hostname or address to connect to. Will be used to match settings
    -- from your ssh config file
    remote_address = '192.168.0.220',
    -- The username to use on the remote host
    username = 'sam',
  },
}


-- and finally, return the configuration to wezterm
return config
