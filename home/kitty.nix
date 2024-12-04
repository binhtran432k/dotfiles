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
      symbol_map = "U+23FB-U+23FE,U+2665,U+26a1,U+2b58,U+e000-U+e00a,U+e0a0-U+e0a2,U+e0a3,U+e0b0-U+e0b3,U+e0b4-U+e0c8,U+e0ca,U+e0cc-U+e0d4,U+e200-U+e2a9,U+e300-U+e3eb,U+e5fa-U+e631,U+e700-U+e7c5,U+ea60-U+ebeb,U+f000-U+f2e0,U+f300-U+f32f,U+f400-U+f4a8,U+f4a9,U+f500-U+fd46 Symbols Nerd Font Mono";
    };
  };
}
