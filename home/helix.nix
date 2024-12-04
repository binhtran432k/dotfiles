{config, ...}: {
  programs.helix = {
    enable = true;
  };

  xdg.configFile."helix" = config.lib.file.mkDotfilesSymlink "home/helix";
}
