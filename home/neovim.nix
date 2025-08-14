{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      ### plugins installer
      gnumake
      git
      unzip
      ### treesitter
      tree-sitter
      gcc
      ### telescope
      ripgrep
      fzf
      fd
      ### typescript-tools
      nodejs
      typescript
    ];
  };
}
