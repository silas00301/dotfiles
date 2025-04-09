{
  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
    enableFishIntegration = true;
    options = [ "--cmd cd" ];
  };
}
