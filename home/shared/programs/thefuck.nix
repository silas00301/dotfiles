{ pkgs-stable, ... }:
{
  programs.thefuck = {
    enable = true;
    package = pkgs-stable.thefuck;
    enableNushellIntegration = true;
    enableFishIntegration = true;
  };
}
