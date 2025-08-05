{
  description = "My personal Hyprland NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations.max-main = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
      };

      modules = [
        ./configuration/main/configuration.nix
        ./configuration/main/hardware-configuration.nix

        inputs.home-manager.nixosModules.default
        {
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;

            extraSpecialArgs = {inherit inputs;};
            backupFileExtension = "backup_nix";

            users.maxag = ./home/main/home.nix;
          };
        }

        inputs.stylix.nixosModules.stylix
        {
          home-manager.sharedModules = [
            inputs.stylix.homeModules.stylix
          ];
        }
      ];
    };

    nixosConfigurations.server = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
      };

      modules = [
        ./configuration/main/configuration.nix.nix
        ./configuration/main/hardware-configuration.nix.nix

        inputs.home-manager.nixosModules.default
        {
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;

            extraSpecialArgs = {inherit inputs;};
            backupFileExtension = "backup_nix";

            users.maxag = ./home/main/home.nix;
          };
        }

        inputs.stylix.nixosModules.stylix
        {
          home-manager.sharedModules = [
            inputs.stylix.homeModules.stylix
          ];
        }
      ];
    };
  };
}
