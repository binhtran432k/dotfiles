{ pkgs, ... }:
let
  notifySend = "${pkgs.libnotify}/bin/notify-send -t 1500";
in
pkgs.writeShellScriptBin "myshot" ''
  COMMAND=$1
  case "$COMMAND" in
    full)
      shift
      (${pkgs.grim}/bin/grim - | ${pkgs.wl-clipboard}/bin/wl-copy) && ${notifySend} "Take screenshot full"
      ;;
    *)
      (${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d)" - | ${pkgs.wl-clipboard}/bin/wl-copy) && "Take screenshot"
      ;;
  esac
''
