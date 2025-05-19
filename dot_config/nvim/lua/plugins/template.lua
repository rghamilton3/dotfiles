return {
  {
    "glepnir/template.nvim",
    cmd = { "Template", "TemProject" },
    config = function()
      require("template").setup({
        temp_dir = "~/.config/nvim/templates",
        author = "Robert Hamilton",
        email = "robert@rghsoftware.com",
      })
    end,
  },
}
