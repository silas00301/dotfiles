{
  pkgs-stable,
  currentSystem,
  nixvim,
  catppuccin,
  ...
}:
nixvim.legacyPackages.${currentSystem}.makeNixvimWithModule {
  module = import ./nixvim.nix;
  extraSpecialArgs = {
    pkgs-stable = pkgs-stable;
    catppuccin = catppuccin;
  };
}
