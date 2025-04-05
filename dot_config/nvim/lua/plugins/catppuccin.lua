if true then
  return {}
end

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    init = function()
      return require("catppuccin").setup({
        flavour = "macchiato",
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
