# dotfiles

Configurazione di sway su Debian 13, ispirata a [Omarchy](https://github.com/basecamp/omarchy).
Tema grigio-verde con accento salvia `#93a99c`, ricavato dal wallpaper `trees.webp` del tema
Everforest di Omarchy.

![Desktop](screenshots/desktop.jpg)

| | |
|---|---|
| ![Terminale e file manager affiancati](screenshots/tiling.jpg) | ![Launcher fuzzel](screenshots/launcher.jpg) |
| Tiling con kitty e Nautilus, bordo salvia sulla finestra attiva | Launcher fuzzel (`$mod+d`) |
| ![Pannelli flottanti, notifiche e wob](screenshots/panels.jpg) | ![Palette del terminale](screenshots/terminal.jpg) |
| pavucontrol flottante, notifica di mako e barra di wob | Palette di kitty |

## Componenti

| | |
|---|---|
| Window manager | sway |
| Barra | Waybar (workspace, musica, orologio, tray, bluetooth, rete, luminosità, volume) |
| Launcher | fuzzel |
| Terminale | kitty |
| Notifiche | mako |
| Volume e luminosità a schermo | wob |
| Tema GTK e icone | Adwaita scuro con accento salvia, generato da `gtk-sage-theme` |
| Font | JetBrainsMono Nerd Font |

## Installazione

```bash
git clone git@github.com:alexmarchi28/dotfiles.git ~/dotfiles
~/dotfiles/setup.sh
```

`setup.sh` installa i pacchetti di `packages.txt`, il font JetBrainsMono Nerd Font, crea i link con
GNU Stow (i file già presenti finiscono in `~/.dotfiles-backup-<data>`), genera il tema
Adwaita-sage e imposta tema scuro, tema GTK e icone con `gsettings`.

## Struttura

Ogni cartella è un pacchetto Stow che riproduce i percorsi a partire da `~`:

| Pacchetto | Contenuto |
|---|---|
| `sway` | config di sway e wallpaper |
| `waybar` | barra, stile, modulo luminosità (`brightness.sh`) |
| `kitty` | terminale |
| `mako` | notifiche |
| `wob` | barra di volume e luminosità a schermo |
| `fuzzel` | launcher delle app |
| `gtk` | tema scuro e accento salvia per le app libadwaita |
| `scripts` | `monictrl` (luminosità/contrasto via DDC/CI), `gtk-sage-theme` |

Per modificare una config basta modificare il file al suo solito posto (es. `~/.config/sway/config`):
è un link al file in questo repository.

Per aggiungere un pacchetto: crea `nome/.config/nome/...`, sposta lì il file e lancia
`stow --target="$HOME" nome` dalla cartella `~/dotfiles`.

## Scorciatoie principali

| Tasti | Azione |
|---|---|
| `$mod+Invio` | terminale |
| `$mod+d` | launcher |
| `$mod+Shift+b` | Firefox |
| `$mod+Shift+q` | chiude la finestra |
| `$mod+h/j/k/l` o frecce | sposta il focus |
| `$mod+Shift+h/j/k/l` | sposta la finestra |
| `$mod+1…0` | cambia workspace |
| `$mod+r` | modalità ridimensionamento |
| Rotella del volume | volume |
| `Ctrl` + rotella del volume | luminosità del monitor |
| `$mod+Shift+u/d` | luminosità del monitor |
| `$mod+Ctrl+u/d` | contrasto del monitor |
| `Print` / `Shift+Print` | screenshot intero / di un'area negli appunti |
| `$mod+Shift+p` | sospensione |
| `$mod+Shift+e` | logout |

`$mod` è il tasto Windows.

## Note

- **Luminosità**: il monitor esterno si regola via DDC/CI con `ddcutil`: Ctrl + rotella del volume,
  scroll sull'icona in Waybar o `$mod+Shift+u/d`. wob mostra subito il valore finale, mentre il
  monitor lo raggiunge in sottofondo. Se `ddcutil` non ha accesso a `/dev/i2c-*`:
  `sudo usermod -aG i2c $USER` e rientra nella sessione.
- **Tema Adwaita-sage**: è generato da `gtk-sage-theme` e non è nel repository. sway lo rigenera da solo
  all'avvio quando GTK o le icone Adwaita vengono aggiornati.
- **Impostazioni fuori dai file**: tema scuro, tema GTK e icone sono impostazioni `gsettings`, applicate
  da `setup.sh`.

## Crediti

- [Omarchy](https://github.com/basecamp/omarchy): ispirazione generale del setup.
- Il wallpaper `trees.webp` viene dal tema **Everforest** di Omarchy; anche gli altri wallpaper
  `omarchy-*` vengono da Omarchy.
- La configurazione di Waybar (`config.jsonc`, `style.css`) è partita da quella di Omarchy ed è stata
  adattata a sway e a questo PC.
