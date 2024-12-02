{pkgs, ...}: {
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [swayidle libnotify wl-clipboard];
  };

  security.pam.services.sway = {};

  security.polkit.enable = true;

  # Performance: enable realtime for users group
  security.pam.loginLimits = [
    {
      domain = "@users";
      item = "rtprio";
      type = "-";
      value = 1;
    }
  ];

  # Brightness: need "video" in user extraGroups
  programs.light.enable = true;
}
