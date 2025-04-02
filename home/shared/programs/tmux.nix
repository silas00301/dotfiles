{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    prefix = "C-s";
    clock24 = true;
    escapeTime = 0;
    terminal = "xterm-kitty";
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.tmux-fzf
    ];
    extraConfig = ''
      set-option -g status-position top
      bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "~/.config/tmux/tmux.conf reloaded"
    '';
  };
  programs.fzf.tmux.enableShellIntegration = true;

  catppuccin.tmux.extraConfig = ''
    set -g @catppuccin_window_status_style "rounded"
    set -g @catppuccin_window_number_position "right"
    set -g @catppuccin_window_default_fill "number"
    set -g @catppuccin_window_default_text "#W"
    set -g @catppuccin_window_current_fill "number"
    set -g @catppuccin_window_current_text "#W"
    set -g @catppuccin_status_left_separator  ""
    set -g @catppuccin_status_right_separator ""
    set -g @catppuccin_status_fill "icon"
    set -g @catppuccin_status_connect_separator "yes"
    set -g @catppuccin_directory_text "#{pane_current_path}"
    set -g status-left ""
    set -g  status-right "#{E:@catppuccin_status_directory}"
    set -ag status-right "#{E:@catppuccin_status_user}"
    set -ag status-right "#{E:@catppuccin_status_date_time}"
    set -ag status-right "#{E:@catppuccin_status_session}"
  '';
}
