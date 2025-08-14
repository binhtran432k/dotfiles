{ config, ... }:
{
  programs.lazygit = {
    enable = true;
  };
  home = {
    shellAliases = {
      lg = "lazygit";
    };
    file."${config.xdg.configHome}/lazygit" = {
      source = ./lazygit;
      recursive = true;
    };
  };
}
