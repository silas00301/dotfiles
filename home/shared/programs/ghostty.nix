{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
      background-opacity = 0.9;
      font-family = "Maple Mono NF CN";
      background-blur = true;
      confirm-close-surface = false;
    };
  };
}
