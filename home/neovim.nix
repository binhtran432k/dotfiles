{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
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
      nodejs
      typescript
    ];
  };

  # Make symlink for neovim configs
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
}
