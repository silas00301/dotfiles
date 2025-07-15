{
  programs.aerospace.userSettings = builtins.fromTOML (builtins.readFile ./aerospace.toml);
}
