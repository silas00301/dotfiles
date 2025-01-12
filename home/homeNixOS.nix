{
  imports = [
    ./config/programs/chromium.nix
    ./config/programs/ghostty.nix
    ./config/programs/hypr.nix
    ./config/programs/rofi.nix
    ./config/programs/waybar.nix
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
        expansion = "sudo nixos-rebuild switch --flake ~/dotfiles/";
      };
    };
  };
}
