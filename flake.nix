{
  description = "My personal Hyprland NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nvf.url = "github:notashelf/nvf";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
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

    hyprland.url = "github:hyprwm/Hyprland";

    dolphin-overlay.url = "github:rumboon/dolphin-overlay";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations.max-main = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
      };

      modules = [
        ./configuration/configuration.nix
        ./configuration/hardware-configuration.nix

        inputs.home-manager.nixosModules.default
        {
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;

            extraSpecialArgs = {inherit inputs;};
            backupFileExtension = "backup_nix";

            users.maxag = ./home/home.nix;
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
