return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      -- Disabilita popup automatico mentre scrivi
      opts.completion = opts.completion or {}
      opts.completion.menu = opts.completion.menu or {}
      opts.completion.menu.auto_show = false

      -- 🔴 DISABILITA GHOST TEXT / INLINE PREVIEW
      opts.completion.ghost_text = opts.completion.ghost_text or {}
      opts.completion.ghost_text.enabled = false

      -- Trigger manuale (apre il menu quando vuoi tu)
      opts.keymap = opts.keymap or {}
      opts.keymap["<C-Space>"] = { "show" }
      -- opzionale: chiudi menu
      opts.keymap["<C-e>"] = { "hide" }
    end,
  },
}
