args @ {
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
  packages = {
    mycontrol = import ./sway/mycontrol.nix args;
    mymenu = import ./sway/mymenu.nix args;
    mypower = import ./sway/mypower.nix args;
    myshot = import ./sway/myshot.nix args;
  };
  commands = {
    lock = "${pkgs.swaylock}/bin/swaylock";
    menu = "${packages.mymenu}/bin/mymenu run";
    power = "${packages.mypower}/bin/mypower";
    myshot = "${packages.myshot}/bin/myshot";
    myshotfull = "${packages.myshot}/bin/myshot full";
    volume = {
      increase = "${packages.mycontrol}/bin/mycontrol volume up 10";
      decrease = "${packages.mycontrol}/bin/mycontrol volume down 10";
      mute = "${packages.mycontrol}/bin/mycontrol volume mute";
      muteMic = "${packages.mycontrol}/bin/mycontrol volume mute_mic";
    };
    brightness = {
      # increase = "${packages.mycontrol}/bin/mycontrol brightness up 10";
      # decrease = "${packages.mycontrol}/bin/mycontrol brightness down 10";
      # Because of actkbd already use it
      increase = "${packages.mycontrol}/bin/mycontrol brightness get";
      decrease = "${packages.mycontrol}/bin/mycontrol brightness get";
    };
  };
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
      modifier = modifier;
      terminal = "${pkgs.kitty}/bin/kitty";
      fonts = {
        names = ["monospace"];
        size = 10.0;
      };
      defaultWorkspace = "workspace number 1";
      output = {
        "*" = {
          bg = "${../assets/swaybg.png} fill";
        };
        eDP-1 = {
          scale = "1.2";
        };
      };
      floating = {
        titlebar = true;
        border = 1;
      };
      window = {
        titlebar = false;
        border = 1;
        commands = [
          {
            criteria = {urgent = "latest";};
            command = "focus";
          }
          {
            criteria = {window_role = "pop-up,task_dialog,About";};
            command = "floating enable";
          }
          {
            criteria = {app_id = ".*";};
            command = "inhibit_idle fullscreen";
          }
          {
            criteria = {class = ".*";};
            command = "inhibit_idle fullscreen";
          }
        ];
      };
      input = {
        "type:touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
        };
        "type:keyboard" = {
          repeat_delay = "300";
          repeat_rate = "50";
        };
      };
      gaps = {
        inner = 14;
        outer = -2;
        smartGaps = true;
        smartBorders = "on";
      };
      startup = [
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
      ];
      assigns = {
        "2" = [{class = "^Brave-browser$";} {app_id = "brave-browser";}];
        "3" = [{class = "^thunderbird$";} {app_id = "thunderbird";}];
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
