{ config, pkgs, ... }:

{
  homebrew.enable = true;

  homebrew.casks = [
    # currently needs manual install because of some bug
    #"logi-options+"
    "amethyst"
    #"bitwarden-cli"
    "obsidian"
    "raycast"
    "arc"
  ];

  environment.interactiveShellInit = ''
    $PATH=/etc/profiles/per-user/${config.username}/bin:$PATH
  '';

  users.users.${config.username}.shell = pkgs.fish;

  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "Nlsv";
      ShowPathbar = true;
      ShowStatusBar = true;
    };
  };
}
