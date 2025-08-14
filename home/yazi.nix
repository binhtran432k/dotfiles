{ config, ... }:
{
  programs.yazi = {
    enable = true;
  };
  home.file."${config.xdg.configHome}/yazi" = {
    source = ./yazi;
    recursive = true;
  };
}
