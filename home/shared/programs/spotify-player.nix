{ pkgs, ... }:
{
  programs.spotify-player = {
    enable = true;
    themes = [
      {
        name = "Catppuccin-latte";
        palette = {
          foreground = "#4c4f69";
          black = "#eff1f5";
          blue = "#1e66f5";
          cyan = "#04a5e5";
          green = "#40a02b";
          magenta = "#8839ef";
          red = "#d20f39";
          white = "#4c4f69";
          yellow = "#df8e1d";
          bright_black = "#eff1f5";
          bright_blue = "#1e66f5";
          bright_cyan = "#04a5e5";
          bright_green = "#40a02b";
          bright_magenta = "#8839ef";
          bright_red = "#d20f39";
          bright_white = "#4c4f69";
          bright_yellow = "#df8e1d";
        };
        component_style = {
          selection = {
            bg = "#ccd0da";
            modifiers = [ "Bold" ];
          };
          block_title = {
            fg = "Magenta";
          };
          playback_track = {
            fg = "Cyan";
            modifiers = [ "Bold" ];
          };
          playback_album = {
            fg = "Yellow";
          };
          playback_metadata = {
            fg = "Blue";
          };
          playback_progress_bar = {
            bg = "#ccd0da";
            fg = "Green";
          };
          current_playing = {
            fg = "Green";
            modifiers = [ "Bold" ];
          };
          page_desc = {
            fg = "Cyan";
            modifiers = [ "Bold" ];
          };
          table_header = {
            fg = "Blue";
          };
          border = { };
          playback_status = {
            fg = "Cyan";
            modifiers = [ "Bold" ];
          };
          playback_artists = {
            fg = "Cyan";
            modifiers = [ "Bold" ];
          };
          playlist_desc = {
            fg = "#6c6f85";
          };
        };
      }
      {
        name = "Catppuccin-frappe";
        palette = {
          foreground = "#c6d0f5";
          black = "#303446";
          blue = "#8caaee";
          cyan = "#99d1db";
          green = "#a6d189";
          magenta = "#ca9ee6";
          red = "#e78284";
          white = "#c6d0f5";
          yellow = "#e5c890";
          bright_black = "#303446";
          bright_blue = "#8caaee";
          bright_cyan = "#99d1db";
          bright_green = "#a6d189";
          bright_magenta = "#ca9ee6";
          bright_red = "#e78284";
          bright_white = "#c6d0f5";
          bright_yellow = "#e5c890";
        };
        component_style = {
          selection = {
            bg = "#414559";
            modifiers = [ "Bold" ];
          };
          block_title = {
            fg = "Magenta";
          };
          playback_track = {
            fg = "Cyan";
            modifiers = [ "Bold" ];
          };
          playback_album = {
            fg = "Yellow";
          };
          playback_metadata = {
            fg = "Blue";
          };
          playback_progress_bar = {
            bg = "#414559";
            fg = "Green";
          };
          current_playing = {
            fg = "Green";
            modifiers = [ "Bold" ];
          };
          page_desc = {
            fg = "Cyan";
            modifiers = [ "Bold" ];
          };
          table_header = {
            fg = "Blue";
          };
          border = { };
          playback_status = {
            fg = "Cyan";
            modifiers = [ "Bold" ];
          };
          playback_artists = {
            fg = "Cyan";
            modifiers = [ "Bold" ];
          };
          playlist_desc = {
            fg = "#a5adce";
          };
        };
      }
      {
        name = "Catppuccin-macchiato";
        palette = {
          foreground = "#cad3f5";
          black = "#24273a";
          blue = "#8aadf4";
          cyan = "#91d7e3";
          green = "#a6da95";
          magenta = "#c6a0f6";
          red = "#ed8796";
          white = "#cad3f5";
          yellow = "#eed49f";
          bright_black = "#24273a";
          bright_blue = "#8aadf4";
          bright_cyan = "#91d7e3";
          bright_green = "#a6da95";
          bright_magenta = "#c6a0f6";
          bright_red = "#ed8796";
          bright_white = "#cad3f5";
          bright_yellow = "#eed49f";
        };
        component_style = {
          selection = {
            bg = "#363a4f";
            modifiers = [ "Bold" ];
          };
          block_title = {
            fg = "Magenta";
          };
          playback_track = {
            fg = "Cyan";
            modifiers = [ "Bold" ];
          };
          playback_album = {
            fg = "Yellow";
          };
          playback_metadata = {
            fg = "Blue";
          };
          playback_progress_bar = {
            bg = "#363a4f";
            fg = "Green";
          };
          current_playing = {
            fg = "Green";
            modifiers = [ "Bold" ];
          };
          page_desc = {
            fg = "Cyan";
            modifiers = [ "Bold" ];
          };
          table_header = {
            fg = "Blue";
          };
          border = { };
          playback_status = {
            fg = "Cyan";
            modifiers = [ "Bold" ];
          };
          playback_artists = {
            fg = "Cyan";
            modifiers = [ "Bold" ];
          };
          playlist_desc = {
            fg = "#a5adcb";
          };
        };
      }
      {
        name = "Catppuccin-mocha";
        palette = {
          foreground = "#cdd6f4";
          black = "#1e1e2e";
          blue = "#89b4fa";
          cyan = "#89dceb";
          green = "#a6e3a1";
          magenta = "#cba6f7";
          red = "#f38ba8";
          white = "#cdd6f4";
          yellow = "#f9e2af";
          bright_black = "#1e1e2e";
          bright_blue = "#89b4fa";
          bright_cyan = "#89dceb";
          bright_green = "#a6e3a1";
          bright_magenta = "#cba6f7";
          bright_red = "#f38ba8";
          bright_white = "#cdd6f4";
          bright_yellow = "#f9e2af";
        };
        component_style = {
          selection = {
            bg = "#313244";
            modifiers = [ "Bold" ];
          };
          block_title = {
            fg = "Magenta";
          };
          playback_track = {
            fg = "Cyan";
            modifiers = [ "Bold" ];
          };
          playback_album = {
            fg = "Yellow";
          };
          playback_metadata = {
            fg = "Blue";
          };
          playback_progress_bar = {
            bg = "#313244";
            fg = "Green";
          };
          current_playing = {
            fg = "Green";
            modifiers = [ "Bold" ];
          };
          page_desc = {
            fg = "Cyan";
            modifiers = [ "Bold" ];
          };
          table_header = {
            fg = "Blue";
          };
          border = { };
          playback_status = {
            fg = "Cyan";
            modifiers = [ "Bold" ];
          };
          playback_artists = {
            fg = "Cyan";
            modifiers = [ "Bold" ];
          };
          playlist_desc = {
            fg = "#a6adc8";
          };
        };
      }
    ];
  };

  catppuccin.spotify-player.enable = false;

  home.packages = [
    pkgs.librespot
  ];
}
