{pkgs, ...}: {
  home.packages = with pkgs; [
    rustup
    # cargo
    # rustc
    # rust-analyzer
    # rustfmt
    gcc # for cargo build

    ### Wasm
    wasm-pack
    wasm-bindgen-cli
    binaryen
  ];
  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
