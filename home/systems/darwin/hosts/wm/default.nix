{ pkgs, ... }:
{
  imports = [
    ./aerospace
  ];

  home.packages = [
    pkgs.awscli2
    pkgs.spotify
  ];
}
