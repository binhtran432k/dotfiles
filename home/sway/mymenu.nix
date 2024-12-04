{pkgs, ...}: let
  ## define the font for dmenu to be used
  fn = "Noto Sans 12";
  ## background colour for unselected menu-items
  nb = "282A36";
  ## textcolour for unselected menu-items
  nf = "F8F8F2";
  ## background colour for selected menu-items
  sb = "6272A4";
  ## textcolour for selected menu-items
  sf = nf;
  ## export our variables
  options = "-f'${fn}' -n${nf} -N${nb} -s${sf} -S${sb}";
in
  pkgs.writeShellScriptBin "mymenu" ''
    COMMAND=$1
    case "$COMMAND" in
      run)
        shift
        exec ${pkgs.wmenu}/bin/wmenu-run ${options} $@
        ;;
      *)
        exec ${pkgs.wmenu}/bin/wmenu ${options} $@
        ;;
    esac
  ''
