{ pkgs, lib, ... }:
let
  makeKeyBindings =
    keyBindings:
    let
      convertKey = key: "bind \"${key}\"";
    in
    lib.attrsets.mapAttrs' (key: value: {
      name = convertKey key;
      value = value;
    }) keyBindings;
in
{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    attachExistingSession = true;
    settings = {
      show_startup_tips = false;
      default_shell = "fish";
      ui.pane_frames.rounded_corners = true;
      keybinds = {
        normal = makeKeyBindings {
          "Ctrl x" = {
            SwitchToMode = "pane";
          };
          "Ctrl m" = {
            SwitchToMode = "move";
          };
        };
        pane = makeKeyBindings {
          "h" = {
            MoveFocusOrTab = "Left";
          };
          "j" = {
            MoveFocus = "Down";
          };
          "k" = {
            MoveFocus = "Up";
          };
          "l" = {
            MoveFocusOrTab = "Right";
          };
        };
      };
    };
  };
  xdg.configFile."zellij/layouts/default.kdl".text = ''
    layout {
      default_tab_template {
        children
        pane size=1 borderless=true {
          plugin location="file://${pkgs.zjstatus}/bin/zjstatus.wasm" {
            color_rosewater "#f5e0dc"
            color_flamingo "#f2cdcd"
            color_pink "#f5c2e7"
            color_mauve "#cba6f7"
            color_red "#f38ba8"
            color_maroon "#eba0ac"
            color_peach "#fab387"
            color_yellow "#f9e2af"
            color_green "#a6e3a1"
            color_teal "#94e2d5"
            color_sky "#89dceb"
            color_sapphire "#74c7ec"
            color_blue "#89b4fa"
            color_lavender "#b4befe"
            color_text "#cdd6f4"
            color_subtext1 "#bac2de"
            color_subtext0 "#a6adc8"
            color_overlay2 "#9399b2"
            color_overlay1 "#7f849c"
            color_overlay0 "#6c7086"
            color_surface2 "#585b70"
            color_surface1 "#45475a"
            color_surface0 "#313244"
            color_base "#1e1e2e"
            color_mantle "#181825"
            color_crust "#11111b"

            format_left   "{mode} {session}"
            format_center "{tabs}"
            format_right  "{command_git_branch}"
            format_space  ""
                                                                             
            border_enabled  "true"
            border_char     "─"
            border_format   "{char}"
            border_position "top"
                                                                             
            hide_frame_for_single_pane "true"
                                                                             
            mode_normal        "#[bg=$blue,fg=$crust] NORMAL #[bg=$surface0,fg=$blue]"
            mode_tmux          "#[bg=$maroon,fg=$crust] TMUX #[bg=$surface0,fg=$maroon]" 
            mode_locked        "#[bg=$red,fg=$crust] LOCKED #[bg=$surface0,fg=$red]" 
            mode_resize        "#[bg=$lavender,fg=$crust] RESIZE #[bg=$surface0,fg=$lavender]" 
            mode_pane          "#[bg=$yellow,fg=$crust] PANE #[bg=$surface0,fg=$yellow]" 
            mode_tab           "#[bg=$peach,fg=$crust] TAB #[bg=$surface0,fg=$peach]" 
            mode_scroll        "#[bg=$green,fg=$crust] SCROLL #[bg=$surface0,fg=$green]" 
            mode_enter_search  "#[bg=$teal,fg=$crust] ENTER_SEARCH #[bg=$surface0,fg=$teal]" 
            mode_search        "#[bg=$sapphire,fg=$crust] SEARCH #[bg=$surface0,fg=$sapphire]" 
            mode_rename_tab    "#[bg=$peach,fg=$crust] RENAME TAB #[bg=$surface0,fg=$peach]" 
            mode_rename_pane   "#[bg=$yellow,fg=$crust] RENAME PANE #[bg=$surface0,fg=$yellow]" 
            mode_session       "#[bg=$sky,fg=$crust] SESSION #[bg=$surface0,fg=$sky]" 
            mode_move          "#[bg=$lavender,fg=$crust] MOVE #[bg=$surface0,fg=$lavender]" 
            mode_prompt        "#[bg=$text,fg=$crust] PROMPT #[bg=$surface0,fg=$text]"  

            tab_normal   "#[fg=$text]#[fg=$surface0,bg=$text] {name} #[fg=$text]"
            tab_active   "#[fg=$blue,bold]#[fg=$crust,bg=$blue,bold] {name} #[fg=$blue,bold]"
                                                                             
            command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
            command_git_branch_format      "#[fg=$blue] {stdout} "
            command_git_branch_interval    "10"
            command_git_branch_rendermode  "static"
          }
        }
      }
    }
  '';
}
