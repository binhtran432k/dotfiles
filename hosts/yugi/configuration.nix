# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  pkgs,
  inputs,
  ...
}: let
  defaultUsername = "binhtran432k";
in {
  imports = [
    ./hardware-configuration.nix
    ./hardware-extra.nix
    ../../hardwares/dell-latitude-e6440.nix

    ../share.nix
    ../../nixos/core_pkgs.nix
    ../../nixos/fish.nix
    ../../nixos/nix.nix
    ../../nixos/fonts.nix
    ../../nixos/input-method.nix
    ../../nixos/light.nix
    ../../nixos/network.nix
    ../../nixos/nix-ld.nix
    ../../nixos/podman.nix
    ../../nixos/sound.nix
    ../../nixos/sway.nix
    ../../nixos/touchpad.nix

    ### Home Manager
    inputs.home-manager.nixosModules.home-manager
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "yugi-binhtran432k";

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${defaultUsername} = {
    isNormalUser = true;
    initialPassword = "changeme";
    extraGroups = ["wheel" "networkmanager" "video"]; # Enable ‘sudo’ for the user.
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${defaultUsername} = import ./home.nix;
    extraSpecialArgs = {
      inherit inputs;
    };
  };

  users.defaultUserShell = pkgs.fish;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
