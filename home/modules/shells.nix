{pkgs, ...}: {
  home.packages = with pkgs; [
    bat
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    bash.enable = true;

    nushell = {
      enable = true;

      extraConfig = ''
        $env.config.buffer_editor = "nvim"

        if "ZELLIJ" in $env == false {
          zellij
          exit
        } else {
          if "IN_NIX_SHELL" in $env == false {
            fastfetch
          }
        }

        def garbage [] {
          sudo nix-collect-garbage --delete-old
          sudo nixos-rebuild switch --flake /home/maxag/.nix-config
        }

        def c [] {
          clear
          fastfetch
        }
      '';

      settings = {
        show_banner = false;
      };

      shellAliases = {
        zel = "zellij";
        rebuild = "sudo nixos-rebuild switch --flake /home/maxag/.nix-config";
        flake = "nvim /home/maxag/.nix-config/flake.nix";
        home = "nvim /home/maxag/.nix-config/home/home.nix";
        config = "nvim /home/maxag/.nix-config/configuration/configuration.nix";
        projects = "cd /mnt/removable/Projekty";
        cat = "bat -p -P";
        nix-shell = "nix-shell --run nu";
      };
    };
  };
}
