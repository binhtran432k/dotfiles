{pkgs, ...}: {
  home.packages = with pkgs; [
    zig_0_14
    zls
  ];
}
