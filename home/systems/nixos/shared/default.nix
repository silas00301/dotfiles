{
  pkgs,
  selfPackages,
  ...
}:
{
  imports = [
    programs/bitwarden.nix

    ../../../shared/programs/ghostty.nix
    ../../../shared/programs/hypr.nix
    ../../../shared/programs/rofi.nix
    ../../../shared/programs/spicetify
    ../../../shared/programs/spotify-player.nix
    ../../../shared/programs/waybar.nix

    ../../../shared/services/spotifyd.nix
  ];

  home.packages = [
    pkgs.discord
    pkgs.vesktop
    selfPackages.spt-st
  ];

  gtk.enable = true;

  programs.hyprlock = {
    enable = true;
  };

  programs.fish = {
    shellAbbrs = {
      rebuild = {
        position = "command";
        expansion = "nh os switch";
      };
    };
  };
}
