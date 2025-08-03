set -gx CARGO_HOME "$HOME/.cargo"
if test -d $CARGO_HOME
    source "$HOME/.cargo/env.fish"
    and not string match -q -- $CARGO_HOME/bin $PATH
    set -gx PATH $CARGO_HOME/bin $PATH
end
