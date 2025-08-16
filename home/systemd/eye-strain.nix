{ pkgs, ... }:
{
  systemd.user = {
    services = {
      eye-strain-notify = {
        # Install.WantedBy = [ "default.target" ];
        Service.ExecStart = "${pkgs.libnotify}/bin/notify-send 'Break' 'Eye strain break 20 secs!' -u critical";
        Unit.Description = "Send notification to take 20sec break for preventing eye strain.";
      };
      stretch-notify = {
        # Install.WantedBy = [ "default.target" ];
        Service.ExecStart = "${pkgs.libnotify}/bin/notify-send 'Break' 'Stretch!' -u critical";
        Unit.Description = "Send notification to take a break and stretch.";
      };
    };
    timers = {
      eye-strain-notify = {
        Install.WantedBy = [ "timers.target" ];
        Timer.OnCalendar = "*-*-* *:20,40:00";
        Unit.Description = "Trigger eye strain notification on 20 and 40 min mark of every hour.";
      };
      stretch-notify = {
        Install.WantedBy = [ "timers.target" ];
        Timer.OnCalendar = "*-*-* *:00:00";
        Unit.Description = "Trigger strecth notification every hour.";
      };
    };
  };
}
