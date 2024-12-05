args @ {pkgs, ...}: let
  commands = (import ./commands.nix args).commands;
in [
  {command = "${pkgs.mako}/bin/mako";}
  {
    command =
      "${pkgs.swayidle}/bin/swayidle -w"
      + " timeout 600 '${commands.lock}'"
      + " timeout 605 'swaymsg \"output * power off\"'"
      + " resume 'swaymsg \"output * power on\"'"
      + " timeout 1200 'systemctl suspend'"
      + " before-sleep '${commands.lock}'";
  }
  # { command = "fcitx5 -dr"; }
]
