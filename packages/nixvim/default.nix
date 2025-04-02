{
  pkgs-stable,
  system,
  nixvim,
  catppuccin,
  ...
}:
nixvim.legacyPackages.${system}.makeNixvimWithModule {
  module = import ./nixvim.nix;
  extraSpecialArgs = {
    pkgs-stable = pkgs-stable;
    catppuccin = catppuccin;
  };
}
