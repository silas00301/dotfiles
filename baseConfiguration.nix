{
  pkgs,
  config,
  lib,
  ...
}:

{
  options = {
    username = lib.mkOption { type = lib.types.str; };
  };

  config = {

    environment.systemPackages = with pkgs; [
      vim
      fish
      coreutils
    ];

    services.nix-daemon.enable = true;

    # Necessary for using flakes on this system.
    nix.settings.experimental-features = "nix-command flakes";

    programs.fish = {
      enable = true;
      useBabelfish = true;
    };
    users.users.${config.username}.shell = pkgs.zsh;
  };
}
