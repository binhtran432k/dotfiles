{
  pkgs,
  pkgs-unstable,
  pkgs-node,
  ...
}: {
  home.packages =
    (with pkgs; [
      biome
      prettierd
    ])
    ++ (with pkgs-unstable; [
      bun
      deno
    ])
    ++ (with pkgs-node; [
      nodejs
      vscode-langservers-extracted
      typescript-language-server
    ]);
}
