{pkgs, ...}: {
  home.packages = with pkgs; [
    cargo
    rustc
    rust-analyzer
    gcc # for cargo build
  ];
}
