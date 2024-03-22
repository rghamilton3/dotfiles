return {
  "max397574/better-escape.nvim",
  opts = function(plugin, opts)
    return require("astrocore").extend_tbl(opts, {
      mapping = { "jj" },
    })
  end,
}
