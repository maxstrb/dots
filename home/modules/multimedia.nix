{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      libreoffice
      xarchiver
      trilium-desktop
      krita
      libresprite
      mpv
      inkscape
      qimgv
      wineWowPackages.staging
      ytmdesktop
    ];

    file = {
      ".config/kdeglobals".text = ''
        [General]
        TerminalApplication=foot
      '';
    };
  };
}
