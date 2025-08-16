{ config, ... }:
{
  programs.ghostty = {
    enable = true;
  };
  home.file."${config.xdg.configHome}/ghostty" = {
    source = ./ghostty;
    recursive = true;
  };
}
