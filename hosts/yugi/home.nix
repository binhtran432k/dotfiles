{
  config,
  pkgs,
  inputs,
  ...
}: let
  username = "binhtran432k";
  homeDirectory = "/home/${username}";
in {
  # You can import other home-manager modules here
  imports = [
    # Modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default
    inputs.plasma-manager.homeManagerModules.plasma-manager

    ../../home/bash.nix
    ../../home/cursor.nix
    ../../home/eza.nix
    ../../home/fish.nix
    ../../home/git.nix
    ../../home/gtk.nix
    ../../home/helix.nix
    ../../home/kitty.nix
    ../../home/lazygit.nix
    ../../home/neovim.nix
    ../../home/sway.nix
    ../../home/yazi.nix
    ../../home/zoxide.nix
    ../../home/zellij.nix

    ../../home/langs/lua.nix
    ../../home/langs/markdown.nix
    ../../home/langs/misc.nix
    ../../home/langs/nix.nix
    ../../home/langs/python.nix
    ../../home/langs/rust.nix
    ../../home/langs/toml.nix
    ../../home/langs/web.nix
    ../../home/langs/yaml.nix
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;

  # Make neovim as default editor
  programs.neovim.defaultEditor = true;

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  home = {
    inherit username homeDirectory;
    shellAliases = {
      mknixos = "sudo nixos-rebuild switch --flake ${homeDirectory}/dotfiles#yugi --fast";
    };
    packages = with pkgs; [
      brave
      thunderbird
    ];

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.05"; # Please read the comment before changing.
  };
  lib.file.mkDotfilesSymlink = link: {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/${link}";
    force = true;
  };
}
