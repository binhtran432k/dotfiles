# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{
  pkgs,
  inputs,
  ...
}: let
  defaultUsername = "binhtran432k";
in {
  imports = [
    ../share.nix
    ../../nixos/core_pkgs.nix
    ../../nixos/fish.nix
    ../../nixos/nix.nix
    ../../nixos/nix-ld.nix
    ../../nixos/podman.nix
    ../../nixos/wsl.nix

    ### Home Manager
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${defaultUsername} = import ./home.nix;
    extraSpecialArgs = {
      inherit inputs;
    };
  };

  wsl.defaultUser = defaultUsername;

  users.defaultUserShell = pkgs.fish;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
