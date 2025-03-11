export BUN_INSTALL="$HOME/.bun"
if test -d $BUN_INSTALL
    export PATH="$BUN_INSTALL/bin:$PATH"
end
