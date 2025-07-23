set -gx DENO_HOME "$HOME/.deno"
if test -d $DENO_HOME
    source "$DENO_HOME/env.fish"
end
