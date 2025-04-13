#!/bin/bash
COMMAND=$1
case "$COMMAND" in
  full)
    shift
    (grim - | wl-copy) && notify-send -t 1500 "Take screenshot full"
    ;;
  *)
    (grim -g "$(slurp -d)" - | wl-copy) && notify-send -t 1500 "Take screenshot"
    ;;
esac
