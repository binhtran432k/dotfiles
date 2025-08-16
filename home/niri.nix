args@{ pkgs, ... }:
{
  # wayland.systemd.target = "niri.service";
  programs = {
    alacritty.enable = true;
    fuzzel.enable = true;
    swaylock.enable = true;
    waybar.enable = true;
  };
  home.packages = with pkgs; [
    libnotify # notify-send
    xwayland-satellite
    wl-clipboard
    (import ./niri/scripts/switch_brightness.nix args)
    (import ./niri/scripts/mycontrol.nix args)
    (import ./niri/scripts/mypower.nix args)
  ];
  xdg.configFile."niri/config.kdl".source = ./niri/config.kdl;
  xdg.configFile."systemd/user/niri.service.wants/mako.service".source =
    "${pkgs.mako}/lib/systemd/user/mako.service";
  xdg.configFile."systemd/user/niri.service.wants/xwayland-satellite.service".source =
    "${pkgs.xwayland-satellite}/lib/systemd/user/xwayland-satellite.service";
  xdg.configFile."systemd/user/niri.service.wants/waybar.service".source =
    "${pkgs.waybar}/lib/systemd/user/waybar.service";
  systemd.user.services = {
    eye-strain-notify.Install.WantedBy = [ "niri.service" ];
    stretch-notify.Install.WantedBy = [ "niri.service" ];
    wpaperd.Install.WantedBy = [ "niri.service" ];
    kanshi.Install.WantedBy = [ "niri.service" ];
    swayidle.Install.WantedBy = [ "niri.service" ];
    gammastep = {
      Install.WantedBy = [ "niri.service" ];
      Service.ExecStart = "${pkgs.gammastep}/bin/gammastep -O3000";
      Service.Restart = "on-failure";
      Unit.Description = "Display colour temperature adjustment";
      Unit.PartOf = "graphical-session.target";
      Unit.After = "graphical-session.target";
    };
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config.common.default = "*";
  };
  services = {
    mako.enable = true;
    wpaperd.enable = true;
    kanshi = {
      enable = true;
      settings = [
        {
          profile.outputs = [
            {
              criteria = "eDP-1";
              scale = 1.2;
            }
          ];
        }
      ];
    };
    swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 600;
          command = "${pkgs.swaylock}/bin/swaylock -fF";
        }
        {
          timeout = 601;
          command = "${pkgs.niri}/bin/niri msg action power-off-monitors";
        }
        {
          timeout = 1200;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.swaylock}/bin/swaylock -fF";
        }
      ];
    };
  };
}
