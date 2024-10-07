{ pkgs, ... }:

{
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "GeistMono" ]; })
    #bitwarden-cli
    rustup
    bat
    bat-extras.prettybat
    bat-extras.batwatch
    bat-extras.batman
    bat-extras.batgrep
    bat-extras.batpipe
    bat-extras.batdiff
    lazydocker
    dogdns
    glow
    #obsidian
    spotify
  ];

  imports = [
    ./config/themes/catppuccin.nix

    ./config/programs/atuin.nix
    ./config/programs/bat.nix
    ./config/programs/bottom.nix
    ./config/programs/bun.nix
    ./config/programs/direnv.nix
    ./config/programs/eza.nix
    ./config/programs/fastfetch.nix
    ./config/programs/fd.nix
    ./config/programs/fish.nix
    ./config/programs/fzf.nix
    ./config/programs/git/git.nix
    ./config/programs/github-cli.nix
    ./config/programs/jq.nix
    ./config/programs/kitty.nix
    ./config/programs/lazygit.nix
    # ./config/programs/neovim/neovim.nix
    ./config/programs/nixvim/nixvim.nix
    ./config/programs/ripgrep.nix
    ./config/programs/starship.nix
    ./config/programs/thefuck.nix
    ./config/programs/tmux.nix
    # ./config/programs/wez-term.nix
    ./config/programs/zoxide.nix
    # ./config/programs/zellij.nix
  ];

  home.sessionVariables = { };

  programs.home-manager.enable = true;
}
