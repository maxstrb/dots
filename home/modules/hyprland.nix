{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    systemd.variables = ["--all"];

    xwayland.enable = true;

    settings = {
      exec-once = [
        "wl-clip-persist --clipboard both"
        "wl-paste --watch cliphist store"
        "hyprpanel"
      ];

      env = [
        "NIXOS_OZONE_WL, 1"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
      ];

      input = {
        kb_layout = "cz";
        kb_options = "caps:escape";
        numlock_by_default = true;

        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
      };

      misc = {
        disable_hyprland_logo = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = true;
        enable_swallow = true;
        focus_on_activate = true;
        middle_click_paste = false;
      };

      dwindle = {
        force_split = 0;
        special_scale_factor = 1.0;
        split_width_multiplier = 1.0;
        use_active_for_splits = true;
        pseudotile = "yes";
        preserve_split = "yes";
      };

      general = {
        "$mainMod" = "SUPER";
        layout = "dwindle";
        gaps_in = 4;
        gaps_out = 3;
        border_size = 2;
        no_border_on_floating = false;
      };

      decoration = {
        rounding = 7;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;

        blur.enabled = false;
        shadow.enabled = false;
      };

      animations = {
        enabled = true;

        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
        ];

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      binds = {
        movefocus_cycles_fullscreen = true;
      };

      bind = [
        # keybindings
        "$mainMod, Return, exec, foot"
        "$mainMod, B, exec, firefox"
        "$mainMod, Q, killactive,"
        "$mainMod, F, fullscreen, 0"
        "$mainMod SHIFT, F, fullscreen, 1"
        "$mainMod, W, togglefloating"
        "$mainMod, A, exec, fuzzel"
        "$mainMod, P, pseudo,"
        "$mainMod, E, exec, dolphin"
        "$mainMod, C, exec, hyprpicker -a"
        "$mainMod, code:23, swapsplit"
        "$mainMod, code:66, togglesplit"

        # switch focus
        "$mainMod, left,  movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up,    movefocus, u"
        "$mainMod, down,  movefocus, d"
        "$mainMod, h, movefocus, l"
        "$mainMod, j, movefocus, d"
        "$mainMod, k, movefocus, u"
        "$mainMod, l, movefocus, r"

        "$mainMod, left,  alterzorder, top"
        "$mainMod, right, alterzorder, top"
        "$mainMod, up,    alterzorder, top"
        "$mainMod, down,  alterzorder, top"
        "$mainMod, h, alterzorder, top"
        "$mainMod, j, alterzorder, top"
        "$mainMod, k, alterzorder, top"
        "$mainMod, l, alterzorder, top"

        # switch workspace
        "$mainMod, code:10, workspace, 1"
        "$mainMod, code:11, workspace, 2"
        "$mainMod, code:12, workspace, 3"
        "$mainMod, code:13, workspace, 4"
        "$mainMod, code:14, workspace, 5"
        "$mainMod, code:15, workspace, 6"
        "$mainMod, code:16, workspace, 7"
        "$mainMod, code:17, workspace, 8"
        "$mainMod, code:18, workspace, 9"
        "$mainMod, code:19, workspace, 10"

        # same as above, but switch to the workspace
        "$mainMod SHIFT, code:10, movetoworkspacesilent, 1"
        "$mainMod SHIFT, code:11, movetoworkspacesilent, 2"
        "$mainMod SHIFT, code:12, movetoworkspacesilent, 3"
        "$mainMod SHIFT, code:13, movetoworkspacesilent, 4"
        "$mainMod SHIFT, code:14, movetoworkspacesilent, 5"
        "$mainMod SHIFT, code:15, movetoworkspacesilent, 6"
        "$mainMod SHIFT, code:16, movetoworkspacesilent, 7"
        "$mainMod SHIFT, code:17, movetoworkspacesilent, 8"
        "$mainMod SHIFT, code:18, movetoworkspacesilent, 9"
        "$mainMod SHIFT, code:19, movetoworkspacesilent, 10"

        # window control
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, j, movewindow, d"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, l, movewindow, r"

        "$mainMod CTRL, left, resizeactive, -80 0"
        "$mainMod CTRL, right, resizeactive, 80 0"
        "$mainMod CTRL, up, resizeactive, 0 -80"
        "$mainMod CTRL, down, resizeactive, 0 80"
        "$mainMod CTRL, h, resizeactive, -80 0"
        "$mainMod CTRL, j, resizeactive, 0 80"
        "$mainMod CTRL, k, resizeactive, 0 -80"
        "$mainMod CTRL, l, resizeactive, 80 0"

        "$mainMod ALT, left, moveactive,  -80 0"
        "$mainMod ALT, right, moveactive, 80 0"
        "$mainMod ALT, up, moveactive, 0 -80"
        "$mainMod ALT, down, moveactive, 0 80"
        "$mainMod ALT, h, moveactive,  -80 0"
        "$mainMod ALT, j, moveactive, 0 80"
        "$mainMod ALT, k, moveactive, 0 -80"
        "$mainMod ALT, l, moveactive, 80 0"

        # media and volume controls
        # ",XF86AudioMute,exec, pamixer -t"
        ",XF86AudioPlay,exec, playerctl play-pause"
        ",XF86AudioNext,exec, playerctl next"
        ",XF86AudioPrev,exec, playerctl previous"
        ",XF86AudioStop,exec, playerctl stop"
      ];

      # mouse binding
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      windowrule = [
        # "float,class:^(mpv)$"
      ];

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
    enable = true;
    systemd.enable = true;
    settings = {
      bar = {
        launcher.autoDetectIcon = true;

        workspaces.show_numbered = true;

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

      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather.enabled = false;
      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.shortcuts.enabled = true;
      menus.dashboard.stats.enabled = false;
      menus.dashboard.controls.enabled = false;

      theme.bar.transparent = true;
      theme.bar.buttons.dashboard.icon = "#88B1F7";

      theme.bar.buttons.workspaces = {
        hover = "#FFFFFF";
        active = "#FFFFFF";
        occupied = "#88B1F7";
        available = "#88B1F7";
        numbered_active_underline_color = "#FFFFFF";
      };

      theme.bar.buttons.clock.text = "#88B1F7";
      theme.bar.buttons.clock.icon = "#88B1F7";
      theme.bar.menus.menu.clock.time.time = "#88B1F7";
      theme.bar.menus.menu.clock.calendar.weekdays = "#88B1F7";
      theme.bar.menus.menu.clock.calendar.paginator = "#88B1F7";
      theme.bar.menus.menu.clock.calendar.currentday = "#88B1F7";
      theme.bar.buttons.notifications.icon = "#88B1F7";

      theme.bar.menus.menu.volume = {
        label.color = "#88B1F7";
        listitems.active = "#88B1F7";
        iconbutton.active = "#88B1F7";
        audio_slider.primary = "#88B1F7";
        input_slider.primary = "#88B1F7";
      };

      theme.bar.buttons.volume = {
        text = "#88b1f7";
        icon = "#88b1f7";
      };

      theme.font = {
        size = "12px";
      };
    };
  };

  home.packages = with pkgs; [
    hyprpanel
    hyprpicker
    wl-clip-persist
    cliphist
    wf-recorder
    slurp
    grim
    wl-clipboard
  ];
}
