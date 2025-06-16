{ lib, config, ... }@inputs:

{
  home.homeDirectory = lib.mkForce "/Users/${inputs.username}";

  imports = [
    ../../../shared/programs/aerospace.nix
    ../../../shared/services/janky-borders.nix
  ];

  programs.fish = {
    shellInit = ''
      eval "$(/opt/homebrew/bin/brew shellenv)" 
      export PATH="$PATH:${config.home.homeDirectory}/Library/Application Support/JetBrains/Toolbox/scripts"
    '';
    shellAbbrs = {
      rebuild = {
        position = "command";
        expansion = "nh darwin switch -H wm";
      };
    };
  };
}
