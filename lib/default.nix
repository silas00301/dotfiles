{
  self,
  nix-darwin,
  home-manager,
  catppuccin,
  nixpkgs-stable-darwin,
  nixpkgs-stable-nixos,
  nixpkgs,
  lanzaboote,
  spicetify-nix,
  username,
  catppuccinConfig,
  ...
}@inputs:
let
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

  systemToFolderName = {
    x86_64-linux = systemFolders.linux;
    aarch64-linux = systemFolders.linux;
    x86_64-darwin = systemFolders.darwin;
    aarch64-darwin = systemFolders.darwin;
  };

  getInputsForSystem = (
    system:
    let
      overlays = getOverlaysForSystem system;
      systemFolder = systemToFolderName.${system};
    in
    getBaseInputs system
    // {
      pkgs = import nixpkgs {
        inherit system;
        inherit catppuccin;
        overlays = overlays;
        config.allowUnfree = true;
      };
      pkgs-stable =
        if systemFolder == systemFolders.linux then
          (import nixpkgs-stable-nixos {
            system = system;
            config.allowUnfree = true;
          })
        else
          (import nixpkgs-stable-darwin {
            system = system;
            config.allowUnfree = true;
          });
    }
  );

  getBaseInputs = (
    system:
    inputs
    // {
      inherit username;
      currentSystem = system;
      selfPackages = self.packages.${system};
      catppuccin = catppuccinConfig;
      self-path = builtins.path self;
    }
  );

  getPackagesForSystem = (
    system:
    builtins.mapAttrs (folderName: _: getPackageFromFolder system folderName) (
      builtins.readDir (../packages)
    )
  );

  getPackageFromFolder = (
    system: folderName: import ../packages/${folderName} (getInputsForSystem system)
  );

  getConfigurationModuleForSystemAndHost = (
    system: host:
    let
      systemFolder = systemToFolderName.${system};
    in
    {
      imports = [
        ../hosts/${systemFolder}/shared
        ../hosts/shared
        ../hosts/${systemFolder}/hosts/${host}
      ];
    }
  );

  getOverlaysForSystem = (
    system:
    let
      systemInputs = getBaseInputs system;
    in
    builtins.map (folderName: (import ../overlays/${folderName} systemInputs)) (
      builtins.attrNames (builtins.readDir ../overlays)
    )
  );

  getHomeForHost = (
    moduleName: system: host: pkgs: pkgs-stable:
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
              ../home/shared
              ../home/systems/${systemFolder}/shared
              ../home/systems/${systemFolder}/hosts/${host}
              catppuccin.homeModules.catppuccin
              spicetify-nix.homeManagerModules.default
            ];
          };
          extraSpecialArgs = getInputsForSystem system // {
            catppuccin = catppuccinConfig;
            configName = host;
          };
        };
      }
    ]
  );
in
{
  nixosConfigurations = (
    system:
    let
      systemInputs = getInputsForSystem system;
    in
    builtins.mapAttrs (
      folderName: _:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          { inherit username; }
          (getConfigurationModuleForSystemAndHost system folderName)
          {
            _module.args = getBaseInputs system;
          }
          lanzaboote.nixosModules.lanzaboote
          catppuccin.nixosModules.catppuccin
        ] ++ (getHomeForHost "nixosModules" system folderName systemInputs.pkgs systemInputs.pkgs-stable);
      }
    ) (builtins.readDir ../hosts/nixos/hosts)
  );

  darwinConfigurations = (
    system:
    let
      systemInputs = getInputsForSystem system;
    in
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
          {
            _module.args = getBaseInputs system;
          }
        ] ++ (getHomeForHost "darwinModules" system folderName systemInputs.pkgs systemInputs.pkgs-stable);
      }
    ) (builtins.readDir ../hosts/darwin/hosts)
  );

  packages = builtins.mapAttrs (system: _: getPackagesForSystem system) systems;

  formatters = builtins.mapAttrs (system: _: nixpkgs.legacyPackages.${system}.nixfmt-tree) systems;

  linuxSystems = {
    aarch64-linux = systems.aarch64-linux;
    x86_64-linux = systems.x86_64-linux;
  };

  darwinSystems = {
    aarch64-darwin = systems.aarch64-darwin;
    x86_64-darwin = systems.x86_64-darwin;
  };
}
