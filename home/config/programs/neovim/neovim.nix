{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    catppuccin.enable = false;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  home.file = {
    "~/.config/nvim/" = {
      source = ./nvim;
      recursive = true;
    };
  };
}
