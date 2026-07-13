{
  pkgs,
  selfPackages,
  ...
}:
{
  imports = [
    programs/bitwarden.nix

    ../../../shared/programs/bitwarden.nix
    ../../../shared/programs/ghostty.nix
    ../../../shared/programs/hypr.nix
    ../../../shared/programs/spicetify
    ../../../shared/programs/vicinae.nix

    ../../../shared/services/spotifyd.nix
  ];

  home.packages = [
    pkgs.discord
    pkgs.vesktop
    pkgs.jetbrains.idea
    pkgs.jetbrains.webstorm
  ];

  gtk.enable = true;

  # programs.hyprlock = {
  #   enable = true;
  # };

  programs.fish = {
    shellAbbrs = {
      rebuild = {
        position = "command";
        expansion = "nh os switch";
      };
    };
  };
}
