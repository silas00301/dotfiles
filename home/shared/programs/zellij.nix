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
      layout = {
        default_tab_template = {
          children = [
            {
              pane = {
                size = 1;
                borderless = true;
                plugin = {
                  location = "${pkgs.zjstatus}";
                  format_left = "{mode} #[fg=#89B4FA,bold]{session}";
                  format_center = "{tabs}";
                  format_right = "{command_git_branch} {datetime}";
                  format_space = "";

                  border_enabled = "false";
                  border_char = "─";
                  border_format = "#[fg=#6C7086]{char}";
                  border_position = "top";

                  hide_frame_for_single_pane = "true";

                  mode_normal = "#[bg=blue] ";
                  mode_tmux = "#[bg=#ffc387] ";

                  tab_normal = "#[fg=#6C7086] {name} ";
                  tab_active = "#[fg=#9399B2,bold,italic] {name} ";

                  command_git_branch_command = "git rev-parse --abbrev-ref HEAD";
                  command_git_branch_format = "#[fg=blue] {stdout} ";
                  command_git_branch_interval = "10";
                  command_git_branch_rendermode = "static";

                  datetime = "#[fg=#6C7086,bold] {format} ";
                  datetime_format = "%A, %d %b %Y %H:%M";
                  datetime_timezone = "Europe/Berlin";
                };
              };
            }
          ];
        };
      };
    };
  };
}
