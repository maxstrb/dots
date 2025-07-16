{pkgs, ...}: {
  home.packages = with pkgs; [
    zellij
  ];

  programs.zellij = {
    enable = true;
    enableBashIntegration = false;
    settings = {
      on_force_close = "quit";
      simplified_ui = true;
      pane_frames = false;
      default_layout = "compact";
      show_startup_tips = false;
    };
  };
}
