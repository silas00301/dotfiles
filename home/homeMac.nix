{ lib, config, ... }:

{
  home.homeDirectory = lib.mkForce "/Users/SILHAEU";

  programs.fish = {
    shellInit = ''
      eval "$(/opt/homebrew/bin/brew shellenv)" 
      export PATH="$PATH:${config.home.homeDirectory}/Library/Application Support/JetBrains/Toolbox/scripts"
    '';
  };
}
