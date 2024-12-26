{pkgs, ...}: {
  home.packages = with pkgs; [
    go
    gofumpt
    gotools
    gopls
  ];
}
