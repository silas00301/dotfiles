{pkgs-stable, ...}: 
{
  programs.thefuck = {
    enable = true;
    package = pkgs-stable.thefuck;
    enableFishIntegration = true;
  };
}
