{ config, ... }:
{
  programs.alacritty = {
    enable = true;
  };
  home.file."${config.xdg.configHome}/alacritty" = {
    source = ./alacritty;
    recursive = true;
  };
}
