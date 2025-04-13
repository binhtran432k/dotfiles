#!/bin/bash
power() {
  if [[ -n $@ ]]; then
    [[ $@ = "lock"  ]] && waylock.sh
    [[ $@ = "suspend"  ]] && systemctl suspend
    [[ $@ = "log off"  ]] && riverctl exit
    [[ $@ = "shutdown"  ]] && shutdown now
    [[ $@ = "reboot"  ]] && reboot
  fi
}
mode=$(echo -e "lock\nsuspend\nlog off\nshutdown\nreboot" | fuzzel --dmenu)
power $mode
