{ config, ... }:
let
  wallpaper = "/etc/wallpaper/wallpaper.jpg";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      monitor = [
        "DP-1, 2560x1440@144, 1440x0, 1"
        "HDMI-1, 1920x1080@60, 2300x275, 1"
        "DVI-D-1, 1440x900@59.89, 0x400, 1"
      ];

      "$mod" = "SUPER";

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      bind = [
        "$mod, Q, killactive"
        "$mod, W, exec, kitty"
        "$mod, RETURN, exec, kitty"
        "$mod, B, exec, brave"
        "$mod, L, exec, hyprlock"
        "ALT, SPACE, exec, killall rofi || rofi -show drun"
        "$mod, SPACE, togglefloating"
        "$mod, F, fullscreen, 1"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"

        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPrev, exec, playerctl previous"
      ];
      input = {
        kb_layout = "de";
        follow_mouse = 1;
        sensitivity = 0;
      };

      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "\$${config.catppuccin.accent}";
        "col.inactive_border" = "$base";

        no_border_on_floating = true;
        layout = "master";
      };

      decoration = {
        rounding = 8;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        # drop_shadow = true;
        # shadow_ignore_window = true;
        # shadow_offset = "2 2";
        # shadow_range = 4;
        # shadow_render_power = 2;
        # "col.shadow" = "0x66000000";
        blurls = [
          "gtk-layer-shell"
          "waybar"
        ];

        blur = {
          noise = 2.0e-2;
          size = 10;
          vibrancy = 0.3;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "overshot, 0.05, 0.9, 0.1, 1.05"
          "smoothOut, 0.36, 0, 0.66, -0.56"
          "smoothIn, 0.25, 1, 0.5, 1"
        ];

        animation = [
          "windows, 1, 5, overshot, slide"
          "windowsOut, 1, 4, smoothOut, slide"
          "windowsMove, 1, 4, default"
          "border, 1, 10, default"
          "fade, 1, 10, smoothIn"
          "fadeDim, 1, 10, smoothIn"
          "workspaces, 1, 6, default"
        ];

        windowrule = [
          "float, file_progress"
          "float, confirm"
          "float, dialog"
          "float, download"
          "float, notification"
          "float, error"
          "float, splash"
          "float, confirmreset"
          "float, title:Open File"
          "float, title:branchdialog"
          "float, Lxappearance"
          "float, Rofi"
          "float, jetbrains-toolbox "
          "animation none,Rofi"
          "float,viewnior"
          "float,feh"
          "float, pavucontrol-qt"
          "float, pavucontrol"
          "float, file-roller"
          "fullscreen, wlogout"
          "float, title:wlogout"
          "fullscreen, title:wlogout"
          "idleinhibit focus, mpv"
          "idleinhibit fullscreen, firefox"
          "fullscreen, spotify"
          "float, title:^(Media viewer)$"
          "float, title:^(Volume Control)$"
          "float, title:^(Picture-in-Picture)$"
          "size 800 600, title:^(Volume Control)$"
          "move 75 44%, title:^(Volume Control)$"
          "opacity 0.5, waybar"
        ];
      };
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      background = {
        path = wallpaper;
        blur_passes = 3;
        blur_size = 3;
      };
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ wallpaper ];
      wallpaper = [ ", ${wallpaper}" ];
      splash = false;
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }

        {
          timeout = 360;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}