{pkgs, ...}: let
  modifier = "Mod4";
in {
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      modifier = modifier;
      terminal = "${pkgs.kitty}/bin/kitty";
    };
  };

  home.packages = with pkgs; [wl-clipboard];
}
