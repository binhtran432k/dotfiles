{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Binh Tran";
        email = "binhtran432k@gmail.com";
      };
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      credential.helper = [
        "cache --timeout 21600" # six hours
        "oauth"
      ];
    };
  };

  home.packages = [ pkgs.xdg-utils ];

  programs.git-credential-oauth.enable = true;
}
