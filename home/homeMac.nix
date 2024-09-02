{ lib, config, pkgs, ... }:

{
  home.homeDirectory = lib.mkForce "/Users/SILHAEU";

  home.packages = with pkgs; [
    raycast
    arc-browser
  ];

  programs.fish = {
    shellInit = ''
      eval "$(/opt/homebrew/bin/brew shellenv)" 
      export PATH="$PATH:${config.home.homeDirectory}/Library/Application Support/JetBrains/Toolbox/scripts"
    '';
  };
}
