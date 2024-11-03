{ pkgs-unstable, ...}:
{
  programs.helix = {
    enable = true;
    package = pkgs-unstable.helix;
    settings = {
      theme = "dracula";
    };
  };
}
