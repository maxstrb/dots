{pkgs, ...}: {
  home.packages = with pkgs; [
    libreoffice
    kdePackages.kate
    kdePackages.dolphin
    kdePackages.ark
    trilium-next-desktop
    krita
    libresprite
    mpv
    inkscape
    qimgv
    wineWowPackages.staging
    ytmdesktop
  ];

  home.file.".config/kdeglobals".text = ''
    [General]
    TerminalApplication=foot
  '';
}
