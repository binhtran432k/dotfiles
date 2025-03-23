export DOTNET_ROOT="$HOME/.dotnet"
if test -d $DOTNET_ROOT
    export PATH="$DOTNET_ROOT:$DOTNET_ROOT/tools:$PATH"
end
