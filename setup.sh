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

echo "==> Firefox: user.js e tema Misty Forest"
# profilo predefinito dell'installazione (sezione [Install...] di profiles.ini)
profile=""
for dir in "$HOME/.config/mozilla/firefox" "$HOME/.mozilla/firefox"; do
  ini="$dir/profiles.ini"
  [ -f "$ini" ] || continue
  rel=$(awk -F= '/^\[Install/ {s=1; next} /^\[/ {s=0} s && $1=="Default" {print $2; exit}' "$ini")
  if [ -n "$rel" ] && [ -d "$dir/$rel" ]; then profile="$dir/$rel"; break; fi
done
if [ -z "$profile" ]; then
  echo "nessun profilo Firefox trovato: avvia Firefox una volta e rilancia setup.sh"
else
  if [ -e "$profile/user.js" ] && [ ! -L "$profile/user.js" ]; then
    mkdir -p "$backup"
    mv "$profile/user.js" "$backup/firefox-user.js"
    echo "backup: $profile/user.js"
  fi
  ln -sfn "$PWD/firefox/user.js" "$profile/user.js"
  echo "user.js collegato a $profile"
  if [ -f "$profile/extensions/misty-forest@alexmarchi28.github.xpi" ]; then
    echo "tema Misty Forest già installato"
  else
    # Firefox chiede conferma dell'installazione del tema (firmato da Mozilla)
    firefox "$PWD/firefox/misty-forest-1.0.xpi" &
  fi
fi

echo "==> Fatto. Esci e scegli Sway nella schermata di login (o ricarica sway con \$mod+Shift+c)."
