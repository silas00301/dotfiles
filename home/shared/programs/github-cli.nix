{ pkgs, ... }:
{
  programs.gh = {
    enable = true;
    extensions = [
      pkgs.gh-skyline
    ];
    gitCredentialHelper = {
      enable = true;
      hosts = [
        "https://github.com"
        "https://gist.github.com"
      ];
    };
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      aliases = {
        co = "pr checkout";
        web = "repo view --web";
      };
    };
  };
}
