{config, pkgs, ...}: {
  gtk = {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };

  xdg.configFile = {
    "gtk-3.0/gtk.css".source = ./gtk/gtk.css;
    "gtk-4.0/gtk.css".source = ./gtk/gtk.css;
  };
}
