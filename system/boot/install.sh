#!/bin/bash
# Text boot with the system palette: boot messages in the console colours, Terminus font,
# greetd + tuigreet login instead of GDM. Run as root: sudo system/boot/install.sh
# Takes effect at the next reboot. To go back: sudo system/boot/uninstall.sh
set -euo pipefail
cd "$(dirname "$(readlink -f "$0")")"
[ "$(id -u)" -eq 0 ] || { echo "va lanciato con sudo"; exit 1; }

# keeps a copy of a system file the first time it gets changed (used by uninstall.sh)
keep_original() {
  [ -e "$1" ] && [ ! -e "$1.misty-forest-orig" ] && cp -a "$1" "$1.misty-forest-orig" || true
}

echo "==> Pacchetti greetd e tuigreet"
apt install -y greetd tuigreet
systemd-tmpfiles --create tuigreet.conf

echo "==> GRUB: parametri del kernel (niente splash, palette della console)"
install -D -m 644 grub-misty-forest.cfg /etc/default/grub.d/misty-forest.cfg
install -m 644 grub-background.png /boot/grub/misty-forest-background.png
# no "Loading Linux ..." / "Loading initial ramdisk ..." lines, white on black over the background:
# Debian hardcodes quiet_boot="0" in this script (a conffile: an upgrade that changes it asks first).
# No copy of the original here: update-grub would run it as a second script; uninstall.sh sets 0 back.
sed -i 's/^quiet_boot="0"$/quiet_boot="1"/' /etc/grub.d/10_linux
update-grub

echo "==> Font della console: Terminus 12x24"
keep_original /etc/default/console-setup
sed -i -e 's/^FONTFACE=.*/FONTFACE="Terminus"/' -e 's/^FONTSIZE=.*/FONTSIZE="12x24"/' /etc/default/console-setup
setupcon --save-only

echo "==> greetd con tuigreet su tty1"
keep_original /etc/greetd/config.toml
install -m 644 greetd-config.toml /etc/greetd/config.toml
install -D -m 644 greetd-tty1.conf /etc/systemd/system/greetd.service.d/tty1.conf
# il portachiavi (gnome-keyring) va sbloccato al login, come faceva GDM
grep -q "pam_gnome_keyring.so" /etc/pam.d/greetd || echo "ATTENZIONE: /etc/pam.d/greetd non sblocca gnome-keyring"

echo "==> initramfs (font della console all'avvio)"
update-initramfs -u

echo "==> Display manager: da GDM a greetd"
# gdm3.service has no [Install] section: the display-manager.service link is all that starts it,
# and enabling greetd with --force replaces that link
systemctl enable --force greetd
keep_original /etc/X11/default-display-manager
echo /usr/sbin/greetd > /etc/X11/default-display-manager
systemctl daemon-reload

echo "==> Fatto. Riavvia per vedere il nuovo avvio."
echo "Se il login non parte: Ctrl+Alt+F2, entra nel terminale e lancia sudo $PWD/uninstall.sh"
