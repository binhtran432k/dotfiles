{
  config,
  pkgs,
  ...
}:
let
  username = "binhtran432k";
  homeDirectory = "/home/${username}";
in
{
  # You can import other home-manager modules here
  imports = [
    # Modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    ../../home/alacritty.nix
    ../../home/bash.nix
    ../../home/cursor.nix
    ../../home/eza.nix
    ../../home/fish.nix
    ../../home/fzf.nix
    ../../home/git.nix
    ../../home/desktop.nix
    ../../home/helix.nix
    ../../home/i3status.nix
    ../../home/lazygit.nix
    ../../home/mako.nix
    ../../home/ripgrep.nix
    ../../home/sway.nix
    ../../home/swaylock.nix
    ../../home/yazi.nix
    ../../home/zoxide.nix
    ../../home/zellij.nix

    ../../home/dev/clang.nix
    ../../home/dev/go.nix
    ../../home/dev/lua.nix
    ../../home/dev/markdown.nix
    ../../home/dev/misc.nix
    ../../home/dev/nix.nix
    ../../home/dev/python.nix
    ../../home/dev/rust.nix
    ../../home/dev/toml.nix
    ../../home/dev/tree-sitter.nix
    ../../home/dev/web.nix
    ../../home/dev/yaml.nix
    ../../home/dev/zig.nix
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;

  programs.helix.defaultEditor = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home = {
    inherit username homeDirectory;
    shellAliases = {
      mknixos = "nixos-rebuild switch --flake ${homeDirectory}/dotfiles#yugi --sudo";
      mkhome = "home-manager switch --flake ${homeDirectory}/dotfiles#yugi";
    };
    sessionVariables = {
      BROWSER = "${pkgs.brave}/bin/brave";
      DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = 1;
    };
    packages = with pkgs; [
      # Browser
      brave
      # Mail
      thunderbird
      # Learning
      exercism
      # Office
      onlyoffice-bin
      # Media
      mpv
      vimiv-qt
      # Utils
      gimp
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
