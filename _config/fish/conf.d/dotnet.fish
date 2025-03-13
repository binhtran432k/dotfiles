export DOTNET_INSTALL="$HOME/.dotnet"
if test -d $DOTNET_INSTALL
    export PATH="$DOTNET_INSTALL:$PATH"
end
