{ lib, ... }:
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
    };
  };
}
