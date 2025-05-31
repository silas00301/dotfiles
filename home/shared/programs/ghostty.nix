{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
      background-opacity = 0.9;
      font-family = "Maple Mono NF";
      background-blur = true;
    };
  };
}
