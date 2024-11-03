{
  config,
  pkgs,
  pkgs-node,
  pkgs-unstable,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = pkgs-unstable.neovim-unwrapped;
    extraPackages =
      (with pkgs; [
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
      ])
      ++ (with pkgs-node; [
        nodejs # typescript-tools
      ])
      ++ (with pkgs-unstable; [
        typescript # typescript-tools
      ])
      ;
  };

  # Make symlink for neovim configs
  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
  };
}
