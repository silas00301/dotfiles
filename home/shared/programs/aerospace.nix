{
  programs.aerospace = {
    enable = true;
    userSettings = {
      start-at-login = true;
      gaps = {
        outer.left = 7;
        outer.bottom = 7;
        outer.top = 7;
        outer.right = 7;
        inner.horizontal = 7;
        inner.vertical = 7;
      };
      mode.main.binding = {
        # Window Navigation
        ctrl-h = "focus left";
        ctrl-j = "focus down";
        ctrl-k = "focus up";
        ctrl-l = "focus right";

        # Window Moving
        ctrl-shift-h = "move left";
        ctrl-shift-j = "move down";
        ctrl-shift-k = "move up";
        ctrl-shift-l = "move right";

        # Window Resizing
        cmd-s = "resize width -50";
        cmd-l = "resize smart +50";

        # Workspace Switching
        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-cmd-1 = "workspace 5";
        alt-cmd-2 = "workspace 6";
        alt-cmd-3 = "workspace 7";
        alt-cmd-4 = "workspace 8";
        ctrl-alt-1 = "workspace 9";
        ctrl-alt-2 = "workspace 10";
        ctrl-alt-3 = "workspace 11";
        ctrl-alt-4 = "workspace 12";

        # Workspace Window Moving
        alt-shift-1 = [
          "move-node-to-workspace 1"
          "workspace 1"
        ];
        alt-shift-2 = [
          "move-node-to-workspace 2"
          "workspace 2"
        ];
        alt-shift-3 = [
          "move-node-to-workspace 3"
          "workspace 3"
        ];
        alt-shift-4 = [
          "move-node-to-workspace 4"
          "workspace 4"
        ];
        alt-cmd-shift-1 = [
          "move-node-to-workspace 5"
          "workspace 5"
        ];
        alt-cmd-shift-2 = [
          "move-node-to-workspace 6"
          "workspace 6"
        ];
        alt-cmd-shift-3 = [
          "move-node-to-workspace 7"
          "workspace 7"
        ];
        alt-cmd-shift-4 = [
          "move-node-to-workspace 8"
          "workspace 8"
        ];
        ctrl-cmd-shift-1 = [
          "move-node-to-workspace 9"
          "workspace 9"
        ];
        ctrl-cmd-shift-2 = [
          "move-node-to-workspace 10"
          "workspace 10"
        ];
        ctrl-cmd-shift-3 = [
          "move-node-to-workspace 11"
          "workspace 11"
        ];
        ctrl-cmd-shift-4 = [
          "move-node-to-workspace 12"
          "workspace 12"
        ];

        alt-tab = "workspace-back-and-forth";
        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

        ctrl-shift-1 = "layout tiles horizontal vertical";
        ctrl-shift-2 = "layout accordion horizontal vertical";
      };
    };
  };
}
