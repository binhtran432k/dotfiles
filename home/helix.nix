{ config, ... }:
{
  programs.helix = {
    enable = true;
  };
  home.file."${config.xdg.configHome}/helix" = {
    source = ./helix;
    recursive = true;
  };
}
