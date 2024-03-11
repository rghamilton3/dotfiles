return {
  "rafamadriz/friendly-snippets",
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip").filetype_extend("typescript", { "javascript" })
    require("luasnip").filetype_extend("typescript", { "tsdoc" })
    require("luasnip").filetype_extend("javascript", { "vue" })
    require("luasnip").filetype_extend("typescript", { "vue" })
  end,
}
