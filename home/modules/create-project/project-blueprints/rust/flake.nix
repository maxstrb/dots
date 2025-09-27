{
  description = "My rust development shell";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
    overlays = [(import inputs.rust-overlay)];
    pkgs = import nixpkgs {
      inherit system overlays;
    };
  in {
    devShells."${system}" = {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [
          gcc
          gnumake
          rust-bin.stable.latest.default
          evcxr
        ];
      };
    };
  };
}
