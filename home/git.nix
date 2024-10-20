{
  programs.git = {
    enable = true;
    userName = "Binh Tran";
    userEmail = "binhtran432k@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      credential.helper = [
        "cache --timeout 21600" # six hours
        "oauth -device"
      ];
    };
  };

  programs.git-credential-oauth.enable = true;
}
