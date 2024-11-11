{config, ...}: {
  programs.helix = {
    enable = true;
  };

  xdg.configFile."helix".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home/helix";
}
