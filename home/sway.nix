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
  wmenu = rec {
    ## define the font for dmenu to be used
    fn = "Noto Sans 12";
    ## background colour for unselected menu-items
    nb = "282A36";
    ## textcolour for unselected menu-items
    nf = "F8F8F2";
    ## background colour for selected menu-items
    sb = "6272A4";
    ## textcolour for selected menu-items
    sf = nf;
    ## export our variables
    options = "-f'${fn}' -n${nf} -N${nb} -s${sf} -S${sb}";
  };
  commands = {
    volume = {
      increase = "mycontrol volume up 10";
      decrease = "mycontrol volume down 10";
      mute = "mycontrol volume mute";
      mute-mic = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
    };
    brightness = {
      # increase = "mycontrol brightness up 10";
      # decrease = "mycontrol brightness down 10";
      # Because of actkbd already use it
      increase = "mycontrol brightness get";
      decrease = "mycontrol brightness get";
    };
  };
in {
  home.packages = with pkgs; [
    light
    pulseaudio
    libnotify
    (pkgs.writeShellScriptBin "mycontrol" (builtins.readFile ./sway/mycontrol))
  ];
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
      modifier = modifier;
      terminal = "${pkgs.kitty}/bin/kitty";
      startup = [
        {command = "${pkgs.mako}/bin/mako";}
        {
          command =
            "${pkgs.swayidle}/bin/swayidle -w"
            + " timeout 300 'swaylock'"
            + " timeout 600 'swaymsg \"output * power off\"'"
            + " resume 'swaymsg \"output * power on\"'"
            + " before-sleep 'swaylock'";
        }
        # { command = "fcitx5 -dr"; }
      ];
      assigns = {
        "2" = [{class = "^Brave-browser$";} {app_id = "brave-browser";}];
        "3" = [{class = "^thunderbird$";} {app_id = "thunderbird";}];
      };
      defaultWorkspace = "workspace number 1";
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
        "${modifier}+d" = "exec ${pkgs.wmenu}/bin/wmenu-run ${wmenu.options}";

        "Control+Up" = "exec --no-startup-id ${commands.volume.increase}";
        "Control+Down" = "exec --no-startup-id ${commands.volume.decrease}";

        "XF86AudioRaiseVolume" = "exec --no-startup-id ${commands.volume.increase}";
        "XF86AudioLowerVolume" = "exec --no-startup-id ${commands.volume.decrease}";
        "XF86AudioMute" = "exec --no-startup-id ${commands.volume.mute}";
        "XF86AudioMicMute" = "exec --no-startup-id ${commands.volume.mute-mic}";

        "XF86MonBrightnessUp" = "exec --no-startup-id ${commands.brightness.increase}";
        "XF86MonBrightnessDown" = "exec --no-startup-id ${commands.brightness.decrease}";
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
            size = 10.0;
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
