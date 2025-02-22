{pkgs, ...}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ## downloads utils
    wget
    curl
    aria2

    git # used by nix flakes

    ## misc
    gnumake
    killall
    zip
    unzip
  ];
}
