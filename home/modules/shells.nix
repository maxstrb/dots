{
  pkgs,
  device-name,
  ...
}: {
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

      extraConfig =
        /*
        nu
        */
        ''
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
              "zig" => {
                flake zig -c $"nvim ($file)"
              }
              "c" | "cpp" => {
                flake c -c $"nvim ($file)"
              }
              "cs" => {
                flake c-sharp -c $"nvim ($file)"
              }
              _ => {nvim $file}
            }
          }

          def rebuild [message?: string] {
            cd /home/maxag/.nix-config
            let commit_message = if $message != null {$message} else {"non important commit"}

            try {
              git add .
              git commit -m $commit_message
            }

            sudo nixos-rebuild switch --flake .
          }
        '';

      settings = {
        show_banner = false;
      };

      shellAliases = {
        zel = "zellij";
        system = "nvim /home/maxag/.nix-config/flake.nix";
        home = "nvim /home/maxag/.nix-config/home/${device-name}/home.nix";
        config = "nvim /home/maxag/.nix-config/configuration/${device-name}/configuration.nix";
        cat = "bat -p -P";
        nvim = "edit";
        nix-shell = "nix-shell --run nu";
      };
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;

      options = [
        "--cmd cd"
      ];
    };
  };
}
