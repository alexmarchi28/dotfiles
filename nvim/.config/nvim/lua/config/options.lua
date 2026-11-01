-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- no wrap in code; text files turn it on (autocmds.lua), breaking lines between words
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.spell = false
vim.opt.cursorline = false
-- one minimal statusline for all windows (lua/config/statusline.lua); it shows the mode
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.statusline = "%!v:lua.require'config.statusline'.render()"

-- Python extra: keep basedpyright (the extra defaults to pyright)
vim.g.lazyvim_python_lsp = "basedpyright"
