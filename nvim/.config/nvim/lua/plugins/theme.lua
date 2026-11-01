-- Everforest recoloured with the system palette (same colours as kitty, sway and waybar).
local palette = {
  bg_dim = "#171c1f",
  bg0 = "#1c2225",
  bg1 = "#252d30",
  bg2 = "#2e383c",
  bg3 = "#3a464b",
  bg4 = "#46545a",
  bg5 = "#52615f",
  bg_visual = "#3b4a42",
  bg_red = "#3a2f2e",
  bg_green = "#2f3a32",
  bg_blue = "#2c3840",
  bg_yellow = "#3a382c",
  bg_purple = "#352f38",
  fg = "#d3dad5",
  red = "#c07a6e",
  orange = "#c9977a",
  yellow = "#c9b37c",
  green = "#9bb08a",
  aqua = "#83aca8",
  blue = "#7f9cad",
  purple = "#a88fa8",
  grey0 = "#6c7a7e",
  grey1 = "#7f8b85",
  grey2 = "#9aa59f",
  statusline1 = "#93a99c",
  statusline2 = "#d3dad5",
  statusline3 = "#c07a6e",
}

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

return {
  {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
    main = "everforest",
    opts = {
      background = "hard",
      transparent_background_level = 1,
      colours_override = function(p)
        for name, colour in pairs(palette) do
          p[name] = colour
        end
      end,
      on_highlights = function(hl, p)
        -- indentation guides barely visible, the current scope a bit more
        hl.SnacksIndent = { fg = p.bg2 }
        hl.SnacksIndentScope = { fg = p.bg4 }
        hl.SnacksIndentChunk = { fg = p.bg4 }

        -- completion menu on a solid background, readable over the code
        hl.Pmenu = { fg = p.fg, bg = p.bg2 }
        hl.PmenuSel = { fg = p.bg0, bg = p.statusline1 }
        hl.PmenuSbar = { bg = p.bg2 }
        hl.PmenuThumb = { bg = p.bg4 }
        hl.BlinkCmpMenuBorder = { fg = p.bg2, bg = p.bg2 }

        -- statusline (lua/config/statusline.lua)
        hl.StatusLine = { fg = p.grey1 }
        hl.StatusLineNC = { fg = p.grey0 }
        hl.StatusLineMode = { fg = p.statusline1, bold = true }
        hl.StatusLineModified = { fg = p.yellow }
        hl.StatusLineError = { fg = p.red }
        hl.StatusLineWarn = { fg = p.yellow }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    init = function()
      local group = vim.api.nvim_create_augroup("user_transparent_background", { clear = true })

      vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
        group = group,
        callback = clear_background,
      })
    end,
    opts = {
      colorscheme = "everforest",
    },
  },
}
