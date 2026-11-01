#!/bin/bash
# Installa questa configurazione su un PC Debian: pacchetti, font, link (stow), tema.
# Si può rilanciare: i passaggi già fatti vengono saltati.
set -euo pipefail
cd "$(dirname "$(readlink -f "$0")")"

PACKAGES=(sway waybar kitty mako wob fuzzel gtk scripts)

echo "==> Pacchetti"
mapfile -t pkgs < <(grep -vE '^\s*(#|$)' packages.txt)
sudo apt install -y "${pkgs[@]}"

echo "==> Font JetBrainsMono Nerd Font"
if fc-list | grep -q "JetBrainsMono Nerd Font"; then
  echo "già installato"
else
  dir="$HOME/.local/share/fonts/JetBrainsMonoNerd"
  mkdir -p "$dir"
  tmp=$(mktemp -d)
  curl -fL -o "$tmp/JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
  unzip -o -q "$tmp/JetBrainsMono.zip" -d "$dir"
  rm -r "$tmp"
  fc-cache -f
fi

echo "==> Link (stow)"
# i file già presenti (non link) vengono spostati in un backup invece di bloccare stow
backup="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
for pkg in "${PACKAGES[@]}"; do
  while IFS= read -r -d '' file; do
    target="$HOME/${file#"$pkg"/}"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
      mkdir -p "$backup/$(dirname "${file#"$pkg"/}")"
      mv "$target" "$backup/${file#"$pkg"/}"
      echo "backup: $target"
    fi
  done < <(find "$pkg" -type f -print0)
done
[ -d "$backup" ] && echo "file originali salvati in $backup"
stow --target="$HOME" --restow "${PACKAGES[@]}"

echo "==> Tema GTK e icone Adwaita-sage"
"$HOME/.local/bin/gtk-sage-theme"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-sage'
gsettings set org.gnome.desktop.interface icon-theme 'Adwaita-sage'

echo "==> Fatto. Esci e scegli Sway nella schermata di login (o ricarica sway con \$mod+Shift+c)."
