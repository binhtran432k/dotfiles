{
  services.mako = {
    enable = true;
    settings = {
      text-color = "#ffffee";
      background-color = "#111122";
      sort = "-time";
      layer = "overlay";
      width = 300;
      height = 110;
      border-size = 2;
      border-color = "#bb99ff";
      border-radius = 4;
      icons = true;
      max-icon-size = 64;
      default-timeout = 5000;
      ignore-timeout = true;
      font = "monospace 12";
      "urgency=low" = {
        border-color = "#6677aa";
      };
      "urgency=normal" = {
        border-color = "#bb99ff";
      };
      "urgency=critical" = {
        border-color = "#ff5555";
        default-timeout = 0;
      };
      "urgency=high" = {
        border-color = "#ff5555";
        default-timeout = 0;
      };
      "category=mpd" = {
        default-timeout = 2000;
        group-by = "category";
      };
    };
  };
}
