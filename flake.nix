{
  description = "My nix-darwin + home-manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";

    catppuccin.url = "github:catppuccin/nix";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nix-darwin,
      home-manager,
      catppuccin,
      nixpkgs-stable,
      nixvim,
      nixpkgs,
      ...
    }:
    let
      username = "silash";

      darwinConfiguration = {
        imports = [
          ./baseConfiguration.nix
          ./osSpecificConfigurations/macos.nix
        ];

        inherit username;

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
        system.stateVersion = 5;
        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;
      };
    in
    {
      # outputs
      darwinConfigurations = {
        "wm" = nix-darwin.lib.darwinSystem {

          modules = [
            darwinConfiguration
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";
              home-manager.users.${username} = {
                imports = [
                  ./home/home.nix
                  ./home/homeMac.nix
                  catppuccin.homeManagerModules.catppuccin
                  nixvim.homeManagerModules.nixvim
                ];
              };
              home-manager.extraSpecialArgs = {
                inherit username;
                configName = "wm";
                pkgs-stable = import nixpkgs-stable {
                  system = "aarch64-darwin";
                  config.allowUnfree = true;
                };
              };
            }
          ];
        };
      };
      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."wm".pkgs;
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;
    };
}
