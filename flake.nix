{
  description = "My nix + home-manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-stable-nixos.url = "github:NixOS/nixpkgs/nixos-24.11";

    catppuccin.url = "github:catppuccin/nix";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.1";
  };

  outputs =
    {
      self,
      nix-darwin,
      home-manager,
      catppuccin,
      nixpkgs-stable,
      nixpkgs-stable-nixos,
      nixpkgs,
      lanzaboote,
      ...
    }@inputs:
    let
      username = "silash";

      catppuccinConfig = {
        enable = true;
        flavor = "mocha";
        accent = "lavender";
      };

      darwinConfiguration = {
        inherit username;
      };

      nixosConfiguration = {
        imports = [
          ./baseConfiguration.nix
          ./osSpecificConfigurations/nixos/nixos.nix
        ];
        inherit username;
      };

      systems = {
        x86_64-linux = "x86_64-linux";
        aarch64-linux = "aarch64-linux";
        x86_64-darwin = "x86_64-darwin";
        aarch64-darwin = "aarch64-darwin";
      };

      systemFolders = {
        linux = "nixos";
        darwin = "darwin";
      };

      linuxSystems = {
        aarch64-linux = systems.aarch64-linux;
        x86_64-linux = systems.x86_64-linux;
      };

      darwinSystems = {
        aarch64-darwin = systems.aarch64-darwin;
        x86_64-darwin = systems.x86_64-darwin;
      };

      systemToFolderName = {
        x86_64-linux = systemFolders.linux;
        aarch64-linux = systemFolders.linux;
        x86_64-darwin = systemFolders.darwin;
        aarch64-darwin = systemFolders.darwin;
      };

      getInputsForSystem = (
        system:
        inputs
        // {
          inherit system;
          catppuccin = catppuccinConfig;
          pkgs-stable = import nixpkgs-stable {
            inherit system;
            inherit catppuccin;
            config.allowUnfree = true;
          };
        }
      );

      getPackagesForSystem = (
        system:
        builtins.mapAttrs (folderName: _: getPackageFromFolder system folderName) (
          builtins.readDir ./packages
        )
      );

      getPackageFromFolder = (
        system: folderName: import ./packages/${folderName} (getInputsForSystem system)
      );

      packages = builtins.mapAttrs (system: _: getPackagesForSystem system) systems;

      formatters = builtins.mapAttrs (
        system: _: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style
      ) systems;

      getConfigurationModuleForSystemAndHost = (
        system: host:
        let
          systemFolder = systemToFolderName.${system};
        in
        {
          imports = [
            ./hosts/${systemFolder}/shared
            ./hosts/shared
            ./hosts/${systemFolder}/hosts/${host}
          ];
        }
      );

      getHomeForSystemAndHost = (
        moduleName: system: host:
        let
          systemFolder = systemToFolderName.${system};
          _ = builtins.trace "host: ${host}" host;
        in
        home-manager.${moduleName}.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "bak";
            users.${username} = {
              imports = [
                ./home/shared/shared
                ./home/shared/systems/shared
                ./home/shared/systems/${systemFolder}/shared
                ./home/shared/systems/${systemFolder}/hosts/${host}
              ];
            };
            extraSpecialArgs = {
              inherit username;
              nixvim = self.packages.${system}.nixvim;
              catppuccin = catppuccinConfig;
              configName = host;
              pkgs-stable = import nixpkgs-stable {
                system = system;
                config.allowUnfree = true;
              };
            };
          };
        }
      );

      nixosConfigurations = (
        system:
        builtins.mapAttrs (
          folderName: _:
          nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              (getConfigurationModuleForSystemAndHost system folderName)
              (getHomeForSystemAndHost "nixosModules" system folderName)
              lanzaboote.nixosModules.lanzaboote
              catppuccin.nixosModules.catppuccin
            ];
          }
        ) (builtins.readDir ./hosts/nixos/hosts)
      );

      darwinConfigurations = (
        system:
        builtins.mapAttrs (
          folderName: _:
          nix-darwin.lib.darwinSystem {
            modules = [
              (getConfigurationModuleForSystemAndHost system folderName)
              (getHomeForSystemAndHost "darwinModules" system folderName)
            ];
          }
        ) (builtins.readDir ./hosts/darwin/hosts)
      );
    in
    {
      darwinConfigurations = darwinConfigurations darwinSystems.aarch64-darwin;

      # darwinConfigurations = {
      #   "wm" = nix-darwin.lib.darwinSystem {
      #     modules = [
      #       darwinConfiguration
      #       home-manager.darwinModules.home-manager
      #       {
      #         home-manager.useGlobalPkgs = true;
      #         home-manager.useUserPackages = true;
      #         home-manager.backupFileExtension = "bak";
      #         home-manager.users.${username} = {
      #           imports = [
      #             ./home/home.nix
      #             ./home/homeMac.nix
      #             catppuccin.homeModules.catppuccin
      #           ];
      #         };
      #         home-manager.extraSpecialArgs = {
      #           inherit username;
      #           nixvim = self.packages.aarch64-darwin.nixvim;
      #           catppuccin = catppuccinConfig;
      #           configName = "wm";
      #           pkgs-stable = import nixpkgs-stable {
      #             system = "aarch64-darwin";
      #             config.allowUnfree = true;
      #           };
      #         };
      #       }
      #     ];
      #   };
      # };

      nixosConfigurations = nixosConfigurations linuxSystems.x86_64-linux;

      # nixosConfigurations = {
      #   "nixos" = nixpkgs.lib.nixosSystem {
      #     system = "x86_64-linux";
      #     modules = [
      #       nixosConfiguration
      #       lanzaboote.nixosModules.lanzaboote
      #       catppuccin.nixosModules.catppuccin
      #       home-manager.nixosModules.home-manager
      #       {
      #         home-manager.useGlobalPkgs = true;
      #         home-manager.useUserPackages = true;
      #         home-manager.backupFileExtension = "bak";
      #         home-manager.users.${username} = {
      #           imports = [
      #             ./home/home.nix
      #             ./home/homeNixOS.nix
      #             catppuccin.homeModules.catppuccin
      #             nixvim.homeManagerModules.nixvim
      #           ];
      #         };
      #         home-manager.extraSpecialArgs = {
      #           inherit username;
      #           nixvim = self.packages.x86_64-linux.nixvim;
      #           catppuccin = catppuccinConfig;
      #           pkgs-stable = import nixpkgs-stable-nixos {
      #             system = "x86_64-linux";
      #             config.allowUnfree = true;
      #           };
      #         };
      #       }
      #     ];
      #   };
      # };

      darwinPackages = self.darwinConfigurations."wm".pkgs;

      packages = packages;

      formatter = formatters;
    };
}
