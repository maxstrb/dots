{pkgs, ...}: {
  home.packages = with pkgs; [
    heroic
    (pkgs.prismlauncher.override {
      jdks = [
        pkgs.temurin-bin-21
        pkgs.temurin-bin-8
        pkgs.temurin-bin-17
      ];
    })
  ];
}
