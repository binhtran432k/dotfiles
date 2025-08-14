{ config, ... }:
{
  programs.zellij = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
  };
  home = {
    shellAliases = {
      zlj = "zellij";
    };
    file."${config.xdg.configHome}/zellij" = {
      source = ./zellij;
      recursive = true;
    };
  };
}
