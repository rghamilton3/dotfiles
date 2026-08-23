return {
  "lambdalisue/vim-suda",
  cmd = { "SudaRead", "SudaWrite" },
  keys = {
    { "<leader>fW", "<cmd>SudaWrite<cr>", desc = "Save File (sudo)" },
  },
}
