{pkgs, ...}: {
  home.packages = with pkgs; [
    vscode-langservers-extracted
    # Tree-sitter
    tree-sitter
    node-gyp
  ];
}
