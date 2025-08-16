{
  programs.fuzzel = {
    enable = true;
    settings = {
      colors = {
        background = "111122dd";
        text = "ffffeeff";
        match = "55bbffff";
        selection-match = "55bbffff";
        selection = "444455dd";
        selection-text = "ffffeeff";
        border = "bb99ffff";
        input = "bbbbccff";
      };
      border = {
        width = 2;
        radius = 4;
      };
      key-bindings = {
        delete-line-forward = "none";
        prev = "Control+k Up";
        next = "Control+j Down";
      };
    };
  };
}
