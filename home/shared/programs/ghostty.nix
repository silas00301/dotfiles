{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
      backgrond-opacity = 0.9;
    };
  };
}
