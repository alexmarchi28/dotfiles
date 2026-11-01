-- Minimal statusline: mode, file, modified flag | diagnostics, git branch, position.
-- Colours come from the StatusLine* groups set in plugins/theme.lua.
local M = {}

local modes = {
  n = "NORMAL",
  no = "NORMAL",
  i = "INSERT",
  ic = "INSERT",
  v = "VISUAL",
  V = "V-LINE",
  ["\22"] = "V-BLOCK",
  s = "SELECT",
  S = "S-LINE",
  R = "REPLACE",
  c = "COMMAND",
  t = "TERMINAL",
}

function M.render()
  local win = vim.g.statusline_winid or 0
  local buf = vim.api.nvim_win_get_buf(win)
  local mode = vim.api.nvim_get_mode().mode
  mode = modes[mode] or modes[mode:sub(1, 1)] or mode

  local name = vim.api.nvim_buf_get_name(buf)
  name = name == "" and "[No Name]" or vim.fn.fnamemodify(name, ":~:.")
  name = name:gsub("%%", "%%%%")

  local left = { "%#StatusLineMode# " .. mode .. " %#StatusLine# " .. name }
  if vim.bo[buf].modified then
    table.insert(left, "%#StatusLineModified#●%#StatusLine#")
  end
  if vim.bo[buf].readonly then
    table.insert(left, "[RO]")
  end

  local right = {}
  local counts = vim.diagnostic.count(buf)
  local errors = counts[vim.diagnostic.severity.ERROR] or 0
  local warnings = counts[vim.diagnostic.severity.WARN] or 0
  if errors > 0 then
    table.insert(right, "%#StatusLineError#E" .. errors .. "%#StatusLine#")
  end
  if warnings > 0 then
    table.insert(right, "%#StatusLineWarn#W" .. warnings .. "%#StatusLine#")
  end
  local branch = vim.b[buf].gitsigns_head
  if branch and branch ~= "" then
    table.insert(right, " " .. branch)
  end
  table.insert(right, "%l:%c ")

  return table.concat(left, " ") .. "%=" .. table.concat(right, "  ")
end

-- redraw when the mode or the diagnostics change
vim.api.nvim_create_autocmd({ "ModeChanged", "DiagnosticChanged" }, {
  group = vim.api.nvim_create_augroup("user_statusline", { clear = true }),
  command = "redrawstatus",
})

return M
