{ pkgs, ... }:
pkgs.writeShellScriptBin "mypower.sh" ''
  power() {
    if [[ -n $@ ]]; then
      [[ $@ = "lock"  ]] && ${pkgs.swaylock}/bin/swaylock
      [[ $@ = "suspend"  ]] && ${pkgs.systemd}/bin/systemctl suspend
      [[ $@ = "quit"  ]] && ${pkgs.niri}/bin/niri msg action quit
      [[ $@ = "shutdown"  ]] && ${pkgs.systemd}/bin/shutdown now
      [[ $@ = "reboot"  ]] && ${pkgs.systemd}/bin/reboot
    fi
  }
  mode=$(echo -e "lock\nsuspend\nquit\nshutdown\nreboot" | ${pkgs.fuzzel}/bin/fuzzel --dmenu)
  power $mode
''
