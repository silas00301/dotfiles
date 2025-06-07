{ username, ... }:
{
  programs.nh = {
    enable = true;
    flake = "/home/${username}/dotfiles";
    clean = {
      enable = true;
      extraArgs = "--keep 3 --keep-since 3d";
    };
  };
}
