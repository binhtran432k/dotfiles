# fnm
set FNM_PATH "/home/binhtran432k/.local/share/fnm"
if test -d $FNM_PATH
  and not string match -q -- $FNM_PATH $PATH
  set -gx PATH "$FNM_PATH" $PATH
  fnm env | source
end
