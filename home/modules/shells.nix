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

        def flake [
          shell?: string
          --edit (-e)
          --command (-c): string
        ] {
          if $edit {
            nvim ~/.nix-config/flakes/flake.nix
          } else {
            match $command {
              null => {nix develop $"/home/maxag/.nix-config/flakes/#($shell)"}
              _ => {nix develop $"/home/maxag/.nix-config/flakes/#($shell)" --command bash -c $"($command)"}
            }
          }
        }

        def edit [file: path] {
          match ($file | path parse | get extension) {
            "rs" => {
              flake rust -c $"nvim ($file)"
            }
            "c" | "c++" => {
              flake c -c $"nvim ($file)"
            }
            _ => {nvim $file}
          }
        }
      '';

      settings = {
        show_banner = false;
      };

      shellAliases = {
        zel = "zellij";
        rebuild = "sudo nixos-rebuild switch --flake /home/maxag/.nix-config";
        system = "nvim /home/maxag/.nix-config/flake.nix";
        home = "nvim /home/maxag/.nix-config/home/home.nix";
        config = "nvim /home/maxag/.nix-config/configuration/configuration.nix";
        projects = "cd /mnt/removable/Projekty";
        cat = "bat -p -P";
        nix-shell = "nix-shell --run nu";
      };
    };
  };
}
