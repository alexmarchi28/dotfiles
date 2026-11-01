# Neovim Configuration

A personal Neovim configuration based on
[LazyVim](https://github.com/LazyVim/LazyVim), customized for a cleaner,
quieter editing experience.

This setup keeps LazyVim as the foundation while changing several defaults to
make the interface less intrusive and more focused on editing.

## Changes From LazyVim

- Uses [Everforest](https://github.com/neanias/everforest-nvim) recoloured with the system
  palette (grey-green background, sage accent), the same colours as kitty, sway and Waybar.
- Applies a transparent background to the main editor and plugin UI elements; the completion
  menu keeps a solid background so it stays readable over the code.
- Reduces the visual intensity of indentation guides.
- Replaces `lualine` with a minimal statusline (`lua/config/statusline.lua`): mode, file,
  modified flag, error/warning counts, git branch and cursor position, on a transparent background.
- Soft line wrapping (`wrap` and `linebreak`) only in text files (markdown, text, git commits,
  LaTeX, typst, mail), not in code.
- Disables the highlighted cursor line.
- Disables spellcheck everywhere, text files included.
- Disables the initial LazyVim dashboard.
- Prevents the LSP completion menu from opening automatically.
- Disables completion ghost text and inline previews.
- Keeps completion available manually with `<C-Space>`.

## LazyVim extras

Enabled in `lazyvim.json`:

- `lang.python`: basedpyright (instead of pyright) and ruff; `black` formats Python files.
- `lang.go`: gopls, goimports, gofumpt, golangci-lint.
- `lang.clangd`: clangd and clangd_extensions for C/C++.
- `dap.core`: debugger (nvim-dap with its UI): delve for Go (installed with apt, not Mason),
  debugpy for Python, codelldb for C/C++.

Mason installs the tools on the first start. `lazy-lock.json` is committed, so every machine gets
the same plugin versions.

## LazyVim

For the LazyVim base configuration, installation details, and upstream
documentation, see the [official LazyVim documentation](https://lazyvim.github.io/installation).
