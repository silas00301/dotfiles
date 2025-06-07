{ pkgs, zen-browser, ... }:
{
  imports = [
    ../../../shared/programs/ghostty.nix
    ../../../shared/programs/hypr.nix
    ../../../shared/programs/rofi.nix
    ../../../shared/programs/spotify-player.nix
    ../../../shared/programs/waybar.nix

    ../../../shared/services/spotifyd.nix
  ];

  home.packages = [
    pkgs.discord
    (pkgs.writeShellScriptBin "spt-st" ../../../shared/scripts/spotify-status.sh)
    zen-browser.packages.${pkgs.system}.default
  ];

  gtk.enable = true;

  programs.hyprlock = {
    enable = true;
  };

  programs.fish = {
    shellAbbrs = {
      rebuild = {
        position = "command";
        expansion = "sudo nixos-rebuild switch --flake ~/dotfiles#pm";
      };
    };
  };
}
