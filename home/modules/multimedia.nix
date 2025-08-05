{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      libreoffice
      xarchiver
      trilium-next-desktop
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
