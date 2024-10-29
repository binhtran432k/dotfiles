{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages =
    (with pkgs; [
      nodejs
      biome
      prettierd
      nodePackages.vscode-langservers-extracted
    ])
    ++ (with pkgs-unstable; [
      bun
    ]);
}
