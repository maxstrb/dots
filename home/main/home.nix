{
  home = {
    username = "maxag";
    homeDirectory = "/home/maxag";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;

  imports = [
    ../modules/hyprland.nix
    ../modules/nvf.nix
    ../modules/stylix.nix
    ../modules/games.nix
    ../modules/programming.nix
    ../modules/multimedia.nix
    ../modules/communication.nix
    ../modules/rice.nix
    ../modules/shells.nix
  ];
}
