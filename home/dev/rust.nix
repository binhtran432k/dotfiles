{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rustup
    # cargo
    # rustc
    # rust-analyzer
    # rustfmt
    gcc # for cargo build
  ];
  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
