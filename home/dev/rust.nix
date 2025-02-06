{pkgs, ...}: {
  home.packages = with pkgs; [
    cargo
    rustc
    rust-analyzer
    rustfmt
    gcc # for cargo build
  ];
}
