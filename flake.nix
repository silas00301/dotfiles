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
  };

  outputs =
    {
      self,
      nix-darwin,
      home-manager,
      catppuccin,
      nixpkgs-stable-darwin,
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
          self-path = builtins.path self;
          pkgs-stable = import nixpkgs-stable-darwin {
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

      getHomeForHost = (
        moduleName: system: host:
        let
          systemFolder = systemToFolderName.${system};
        in
        [
          home-manager.${moduleName}.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "bak";
              users.${username} = {
                imports = [
                  ./home/shared
                  ./home/systems/${systemFolder}/shared
                  ./home/systems/${systemFolder}/hosts/${host}
                  catppuccin.homeModules.catppuccin
                ];
              };
              extraSpecialArgs = {
                inherit username;
                nixvim = self.packages.${system}.nixvim;
                catppuccin = catppuccinConfig;
                configName = host;
                pkgs-stable =
                  if systemFolder == "linux" then
                    (import nixpkgs-stable-nixos {
                      system = system;
                      config.allowUnfree = true;
                    })
                  else
                    (import nixpkgs-stable-darwin {
                      system = system;
                      config.allowUnfree = true;
                    });
              };
            };
          }
        ]
      );

      nixosConfigurations = (
        system:
        builtins.mapAttrs (
          folderName: _:
          nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              { inherit username; }
              (getConfigurationModuleForSystemAndHost system folderName)
              lanzaboote.nixosModules.lanzaboote
              catppuccin.nixosModules.catppuccin
            ] ++ (getHomeForHost "nixosModules" system folderName);
          }
        ) (builtins.readDir ./hosts/nixos/hosts)
      );

      darwinConfigurations = (
        system:
        builtins.mapAttrs (
          folderName: _:
          nix-darwin.lib.darwinSystem {
            modules = [
              {
                inherit username;
                system.stateVersion = 5;
                system.configurationRevision = self.rev or self.dirtyRev or null;
              }
              (getConfigurationModuleForSystemAndHost system folderName)
            ] ++ (getHomeForHost "darwinModules" system folderName);
          }
        ) (builtins.readDir ./hosts/darwin/hosts)
      );
    in
    {
      darwinConfigurations = darwinConfigurations darwinSystems.aarch64-darwin;

      nixosConfigurations = nixosConfigurations linuxSystems.x86_64-linux;

      darwinPackages = self.darwinConfigurations."wm".pkgs;

      packages = packages;

      formatter = formatters;
    };
}
