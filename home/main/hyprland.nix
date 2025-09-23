{pkgs, ...}: {
  imports = [
    ../modules/hyprland.nix
  ];

  wayland.windowManager.hyprland = {
    settings = {
      workspace = [
        "1, monitor:DP-1"
        "2, monitor:DP-2"
      ];
    };

    extraConfig = "
      monitor=DP-1,2560x1440@120,0x0,1
      monitor=DP-2,1920x1080@60,-1920x300,1

      xwayland {
        force_zero_scaling = true
      }
    ";
  };

  programs.hyprpanel = {
    settings = {
      bar = {
        layouts = {
          "*" = {
            left = [
              "dashboard"
              "workspaces"
            ];
            middle = [];
            right = [
              "volume"
              "clock"
              "systray"
              "notifications"
            ];
          };
        };
      };
    };
  };
}
