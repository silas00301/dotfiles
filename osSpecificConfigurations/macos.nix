{
  homebrew.enable = true;

  homebrew.casks = [
    "logi-options+"
  ];

  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "Nlsv";
      ShowPathbar = true;
      ShowStatusBar = true;
    };
  };
}
