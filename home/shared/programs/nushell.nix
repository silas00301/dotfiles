{pkgs, ...}:
{
  programs.nushell = {
    enable = true;
    plugins = with pkgs.nushellPlugins; [
      highlight
    ];
  };
}
