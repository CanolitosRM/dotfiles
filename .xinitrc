#!/bin/sh
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export GIO_EXTRA_MODULES=/usr/lib/gio/modules

if [ -x /usr/bin/dbus-launch ] && [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    exec dbus-launch --sh-syntax --exit-with-session xmonad
else
    exec xmonad
fi
