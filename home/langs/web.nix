{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages =
    (with pkgs; [
      nodejs
      nodePackages.vscode-langservers-extracted
    ])
    ++ (with pkgs-unstable; [
      bun
    ]);
}
