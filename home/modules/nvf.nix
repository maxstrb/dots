{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;

    settings.vim = {
      theme = {
        enable = true;
        transparent = true;

        name = "catppuccin";
        style = "mocha";
      };
      lsp = {
        enable = true;

        inlayHints.enable = true;
        formatOnSave = true;
        lspkind.enable = true;
        lspsaga.enable = false;
        trouble.enable = true;
      };

      debugger = {
        nvim-dap = {
          enable = true;
          ui.enable = true;
        };
      };

      options = {
        tabstop = 2;
        autoindent = true;
        shiftwidth = 2;
      };

      clipboard = {
        enable = true;
        registers = "unnamedplus";
        providers = {
          wl-copy = {
            enable = true;
            package = pkgs.wl-clipboard;
          };
        };
      };

      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        nix.enable = true;
        markdown.enable = true;

        css.enable = true;
        html.enable = true;
        sql.enable = true;
        ts.enable = true;
        zig.enable = true;
        csharp.enable = true;
        rust = {
          enable = true;
          crates.enable = true;
        };
      };

      visuals = {
        nvim-web-devicons.enable = true;
        nvim-cursorline.enable = true;
        cinnamon-nvim.enable = true;
        fidget-nvim.enable = true;

        highlight-undo.enable = true;
        indent-blankline.enable = true;
      };

      statusline = {
        lualine = {
          enable = true;
        };
      };

      autopairs.nvim-autopairs.enable = true;

      autocomplete = {
        nvim-cmp.enable = false;
        blink-cmp.enable = true;
      };

      snippets.luasnip.enable = true;

      telescope.enable = true;

      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false;
      };

      dashboard.alpha.enable = true;

      notify.nvim-notify.enable = true;

      projects.project-nvim.enable = true;

      utility = {
        ccc.enable = true;
        diffview-nvim.enable = true;
        icon-picker.enable = true;
        surround.enable = true;

        motion = {
          hop.enable = true;
          leap.enable = true;
        };
      };

      comments.comment-nvim.enable = true;

      ui = {
        noice.enable = true;
        colorizer.enable = true;
        illuminate.enable = true;

        fastaction.enable = true;
      };
    };
  };

  xdg.desktopEntries.nvim-foot = {
    name = "Neovim (foot)";
    comment = "Edit text files with Neovim in foot terminal";
    icon = "nvim";
    exec = "foot -e nvim %F";
    categories = ["Utility" "TextEditor" "Development"];
    mimeType = ["text/plain" "text/x-makefile" "application/x-shellscript"];
  };
}
