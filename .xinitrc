#!/bin/sh

# Variables de entorno
export GIO_EXTRA_MODULES=/usr/lib/gio/modules
# Tema oscuro para aplicaciones gtk 4
export ADW_DEBUG_COLOR_SCHEME=prefer-dark

# X11
xrdb -merge ~/.config/X11/Xresources
xsetroot -cursor_name left_ptr

# Corregir color y gamma
sh ~/scripts/colorGamma.sh &

# Executing XMonad with DBus Session
if [ -x /usr/bin/dbus-launch ] && [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    exec dbus-launch --sh-syntax --exit-with-session /home/jairorm/.cache/xmonad/xmonad-x86_64-linux
else
    exec /home/jairorm/.cache/xmonad/xmonad-x86_64-linux
fi
