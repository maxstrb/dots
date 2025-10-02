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

          def flake [command?: string] {

          }

          def edit [user_file?: path] {
            let file = if ($user_file | is-empty) {
              pwd
            } else {
              $user_file
            }

            let git_result = do { git rev-parse --show-toplevel } | complete
            if $git_result.exit_code != 0 {
              nvim $file
              return
            }

            let root = $git_result.stdout | str trim
            let flake_path = $root | path join "flake.nix"
            if not ($flake_path | path exists) {
              nvim $file
              return
            }

            # nix develop will exit with error if no devShell exists
            let dev_check = do { nix develop $root --command true } | complete

            if $dev_check.exit_code == 0 {
              if ($user_file | is-empty) {
                nix develop $root --command nvim
              } else {
                nix develop $root --command nvim $file
              }
            } else {
              nvim $file
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
        system = "edit /home/maxag/.nix-config/flake.nix";
        home = "edit /home/maxag/.nix-config/home/${device-name}/home.nix";
        config = "edit /home/maxag/.nix-config/configuration/${device-name}/configuration.nix";
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
