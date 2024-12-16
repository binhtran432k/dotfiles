{pkgs, ...}: {
  home.packages = with pkgs; [
    ### Package Manager
    nodejs
    pnpm
    bun
    ### Language Servers
    tailwindcss-language-server
    ### Formatter
    biome
    prettierd
  ];
}
