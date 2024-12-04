{pkgs, ...}: {
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [swaylock grim wl-clipboard];
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
}
