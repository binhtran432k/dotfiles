{ pkgs, ... }:
{
  boot = {
    plymouth.enable = true;
    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
  };
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };
  environment.plasma6.excludePackages = with pkgs; [
    kdePackages.elisa # Simple music player aiming to provide a nice experience for its users
    kdePackages.kdepim-runtime # Akonadi agents and resources
    kdePackages.kmahjongg # KMahjongg is a tile matching game for one or two players
    kdePackages.kmines # KMines is the classic Minesweeper game
    kdePackages.konversation # User-friendly and fully-featured IRC client
    kdePackages.kpat # KPatience offers a selection of solitaire card games
    kdePackages.ksudoku # KSudoku is a logic-based symbol placement puzzle
    kdePackages.ktorrent # Powerful BitTorrent client
  ];
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme # for lacking icon in gtk apps
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
  ];
}
