#!/bin/bash
power() {
  if [[ -n $@ ]]; then
    [[ $@ = "lock"  ]] && swaylock
    [[ $@ = "suspend"  ]] && systemctl suspend
    [[ $@ = "quit"  ]] && niri msg action quit
    [[ $@ = "shutdown"  ]] && shutdown now
    [[ $@ = "reboot"  ]] && reboot
  fi
}
mode=$(echo -e "lock\nsuspend\nquit\nshutdown\nreboot" | fuzzel --dmenu)
power $mode
