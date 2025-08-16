{ config, pkgs, ... }:
{
  home = {
    sessionVariables = {
      GTK_THEME = "adw-gtk3-dark";
    };
  };
  gtk = {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };
  qt = {
    enable = true;
    style.name = "kvantum";
  };
  xdg.configFile = {
    "gtk-3.0/gtk.css".source = ./desktop/gtk.css;
    "gtk-4.0/gtk.css".source = ./desktop/gtk.css;
  };
}
