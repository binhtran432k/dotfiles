args @ {pkgs, ...}: let
  mymenu = "${import ./mymenu.nix args}/bin/mymenu";
in
  pkgs.writeShellScriptBin "mypower" ''
    power() {
      if [[ -n $@ ]]; then
        [[ $@ = "lock"  ]] && ${pkgs.swaylock}/bin/swaylock
        [[ $@ = "suspend"  ]] && systemctl suspend
        [[ $@ = "restart wm"  ]] && swaymsg reload
        [[ $@ = "log off"  ]] && swaymsg exit
        [[ $@ = "shutdown"  ]] && shutdown now
        [[ $@ = "reboot"  ]] && reboot
      fi
    }
    mode=$(echo -e "lock\nsuspend\nrestart wm\nlog off\nshutdown\nreboot" | ${mymenu})
    power $mode
  ''
