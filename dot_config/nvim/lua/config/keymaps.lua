-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Escapes
map("i", "jj", "<Esc>", { desc = "Escape" })
map("i", "jk", "<Esc>A", { desc = "Jump to end of line" })
map("i", "jo", "<Esc>o", { desc = "Jump to new blank line" })
map("i", "jO", "<Esc>O", { desc = "Jump back to new blank line" })
