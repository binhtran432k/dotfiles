{pkgs, ...}: {
  home.packages = with pkgs; [
    tree-sitter
    node-gyp
  ];
}
