return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          mason = false,
          cmd = { vim.fn.expand("/usr/bin/ruby-lsp") },
        },
      },
    },
  },
}
