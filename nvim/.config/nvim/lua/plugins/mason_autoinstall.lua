-- LSP servers and tools come from the LazyVim language extras (lazyvim.json);
-- black is the only one they don't install.
return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "black",
      },
    },
  },
}
