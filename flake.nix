{
  description = "My nix + home-manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable-darwin.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nixpkgs-stable-nixos.url = "github:NixOS/nixpkgs/nixos-25.05";

    catppuccin.url = "github:catppuccin/nix";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.1";

    zen-browser.url = "github:youwen5/zen-browser-flake";

    zjstatus.url = "github:dj95/zjstatus";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs =
    { self, ... }@inputs:
    let
      username = "silash";

      catppuccinConfig = {
        enable = true;
        flavor = "mocha";
        accent = "lavender";
      };

      lib = import ./lib (
        inputs
        // {
          inherit username;
          inherit catppuccinConfig;
        }
      );
    in
    with lib;
    {
      darwinConfigurations = darwinConfigurations darwinSystems.aarch64-darwin;

      nixosConfigurations = nixosConfigurations linuxSystems.x86_64-linux;

      darwinPackages = self.darwinConfigurations."wm".pkgs;

      packages = packages;

      formatter = formatters;
    };
}
