return {
  {
    "javiorfo/nvim-soil",

    -- Optional for puml syntax highlighting:
    dependencies = { "javiorfo/nvim-nyctophilia" },

    lazy = true,
    ft = "plantuml",
    opts = {
      actions = {
        redraw = false,
      },
    },
  },
  {
    "https://gitlab.com/itaranto/preview.nvim",

    version = "*",

    opts = {
      previewers_by_ft = {

        plantuml = {
          name = "plantuml_svg",
          renderer = { type = "command", opts = { cmd = { "feh" } } },
        },
      },
      previewers = {
        plantuml_svg = {
          args = { "-pipe", "-tpng" },
        },
      },
      render_on_write = true,
    },
  },
}
