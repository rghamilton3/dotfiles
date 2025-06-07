-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.python3_host_prog = "~/.pyenv/versions/neovim/bin/python3"
vim.g.lazyvim_picker = "snacks"

-- When switching tmux panes, save the current Neovim buffer if changed
vim.g.tmux_navigator_save_on_switch = 1

vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH
