{pkgs, ...}: {
  wsl.enable = true;
  environment.systemPackages = with pkgs; [
    win32yank # terminal clipboard for wsl
  ];
}
