export DOTNET_ROOT="$HOME/.dotnet"
if test -d $DOTNET_ROOT
    and not string match -q -- $DOTNET_ROOT $PATH
    export PATH="$DOTNET_ROOT:$DOTNET_ROOT/tools:$PATH"
end
