{pkgs, ...}: {
  systemd.user = {
    services = {
      eye-strain-notify = {
        wantedBy = ["default.target"];
        description = "Send notification to take 20sec break for preventing eye strain.";
        script = "${pkgs.libnotify}/bin/notify-send 'Break' 'Eye strain break 20 secs!' -u critical";
      };
      stretch-notify = {
        wantedBy = ["default.target"];
        description = "Send notification to take a break and stretch.";
        script = "${pkgs.libnotify}/bin/notify-send 'Break' 'Stretch!' -u critical";
      };
    };
    timers = {
      eye-strain-notify = {
        wantedBy = ["timers.target"];
        description = "Trigger eye strain notification on 20 and 40 min mark of every hour.";
        timerConfig.OnCalendar = "*-*-* *:20,40:00";
      };
      stretch-notify = {
        wantedBy = ["timers.target"];
        description = "Trigger strecth notification every hour.";
        timerConfig.OnCalendar = "*-*-* *:00:00";
      };
    };
  };
}
