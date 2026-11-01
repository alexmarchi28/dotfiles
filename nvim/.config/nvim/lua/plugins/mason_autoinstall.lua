return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "black",
        "clangd",
        "basedpyright",
        "gopls",
      },
    },
  },
}
