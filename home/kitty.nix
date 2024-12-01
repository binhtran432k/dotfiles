{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    font = {
      name = "Maple Mono";
      package = pkgs.maple-mono;
    };
    themeFile = "Dracula";
    settings = {
      cursor_trail = 1;
    };
  };
}
