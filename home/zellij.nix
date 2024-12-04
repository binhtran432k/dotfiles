{config, ...}: {
  programs.zellij = {
    enable = true;
  };
  home.shellAliases = {
    zlj = "zellij";
  };
  xdg.configFile."zellij" = config.lib.file.mkDotfilesSymlink "home/zellij";
}
