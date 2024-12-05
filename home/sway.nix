args @ {pkgs, ...}: let
  fonts = {
    names = ["monospace"];
    size = 10.0;
  };
  keybindingsOpts = import ./sway/keybindings.nix args;
  colorsOpts = import ./sway/colors.nix;
in {
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export NIXOS_OZONE_WL=1
      export SDL_VIDEODRIVER=wayland
      # needs qt5.qtwayland in systemPackages
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      # Fix for some Java AWT applications (e.g. Android Studio),
      # use this if they aren't displayed properly:
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';
    config = {
      inherit fonts;
      modifier = keybindingsOpts.modifier;
      terminal = "${pkgs.kitty}/bin/kitty";
      defaultWorkspace = "workspace number 1";
      output = import ./sway/output.nix;
      floating = {
        titlebar = true;
        border = 1;
      };
      window = import ./sway/window.nix;
      input = import ./sway/input.nix;
      gaps = {
        inner = 14;
        outer = -2;
        smartGaps = true;
        smartBorders = "on";
      };
      startup = import ./sway/startup.nix args;
      assigns = import ./sway/assigns.nix;
      modes = import ./sway/modes.nix;
      keybindings = keybindingsOpts.keybindings;
      colors = colorsOpts.colors;
      bars = [
        {
          inherit fonts;
          mode = "dock";
          hiddenState = "hide";
          position = "bottom";
          workspaceButtons = true;
          workspaceNumbers = true;
          statusCommand = "${pkgs.i3status}/bin/i3status";
          trayOutput = "primary";
          colors = colorsOpts.barColors;
        }
      ];
    };
  };
}
