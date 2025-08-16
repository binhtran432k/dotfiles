{ pkgs, ... }:
{
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
      maple-mono.NF
    ];
    fontconfig.defaultFonts = {
      serif = [
        "Noto Serif"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Noto Sans"
        "Noto Color Emoji"
      ];
      monospace = [
        "Maple Mono NF"
        "Noto Sans Mono"
        "Noto Color Emoji"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
