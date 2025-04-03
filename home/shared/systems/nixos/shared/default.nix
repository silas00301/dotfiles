{
  imports = [
    ../../../programs/chromium.nix
    ../../../programs/ghostty.nix
    ../../../programs/hypr.nix
    ../../../programs/rofi.nix
    ../../../programs/waybar.nix
  ];

  gtk.enable = true;

  catppuccin.gtk = {
    enable = true;
    gnomeShellTheme = true;
    icon.enable = true;
  };

  programs.hyprlock = {
    enable = true;
  };

  programs.fish = {
    shellAbbrs = {
      rebuild = {
        position = "command";
        expansion = "sudo nixos-rebuild switch --flake ~/dotfiles#nixos";
      };
    };
  };
}
