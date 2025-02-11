{config, ...}: {
  programs.zellij = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
  };
  home.shellAliases = {
    zlj = "zellij";
  };
  xdg.configFile."zellij" = config.lib.file.mkDotfilesSymlink "home/zellij";
}
