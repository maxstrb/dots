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
          {
            type = "gpu";
            key = "GPU";
            detectionMethod = "pci";
            hideType = "integrated";
          }
          "memory"
          "wm"
          "terminal"
          "shell"
          "editor"
        ];
      };
    };

    foot = {
      enable = true;
      settings = {
        main = {
          term = "xterm-256color";
        };
        #colors = {
        #  alpha = "0.85";
        #};
      };
    };

    git = {
      enable = true;
      package = pkgs.gitFull;
      userName = "maxstrb";
      userEmail = "max.stribrny@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        github.user = "maxstrb";
        credential.helper = "store";
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
