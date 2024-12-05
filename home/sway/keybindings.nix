args @ {lib, ...}: let
  modifier = "Mod4";
  commands = (import ./commands.nix args).commands;
in {
  inherit modifier;
  keybindings = lib.mkOptionDefault {
    "${modifier}+e" = null;
    "${modifier}+slash" = "layout toggle split";

    "${modifier}+9" = "exec ${commands.lock}";
    "${modifier}+Shift+9" = null;

    "${modifier}+Shift+e" = null;
    "${modifier}+0" = "exec ${commands.power}";
    "${modifier}+Shift+0" = null;

    "${modifier}+d" = "exec ${commands.menu}";

    "Control+Up" = "exec --no-startup-id ${commands.volume.increase}";
    "Control+Down" = "exec --no-startup-id ${commands.volume.decrease}";

    "XF86AudioRaiseVolume" = "exec --no-startup-id ${commands.volume.increase}";
    "XF86AudioLowerVolume" = "exec --no-startup-id ${commands.volume.decrease}";
    "XF86AudioMute" = "exec --no-startup-id ${commands.volume.mute}";
    "XF86AudioMicMute" = "exec --no-startup-id ${commands.volume.muteMic}";

    "XF86MonBrightnessUp" = "exec --no-startup-id ${commands.brightness.increase}";
    "XF86MonBrightnessDown" = "exec --no-startup-id ${commands.brightness.decrease}";

    "Print" = "exec ${commands.myshotfull}";
    "${modifier}+Print" = "exec ${commands.myshot}";
  };
}
