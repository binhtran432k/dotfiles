{config, ...}: {
  programs.zellij = {
    enable = true;
  };
  home.shellAliases = {
    zlj = "zellij attach --create main";
  };
  xdg.configFile."zellij" = config.lib.file.mkDotfilesSymlink "home/zellij";
}
