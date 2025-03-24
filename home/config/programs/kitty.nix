{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "Maple Mono NF Regular";
      size = 12;
      package = pkgs.maple-mono.NF;
    };
    shellIntegration.enableFishIntegration = true;
    extraConfig = ''
      tab_bar_min_tabs            2
      tab_bar_edge                bottom
      tab_bar_style               powerline
      tab_powerline_style         round
      tab_title_template          {title}{\' :{}:\'.format(num_windows) if num_windows > 1 else \'\'}
      background_opacity          0.9 
      background_blur             24
      background_image            none
      hide_window_decorations     titlebar-only
    '';
  };
}
