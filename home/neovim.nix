{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = pkgs-unstable.neovim-unwrapped;
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
      fd
      ### typescript-tools
      typescript
      nodejs
    ];
  };

  # Make symlink for neovim configs
  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
  };
}
