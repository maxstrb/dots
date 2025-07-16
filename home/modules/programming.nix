{pkgs, ...}: {
  home.packages = with pkgs; [
    rust-bin.stable.latest.default
    dotnetCorePackages.sdk_8_0_3xx-bin
    gcc
    gnumake
    godot
  ];
}
