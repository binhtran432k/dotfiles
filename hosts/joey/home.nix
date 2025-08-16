{
  # You can import other home-manager modules here
  imports = [
    # Modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    ../../home/fish.nix
    ../../home/git.nix
    ../../home/helix.nix
    ../../home/lazygit.nix
    ../../home/neovim.nix
    ../../home/yazi.nix
    ../../home/zellij.nix

    ../../home/dev/python.nix
    ../../home/dev/rust.nix
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
    shellAliases =
      let
        dotPath = "${homeDirectory}/dotfiles";
      in
      {
        mknixos = "sudo nixos-rebuild switch --flake ${dotPath}#joey --fast";
      };
    sessionVariables = {
      BROWSER = "/mnt/c/Program Files/BraveSoftware/Brave-Browser/Application/brave.exe";
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
