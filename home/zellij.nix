{
  programs.zellij = {
    enable = true;
  };
  home.shellAliases = {
    zlj = "zellij attach --create main";
  };
  xdg.configFile."zellij" = {
    source = ./zellij;
    recursive = true;
  };
}
