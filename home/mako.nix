{
  services.mako = {
    enable = true;
    settings = {
      text-color = "#f8f8f2";
      background-color = "#282a36";
      sort = "-time";
      layer = "overlay";
      width = 300;
      height = 110;
      border-size = 2;
      border-color = "#bd93f9";
      border-radius = 4;
      icons = true;
      max-icon-size = 64;
      default-timeout = 5000;
      ignore-timeout = true;
      font = "monospace 12";
      extra-config = ''
        [urgency=low]
        border-color=#6272a4

        [urgency=normal]
        border-color=#bd93f9

        [urgency=critical]
        border-color=#ff5555
        default-timeout=0

        [urgency=high]
        border-color=#ff5555
        default-timeout=0

        [category=mpd]
        default-timeout=2000
        group-by=category
      '';
    };
  };
}
