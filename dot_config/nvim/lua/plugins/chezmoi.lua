return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>fz",
      function()
        local telescope = require("telescope")
        telescope.load_extension("chezmoi")
        telescope.extensions.chezmoi.find_files({})
      end,
      desc = "Find chezmoi files",
    },
  },
}
