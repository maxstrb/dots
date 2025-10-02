{
  pkgs,
  inputs,
  device-name,
  ...
}: {
  environment.systemPackages = with pkgs; [
    wl-clipboard
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  xdg = {
    mime.enable = true;
    menus.enable = true;
    portal.enable = true;
  };

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages."x86_64-linux".hyprland;
      portalPackage = inputs.hyprland.packages."x86_64-linux".xdg-desktop-portal-hyprland;
    };
  };

  security.pam.services.hyprlock = {};

  services = {
    xserver = {
      enable = true;
      videoDrivers = ["amdgpu"];
      xkb = {
        layout = "cz";
        variant = "";
        options = "caps:escape";
      };
    };
    displayManager.sddm = {
      enable = true;
      theme = "${import ../${device-name}/sddm-theme.nix {inherit pkgs;}}";
      autoNumlock = true;
    };
  };

  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    TERMINAL = "foot";
    EDITOR = "nvim";
  };
}
