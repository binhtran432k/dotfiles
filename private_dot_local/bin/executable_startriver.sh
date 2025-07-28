#!/bin/sh

# export WAYLAND_DISPLAY=wayland-1
export XDG_CURRENT_DESKTOP=river

export MOZ_ENABLE_WAYLAND=1
export XDG_SESSION_TYPE=wayland
export GOLDENDICT_FORCE_WAYLAND=1
export GDK_BACKEND=wayland

exec river 2> ~/.river.log
