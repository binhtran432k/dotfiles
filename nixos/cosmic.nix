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
    # Enable the login manager
    displayManager.cosmic-greeter.enable = true;
    desktopManager.cosmic = {
      # Enable the COSMIC DE itself
      enable = true;
      # Enable XWayland support in COSMIC
      xwayland.enable = true;
    };
  };
  environment.systemPackages = with pkgs; [
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
  ];
}
