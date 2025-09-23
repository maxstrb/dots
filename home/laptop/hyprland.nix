{pkgs, ...}: {
  imports = [
    ../modules/hyprland.nix
  ];

  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        "$mainMod ALT, left, exec, hyprctl keyword monitor eDP-1,preferred,auto,1,transform,3 && hyprctl keyword input:touchdevice:transform 3 && hyprctl keyword input:tablet:transform 3"
        "$mainMod ALT, right, exec, hyprctl keyword monitor eDP-1,preferred,auto,1,transform,1 && hyprctl keyword input:touchdevice:transform 1 && hyprctl keyword input:tablet:transform 1"
        "$mainMod ALT, up, exec, hyprctl keyword monitor eDP-1,preferred,auto,1,transform,2 && hyprctl keyword input:touchdevice:transform 2 && hyprctl keyword input:tablet:transform 2"
        "$mainMod ALT, down, exec, hyprctl keyword monitor eDP-1,preferred,auto,1,transform,0 && hyprctl keyword input:touchdevice:transform 0 && hyprctl keyword input:tablet:transform 0"
      ];

      workspace = [
        "1, monitor:eDP-1"
      ];
    };

    extraConfig = "
      monitor=eDP-1,1920x1200@60,0x0,1

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
              "battery"
              "notifications"
            ];
          };
        };
      };
    };
  };
}
