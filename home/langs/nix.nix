{pkgs, ...}: {
  home.packages = with pkgs; [
    nixd
    alejandra
  ];
}
