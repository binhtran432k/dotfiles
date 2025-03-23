set FNM_PATH "/home/binhtran432k/.local/share/fnm"
if [ -d "$FNM_PATH" ]
  set PATH "$FNM_PATH" $PATH
  fnm env --use-on-cd | source
end
