{ lib, config, ... }@inputs:

{
  home.homeDirectory = lib.mkForce "/Users/${inputs.username}";

  imports = [
    programs/bitwarden.nix

    ../../../shared/programs/aerospace.nix
    ../../../shared/services/janky-borders.nix
  ];

  programs.fish = {
    shellInit = ''
      eval "$(/opt/homebrew/bin/brew shellenv)" 
    '';
    shellAbbrs = {
      rebuild = {
        position = "command";
        expansion = "nh darwin switch -H wm";
      };
    };
  };
}
