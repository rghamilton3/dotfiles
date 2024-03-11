return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "css-lsp",
        "flake8",
        "shellcheck",
        "shfmt",
        "slint-lsp",
        "stylua",
        "vue-language-server",
      },
    },
  },
}
