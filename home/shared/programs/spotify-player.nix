{pkgs, ... }: {
  programs.spotify-player = {
    enable = true;
  };

  home.packages = [
    pkgs.librespot
  ];
}
