{
  services.mako = {
    enable = true;
    textColor = "#f8f8f2";
    backgroundColor = "#282a36";
    sort = "-time";
    layer = "overlay";
    width = 300;
    height = 110;
    borderSize = 2;
    borderColor = "#bd93f9";
    borderRadius = 4;
    icons = true;
    maxIconSize = 64;
    defaultTimeout = 5000;
    ignoreTimeout = true;
    font = "monospace 12";
    extraConfig = ''
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
}
