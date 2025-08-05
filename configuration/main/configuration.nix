{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./verbatim.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs = {
    config.allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    nushell
    wl-clipboard
    gvfs
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

    portal = {
      enable = true;
    };
  };

  programs = {
    firefox.enable = true;
    bash.blesh.enable = true;
    xfconf.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages."x86_64-linux".hyprland;
      portalPackage = inputs.hyprland.packages."x86_64-linux".xdg-desktop-portal-hyprland;
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        # Add libraries here
      ];
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    #kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_zen;
  };

  networking = {
    hostName = "max-main";
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [8000];
    };
  };

  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    TERMINAL = "foot";
  };

  time.timeZone = "Europe/Prague";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "cs_CZ.UTF-8";
      LC_IDENTIFICATION = "cs_CZ.UTF-8";
      LC_MEASUREMENT = "cs_CZ.UTF-8";
      LC_MONETARY = "cs_CZ.UTF-8";
      LC_NAME = "cs_CZ.UTF-8";
      LC_NUMERIC = "cs_CZ.UTF-8";
      LC_PAPER = "cs_CZ.UTF-8";
      LC_TELEPHONE = "cs_CZ.UTF-8";
      LC_TIME = "cs_CZ.UTF-8";
    };
  };

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

    tumbler.enable = true;
    printing.enable = true;

    displayManager.sddm = {
      enable = true;
      theme = "${import ./sddm-theme.nix {inherit pkgs;}}";
      autoNumlock = true;
    };

    devmon.enable = true;
    gvfs.enable = true;

    pipewire = {
      enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };

      pulse.enable = true;
      jack.enable = true;
    };
  };

  console.keyMap = "cz-lat2";
  security.rtkit.enable = true;

  users.users.maxag = {
    isNormalUser = true;
    description = "Max Ag";
    extraGroups = ["networkmanager" "wheel" "video"];

    shell = pkgs.nushell;
  };

  system = {
    stateVersion = "25.11";
    activationScripts.cleanBackups = ''
      echo "Removing .backup_nix files..."
      find /home/maxag -type f -name "*.backup_nix" -delete
    '';
  };
}
