#!/bin/bash
# Back to the Debian boot: plymouth splash, default console font, GDM login.
# Run as root: sudo system/boot/uninstall.sh (greetd and tuigreet stay installed, unused).
set -euo pipefail
[ "$(id -u)" -eq 0 ] || { echo "va lanciato con sudo"; exit 1; }

# puts back the copy saved by install.sh
restore_original() {
  [ -e "$1.misty-forest-orig" ] && mv -f "$1.misty-forest-orig" "$1" || true
}

rm -f /etc/default/grub.d/misty-forest.cfg /boot/grub/misty-forest-background.png
update-grub

restore_original /etc/default/console-setup
restore_original /etc/greetd/config.toml
rm -f /etc/systemd/system/greetd.service.d/tty1.conf
rmdir --ignore-fail-on-non-empty /etc/systemd/system/greetd.service.d 2>/dev/null || true

update-initramfs -u

systemctl disable greetd
# gdm3.service has no [Install] section: put back the link that Debian's gdm3 package creates
ln -sf /lib/systemd/system/gdm3.service /etc/systemd/system/display-manager.service
restore_original /etc/X11/default-display-manager
systemctl daemon-reload

echo "==> Fatto: al prossimo riavvio torna l'avvio di Debian con GDM."
