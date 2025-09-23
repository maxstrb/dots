{
  imports = [
    ../modules/locale.nix
    ../modules/main-user.nix
    ../modules/system.nix
    ../modules/boot.nix
    ../modules/file-management.nix
    ../modules/desktop.nix
    ../modules/audio.nix
    ../modules/printing.nix
    ../modules/programs.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  services.avahi.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  networking = {
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    networkmanager.enable = false;
    wireless = {
      enable = true;
      networks = {
        aaa = {psk = "laserjet6plas";};
        "Mi Phone" = {psk = "simoneKYS";};
      };
    };

    firewall.enable = true;
  };
}
