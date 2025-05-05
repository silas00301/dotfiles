{pkgs, ...}:
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    plugins = with pkgs; {
      git = yaziPlugins.git;
      glow = yaziPlugins.glow;
      diff = yaziPlugins.diff;
      chmod = yaziPlugins.chmod;
      lazygit = yaziPlugins.lazygit;
    };
  };
}
