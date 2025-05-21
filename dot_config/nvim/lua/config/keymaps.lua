-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local wk = require("which-key")

-- ignore capitalization mistakes
vim.cmd("ca W w")
vim.cmd("ca Q q")
vim.cmd("ca WQ wq")
vim.cmd("ca Wq wq")

-- These appear on the default leader key so make them pretty
wk.add({
  {
    mode = { "n", "v" },
    { "<leader>y", [["+y]], desc = "Yank to system clipboard", icon = "󱉫 " },
    { "<leader>Y", [["+Y]], desc = "Yank line to system clipboard", icon = "󱉨 " },
  },
})

map("n", "<leader>h", ":nohl<cr>", { desc = "Clear search highlight" })

map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up", silent = true })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down", silent = true })

-- Center screen after scrolling
map("n", "<A-u>", "<C-u>zz", { desc = "Center after scrolling up" })
map("n", "<A-d>", "<C-d>zz", { desc = "Center after scrolling down" })

-- Center the screen on the next/prev search result with n/N
map("n", "n", "nzzzv", { desc = "Center on next search result" })
map("n", "N", "Nzzzv", { desc = "Center on previous search result" })

-- Paste in visual mode without yanking replaced text
map("x", "p", [["_dP]])

-- move 5 lines up/down with arrow keys
map("n", "<Down>", "5j", { desc = "Move down 5 lines" })
map("n", "<Up>", "5k", { desc = "Move up 5 lines" })

-- For Markdown
-- Toggle checkbox values
local function toggle_checkbox()
  -- Get the current line
  local line = vim.api.nvim_get_current_line()
  local new_line = line

  -- Check if line contains unchecked checkbox
  if line:match("^%s*-%s*%[ %]") then
    -- Replace unchecked with checked
    new_line = line:gsub("%[ %]", "[x]")
    vim.api.nvim_set_current_line(new_line)

    -- Check if line contains checked checkbox
  elseif line:match("^%s*-%s*%[x%]") then
    -- Replace checked with unchecked
    new_line = line:gsub("%[x%]", "[ ]")
    vim.api.nvim_set_current_line(new_line)

    -- If no checkbox, prepend unchecked
  else
    new_line = "- [ ] " .. line
  end
  vim.api.nvim_set_current_line(new_line)
end
map("n", "<leader>ch", toggle_checkbox, { desc = "Toggle checkbox" })

map("n", "<leader>fo", function()
  Snacks.picker.files({
    cwd = vim.fn.expand("~") .. "/Vaults/Second Brain",
  })
end, { desc = "Find note", noremap = true, silent = true })
map("n", "<leader>fO", function()
  Snacks.picker.grep({
    cwd = vim.fn.expand("~") .. "/Vaults/Second Brain",
  })
end, { desc = "Find note text", noremap = true, silent = true })

-- Note taking
map("n", "<leader>oo", ":cd /home/rghamilton3/Vaults/Second Brain<cr>", { desc = "Navigate to notes" })
map(
  "n",
  "<leader>ok",
  ":!mv '%:p' /home/rghamilton3/Vaults/Second\\ Brain/zk<cr>:bd<cr>",
  { desc = "Move to zettlekasten" }
)
map("n", "<leader>odd", ":!rm '%:p'<cr>:bd<cr>", { desc = "Delete note" })
