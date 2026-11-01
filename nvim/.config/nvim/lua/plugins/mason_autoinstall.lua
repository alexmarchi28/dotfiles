-- LSP servers and tools come from the LazyVim language extras (lazyvim.json);
-- black and debugpy (used by the dap.core extra for Python) are the ones they don't install.
-- delve comes from Debian (apt), not Mason.
return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_filter(function(tool)
        return tool ~= "delve"
      end, opts.ensure_installed or {})
      vim.list_extend(opts.ensure_installed, { "black", "debugpy" })
    end,
  },
}
