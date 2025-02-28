{pkgs, ...}: {
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      # Microsoft fonts
      corefonts
      vistafonts

      # Desktop
      noto-fonts
      noto-fonts-emoji

      # Mono
      maple-mono
    ];
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["Maple Mono" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };
}
