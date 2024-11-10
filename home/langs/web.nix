{pkgs, ...}: {
  home.packages = with pkgs; [
    ### Package Manager
    nodejs
    bun
    ### Language Servers
    tailwindcss-language-server
    ### Formatter
    biome
    prettierd
  ];
}
