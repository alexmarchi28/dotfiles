-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.spell = false
vim.opt.cursorline = false
vim.opt.laststatus = 0
vim.opt.showmode = true
vim.opt.ruler = true
vim.opt.statusline = ""

-- Python extra: keep basedpyright (the extra defaults to pyright)
vim.g.lazyvim_python_lsp = "basedpyright"
