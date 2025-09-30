{
  description = "My python development shell";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
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
        packages = [
          (pkgs.python3.withPackages (python-pkgs: [
            python-pkgs.numpy
            python-pkgs.pandas
          ]))
        ];
      };
    };
  };
}
