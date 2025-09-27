{
  description = "My rust development shell";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #zig.url = "github:mitchellh/zig-overlay";
  };
  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
    overlays = [(import inputs.rust-overlay)];
    pkgs = import nixpkgs {
      inherit system overlays;
    };
  in {
    devShells."${system}" = {
      c = pkgs.mkShell {
        buildInputs = with pkgs; [
          gcc
          gnumake
        ];
      };

      rust = pkgs.mkShell {
        buildInputs = with pkgs; [
          gcc
          gnumake
          rust-bin.beta.latest.default
          evcxr
        ];
      };

      zig = pkgs.mkShell {
        buildInputs = with pkgs; [
          zig
        ];
      };

      c-sharp = pkgs.mkShell {
        buildInputs = with pkgs; [
          dotnetCorePackages.sdk_9_0-bin
        ];
      };

      python = pkgs.mkShell {
        packages = [
          (pkgs.python3.withPackages (python-pkgs: [
            python-pkgs.numpy
            python-pkgs.pandas
          ]))
        ];
      };

      rice = pkgs.mkShell {
        buildInputs = with pkgs; [
          cmatrix
          asciiquarium
          lavat
          cbonsai
          pipes
          cava
        ];
      };
    };
  };
}
