{ pkgs, ... }:
{
  home.packages = [
    pkgs.awscli2
    pkgs.spotify
  ];
}
