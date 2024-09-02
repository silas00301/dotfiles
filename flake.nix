{
  description = "My nix-darwin + home-manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
    nixpkgs-kitty-fix.url = "github:NixOS/nixpkgs/0c3d12a3e5d4077cf7fee84fcb177237ee8daddf";

    catppuccin.url = "github:catppuccin/nix";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nix-darwin, home-manager, catppuccin, nixpkgs-stable, nixpkgs-kitty-fix, ... }:
    let
      darwinConfiguration = {
        imports = [
          ./baseConfiguration.nix
          ./osSpecificConfigurations/macos.nix
        ];

        username = "SILHAEU";

        nixpkgs.hostPlatform = "aarch64-darwin";

        security.pam.enableSudoTouchIdAuth = true;

        nixpkgs = {
          config = {
            allowUnfree = true;
            allowUnfreePredicate = (_: true);
          };
        };

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 4;
        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;
      };
    in
    {
      # outputs
      darwinConfigurations = {
        "MB-GWXX45QJV4" = nix-darwin.lib.darwinSystem {

          modules = [
            darwinConfiguration
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.SILHAEU = {
                imports = [
                  ./home/home.nix
                  ./home/homeMac.nix
                  catppuccin.homeManagerModules.catppuccin
                ];
              };
              home-manager.extraSpecialArgs = {
                pkgs-stable = import nixpkgs-stable {
                  system = "aarch64-darwin";
                  config.allowUnfree = true;
                };

                pkgs-kitty-fix = import nixpkgs-kitty-fix {
                  system = "aarch64-darwin";
                  config.allowUnfree = true;
                };
              };
            }
          ];
        };
      };
      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."MB-GWXX45QJV4".pkgs;
    };
}
