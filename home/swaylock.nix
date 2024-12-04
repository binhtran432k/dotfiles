{
  programs.swaylock = {
    enable = true;
    settings = {
      daemonize = true;
      image = "${../assets/swaybg.png}";
      color = "282A36ee";
      indicator-radius = 100;
      inside-ver-color = "9aedfe";
      ring-color = "caa9fa";
      ring-ver-color = "5af78e";
      ring-clear-color = "f4f99d";
      ring-wrong-color = "ff6e67";
      key-hl-color = "ff92d0";
      bs-hl-color = "ff6e67";
    };
  };
}
