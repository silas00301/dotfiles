{
  imports = [
    ../../../shared/programs/ghostty.nix
    ../../../shared/programs/hypr.nix
    ../../../shared/programs/rofi.nix
    ../../../shared/programs/waybar.nix
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
