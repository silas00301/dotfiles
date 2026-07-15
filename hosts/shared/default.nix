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

    # Necessary for using flakes on this system.
    nix.settings = {
      experimental-features = "nix-command flakes";
      extra-substituters = [ "https://vicinae.cachix.org" ];
      extra-trusted-public-keys = [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];
    };

    programs.fish = {
      enable = true;
      useBabelfish = true;
    };
    users.users.${config.username}.shell = pkgs.zsh;
  };
}
