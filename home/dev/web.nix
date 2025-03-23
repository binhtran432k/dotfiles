{pkgs, ...}: {
  home.packages = with pkgs; [
    ### Package Manager
    bun
    nodejs
    # LSP
    vscode-langservers-extracted
    # Formatter
    biome
    nodePackages.prettier
  ];
  home.sessionPath = [
    "$HOME/.bun/bin"
  ];
}
