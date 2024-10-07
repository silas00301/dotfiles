{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      front_end = "WebGpu";
    '';
  };
}
