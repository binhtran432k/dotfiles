{pkgs, ...}: {
  home.packages = with pkgs; [
    dotnet-sdk
    omnisharp-roslyn
  ];
}
