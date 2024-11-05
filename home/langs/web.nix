{pkgs, ...}: {
  home.packages = with pkgs; [
    biome
    prettierd
    vscode-langservers-extracted
    typescript-language-server
    nodejs
    bun
    deno
  ];
}
