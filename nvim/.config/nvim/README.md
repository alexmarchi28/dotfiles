# Neovim Configuration

A personal Neovim configuration based on
[LazyVim](https://github.com/LazyVim/LazyVim), customized for a cleaner,
quieter editing experience.

This setup keeps LazyVim as the foundation while changing several defaults to
make the interface less intrusive and more focused on editing.

## Changes From LazyVim

- Uses Neovim's built-in `default` colorscheme.
- Applies a transparent background to the main editor and plugin UI elements.
- Reduces the visual intensity of indentation guides.
- Disables the statusline, including `lualine`.
- Enables soft line wrapping with `wrap` and `linebreak`.
- Disables the highlighted cursor line.
- Disables spellcheck by default.
- Disables the initial LazyVim dashboard.
- Prevents the LSP completion menu from opening automatically.
- Disables completion ghost text and inline previews.
- Keeps completion available manually with `<C-Space>`.
- Automatically installs selected Mason tools: `black`, `clangd`,
  `basedpyright`, and `gopls`.

## LazyVim

For the LazyVim base configuration, installation details, and upstream
documentation, see the [official LazyVim documentation](https://lazyvim.github.io/installation).
