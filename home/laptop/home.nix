{pkgs, ...}: {
  home = {
    username = "maxag";
    homeDirectory = "/home/maxag";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    brightnessctl
  ];

  imports = [
    ./hyprland.nix
    ../modules/nvf.nix
    ../modules/stylix.nix
    ../modules/programming.nix
    ../modules/multimedia.nix
    ../modules/communication.nix
    ../modules/rice.nix
    ../modules/shells.nix
    ../modules/create-project/create-project.nix
  ];
}
