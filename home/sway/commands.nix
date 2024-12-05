args @ {pkgs, ...}: let
  packages = {
    mycontrol = import ./scripts/mycontrol.nix args;
    mymenu = import ./scripts/mymenu.nix args;
    mypower = import ./scripts/mypower.nix args;
    myshot = import ./scripts/myshot.nix args;
  };
in {
  inherit packages;
  commands = {
    lock = "${pkgs.swaylock}/bin/swaylock";
    menu = "${packages.mymenu}/bin/mymenu run";
    power = "${packages.mypower}/bin/mypower";
    myshot = "${packages.myshot}/bin/myshot";
    myshotfull = "${packages.myshot}/bin/myshot full";
    volume = {
      increase = "${packages.mycontrol}/bin/mycontrol volume up 10";
      decrease = "${packages.mycontrol}/bin/mycontrol volume down 10";
      mute = "${packages.mycontrol}/bin/mycontrol volume mute";
      muteMic = "${packages.mycontrol}/bin/mycontrol volume mute_mic";
    };
    brightness = {
      # increase = "${packages.mycontrol}/bin/mycontrol brightness up 10";
      # decrease = "${packages.mycontrol}/bin/mycontrol brightness down 10";
      # Because of actkbd already use it
      increase = "${packages.mycontrol}/bin/mycontrol brightness get";
      decrease = "${packages.mycontrol}/bin/mycontrol brightness get";
    };
  };
}
