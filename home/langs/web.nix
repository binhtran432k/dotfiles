{pkgs, ...}: {
  home.packages = with pkgs; [
    ### Package Manager
    nodejs
    bun
    ### Formatter
    biome
    prettierd
  ];
}
