{pkgs, ...}: {
  home.packages =
    [
      (pkgs.python3.withPackages (python-pkgs: [
        # python-pkgs.pandas
        # python-pkgs.requests
        python-pkgs.pytest
      ]))
    ]
    ++ (with pkgs; [
      basedpyright
      ruff
    ]);
}
