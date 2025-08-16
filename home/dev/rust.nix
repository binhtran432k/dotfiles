{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # rustup
    cargo
    rustc
    rust-analyzer
    rustfmt
    gcc # for cargo build
    wit-bindgen
    wasm-tools
  ];
  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
