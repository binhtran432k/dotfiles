{config, ...}: {
  programs.zellij = {
    enable = true;
  };
  home.shellAliases = {
    zlj = "zellij attach --create main";
  };
  xdg.configFile."zellij".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home/zellij";
}
