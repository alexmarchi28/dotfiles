local function clear_background()
  local groups = {
    "Normal",
    "NormalNC",
    "NormalFloat",
    "FloatBorder",
    "FloatTitle",
    "SignColumn",
    "FoldColumn",
    "LineNr",
    "CursorLineNr",
    "EndOfBuffer",
    "MsgArea",
    "StatusLine",
    "StatusLineNC",
    "TabLine",
    "TabLineFill",
    "WinBar",
    "WinBarNC",
    "Pmenu",
    "PmenuSel",
    "TelescopeNormal",
    "TelescopeBorder",
    "TelescopePromptNormal",
    "TelescopeResultsNormal",
    "TelescopePreviewNormal",
    "WhichKeyNormal",
    "LazyNormal",
    "MasonNormal",
    "NeoTreeNormal",
    "NeoTreeNormalNC",
    "TroubleNormal",
    "NoiceCmdlinePopup",
  }

  for _, group in ipairs(groups) do
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
    if ok then
      hl.bg = nil
      hl.ctermbg = nil
      vim.api.nvim_set_hl(0, group, hl)
    end
  end
end

local function dim_indent_guides()
  local colors

  if vim.o.background == "light" then
    colors = { indent = "#d9d9d9", scope = "#b8b8b8" }
  else
    colors = { indent = "#242424", scope = "#363636" }
  end

  vim.api.nvim_set_hl(0, "SnacksIndent", { fg = colors.indent, ctermfg = 238 })
  vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = colors.scope, ctermfg = 240 })
  vim.api.nvim_set_hl(0, "SnacksIndentChunk", { fg = colors.scope, ctermfg = 240 })
end

return {
  {
    "LazyVim/LazyVim",
    init = function()
      local group = vim.api.nvim_create_augroup("user_transparent_background", { clear = true })

      vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
        group = group,
        callback = function()
          clear_background()
          dim_indent_guides()
        end,
      })
    end,
    opts = {
      colorscheme = "default",
    },
  },
}
