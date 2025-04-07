set -gx CARGO_HOME "$HOME/.cargo"
if not string match -q -- $CARGO_HOME/bin $PATH
    set -gx PATH $CARGO_HOME/bin $PATH
end
