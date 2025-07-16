{pkgs, ...}: {
  imports = [
    ./zellij.nix
  ];

  home.packages = with pkgs; [
    fuzzel
    btop
    fastfetch
    oh-my-posh
  ];

  gtk.enable = true;
  qt.enable = true;

  programs = {
    fuzzel.enable = true;
    btop.enable = true;

    fastfetch = {
      enable = true;
      settings = {
        logo = {
          source = "~/.nix-config/assets/shadow-cli.txt";
          type = "file-raw";
          padding.right = 1;
        };

        modules = [
          {
            type = "custom";
            key = "Favorite Anime";
            format = "The Eminence in Shadow";
          }

          "break"

          "os"
          "kernel"
          "cpu"
          "memory"
          {
            type = "gpu";
            key = "GPU";
            detectionMethod = "pci";
            hideType = "integrated";
          }
          "wm"
          "terminal"
          "shell"
          "editor"
        ];
      };
    };

    foot = {
      enable = true;
      settings.main = {
        term = "xterm-256color";
      };
    };

    git = {
      enable = true;

      userEmail = "max.stribrny@gmail.com";
      userName = "max_ag";

      extraConfig = {
        credential.helper = "${
          pkgs.git.override {withLibsecret = true;}
        }/bin/git-credential-libsecret";

        push = {autoSetupRemote = true;};

        init.defaultBranch = "main";
      };
    };

    oh-my-posh = {
      enable = true;

      enableNushellIntegration = true;
      enableBashIntegration = true;

      settings = builtins.fromTOML (builtins.readFile ../../assets/oh-my-posh-shadow.toml);
    };
  };
}
