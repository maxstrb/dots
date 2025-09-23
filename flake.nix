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

  outputs = {nixpkgs, ...} @ inputs: let
    mkSystem = device-name:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs device-name;
        };
        modules = [
          ./configuration/${device-name}/configuration.nix
          ./configuration/${device-name}/hardware-configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              extraSpecialArgs = {inherit inputs device-name;};
              backupFileExtension = "backup_nix";
              users.maxag = ./home/${device-name}/home.nix;
              sharedModules = [
                inputs.stylix.homeModules.stylix
              ];
            };
          }
        ];
      };
  in {
    nixosConfigurations = {
      max-laptop = mkSystem "laptop";
      max-main = mkSystem "main";
    };
  };
}
