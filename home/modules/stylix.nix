{pkgs, ...}: {
  stylix = {
    enable = true;
    overlays.enable = false;

    targets = {
      gtk.enable = true;
      qt.enable = true;
    };

    #base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    base16Scheme = {
      base00 = "1e1e2e"; # base
      base01 = "181825"; # mantle
      base02 = "313244"; # surface0
      base03 = "45475a"; # surface1
      base04 = "585b70"; # surface2
      base05 = "cdd6f4"; # text
      base06 = "f5e0dc"; # rosewater
      base07 = "b4befe"; # lavender
      base08 = "f38ba8"; # red
      base09 = "fab387"; # peach
      base0A = "f9e2af"; # yellow
      base0B = "A4E6FF"; # green
      base0C = "94e2d5"; # teal
      base0D = "89b4fa"; # blue
      base0E = "cba6f7"; # mauve
      base0F = "f2cdcd"; # flamingo
    };

    opacity.terminal = 0.75;

    targets.nvf = {
      enable = false;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 14;
    };

    fonts = {
      sizes = {
        applications = 10;
        desktop = 10;
        terminal = 9;
        popups = 8;
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
    };

    polarity = "dark";

    image = ../../assets/shadow_dark.png;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-recent-files-enabled = 0;
      gtk-recent-files-limit = 0;
      gtk-recent-files-max-age = 0;
    };
  };
}
