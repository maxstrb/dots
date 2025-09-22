{
  imports = [
    ./verbatim.nix
    ../modules/steam.nix

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

  networking = {
    hostName = "max-main";
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [8000];
    };
  };
}
