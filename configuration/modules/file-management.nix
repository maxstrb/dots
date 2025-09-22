{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gvfs
  ];

  programs = {
    xfconf.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  services = {
    devmon.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
  };
}
