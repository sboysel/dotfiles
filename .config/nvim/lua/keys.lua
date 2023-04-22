local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

keymap("n", "<Leader>w", ":w<CR>", default_opts)
keymap("n", "<Leader>q", ":q<CR>", default_opts)
keymap("n", "<Leader>wq", ":wq<CR>", default_opts)
keymap("n", "<Leader>ps", ":PackerSync<CR>", default_opts)
keymap("n", "<Leader>e", ":tabedit<CR>", default_opts)
keymap("n", "<Leader>t", ":NvimTreeToggle<CR>", default_opts)
keymap("n", "<Leader>ff", ":Telescope find_files<CR>", default_opts)
keymap("n", "<Leader>-", "80A-<Esc>d80|", default_opts)
