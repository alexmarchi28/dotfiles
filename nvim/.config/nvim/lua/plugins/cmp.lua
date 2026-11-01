return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      -- Disattiva completamento automatico
      opts.completion = {
        autocomplete = false,
      }
      opts.experimental = {
        ghost_text = false,
      }

      -- Assicurati di avere un trigger manuale
      local cmp = require("cmp")
      opts.mapping["<C-Space>"] = cmp.mapping.complete()
    end,
  },
}
