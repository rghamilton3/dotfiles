return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    if not opts.window then opts.window = {} end
    opts.window.width = 45

    if not opts.commands then opts.commands = {} end
    opts.commands.reveal = true

    if not opts.filesystem then opts.filesystem = {} end
    if not opts.filesystem.filtered_items then opts.filesystem.filtered_items = {} end
    opts.filesystem.filtered_items.visible = true
    if not opts.filesystem.filtered_items.never_show then opts.filesystem.filtered_items.never_show = {} end
    require("astrocore").list_insert_unique(opts.filesystem.filtered_items.never_show, { "node_modules" })

    return require("astrocore").extend_tbl(opts, {
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function(_)
            vim.opt_local.signcolumn = "auto"
            vim.opt_local.number = true
          end,
        },
      },
    })
  end,
}
