{
  pkgs,
  lib,
  ...
}: let
  modifier = "Mod4";
  colors = rec {
    background = "#282A36";
    urgent = "#FF5555";
    text = "#F8F8F2";
    indicator = "#6272A4";
    focused = "#BD93F9";
    focusedInactive = separator;
    unfocused = background;
    border = separator;
    separator = "#44475A";
  };
in {
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      modifier = modifier;
      terminal = "${pkgs.kitty}/bin/kitty";
      startup = [
        # { command = "fcitx5 -dr"; }
      ];
      assigns = {
        "2" = [{class = "^Brave-browser$";}];
        "3" = [{class = "^thunderbird$";}];
      };
      output = {
        eDP-1 = {
          scale = "1.2";
        };
      };
      modes = {
        resize = {
          "Left" = "resize shrink width 10 px or 10 ppt";
          "Down" = "resize grow height 10 px or 10 ppt";
          "Up" = "resize shrink height 10 px or 10 ppt";
          "Right" = "resize grow width 10 px or 10 ppt";
          "Ctrl+bracketleft" = "mode default";
          "Escape" = "mode default";
          "Return" = "mode default";
        };
        open = {
          # "d" = "exec --no-startup-id ${commands.dict}, mode default";
          "b" = "exec --no-startup-id brave, mode default";
          "m" = "exec --no-startup-id thunderbird, mode default";
          # "c" = "exec --no-startup-id ${commands.calc}, mode default";
          "Ctrl+bracketleft" = "mode default";
          "Escape" = "mode default";
          "Return" = "mode default";
        };
      };
      keybindings = lib.mkOptionDefault {
        "${modifier}+d" = "exec ${pkgs.wmenu}/bin/wmenu-run";
      };
      colors = with colors; {
        inherit background;
        urgent = {
          inherit background indicator text;
          border = urgent;
          childBorder = urgent;
        };
        focused = {
          inherit indicator text;
          background = focusedInactive;
          border = focused;
          childBorder = focused;
        };
        focusedInactive = {
          inherit indicator text;
          background = focusedInactive;
          border = focusedInactive;
          childBorder = focusedInactive;
        };
        unfocused = {
          inherit background indicator text;
          border = unfocused;
          childBorder = unfocused;
        };
        placeholder = {
          inherit background indicator text;
          border = unfocused;
          childBorder = unfocused;
        };
      };
      bars = [
        {
          mode = "dock";
          hiddenState = "hide";
          position = "bottom";
          workspaceButtons = true;
          workspaceNumbers = true;
          statusCommand = "${pkgs.i3status}/bin/i3status";
          fonts = {
            names = ["monospace"];
            size = 9.0;
          };
          trayOutput = "primary";
          colors = with colors; {
            inherit background separator;
            statusline = text;
            focusedWorkspace = {
              inherit text;
              background = focusedInactive;
              border = focused;
            };
            activeWorkspace = {
              inherit border background;
              text = focused;
            };
            inactiveWorkspace = {
              inherit text border background;
            };
            urgentWorkspace = {
              inherit text background;
              border = urgent;
            };
            bindingMode = {
              inherit text border;
              background = urgent;
            };
          };
        }
      ];
    };
  };

  programs.i3status = {
    enable = true;
    general = {
      colors = true;
      color_good = "#50FA7B";
      color_degraded = "#F1FA8C";
      color_bad = "#FF5555";
      interval = 1;
    };
  };
}
