{ pkgs, ... }:
pkgs.writeShellScriptBin "switch_brightness.sh" ''
  curr=$(${pkgs.light}/bin/light -G)
  result=$(awk -v n="$curr" -v a="$1" -v b="$2" '
    function abs(x) {
      return (x < 0) ? -x : x
    }
    BEGIN {
      diff_a = abs(n - a)
      diff_b = abs(n - b)

      if (diff_a < diff_b) {
        print b
      } else {
        print a
      }
    }
  ')
  ${pkgs.light}/bin/light -S $result
  exit 0
''
