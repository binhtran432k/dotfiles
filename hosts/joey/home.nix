{
  # You can import other home-manager modules here
  imports = [
    # Modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    ./share.nix
    ../../home/bash.nix
    ../../home/eza.nix
    ../../home/fish.nix
    ../../home/git.nix
    ../../home/gitui.nix
    ../../home/neovim.nix
    ../../home/zoxide.nix
    ../../home/zellij.nix

    ../../home/langs/lua.nix
    ../../home/langs/nix.nix
    ../../home/langs/web.nix
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;

  # Make neovim as default editor
  programs.neovim.defaultEditor = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home = rec {
    username = "binhtran432k";
    homeDirectory = "/home/binhtran432k";
    shellAliases = let
      dotPath = "${homeDirectory}/dotfiles";
    in {
      mkhome = "home-manager switch --flake ${dotPath}#binhtran432k@joey";
      mknixos = "sudo nixos-rebuild switch --flake ${dotPath}#joey --fast";
    };

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.05"; # Please read the comment before changing.
  };
}
