{ pkgs, ... }:

{
  home.stateVersion = "24.05";

  home.packages = [
    pkgs.nerd-fonts.geist-mono
    pkgs.maple-mono-NF
    # pkgs.bitwarden-cli
    pkgs.rustup
    pkgs.bat
    pkgs.bat-extras.prettybat
    pkgs.bat-extras.batwatch
    pkgs.bat-extras.batman
    pkgs.bat-extras.batgrep
    pkgs.bat-extras.batpipe
    pkgs.bat-extras.batdiff
    pkgs.lazydocker
    pkgs.dogdns
    pkgs.glow
    pkgs.obsidian
    pkgs.spotify
  ];

  imports = [
    ./config/themes/catppuccin.nix

    ./config/programs/atuin.nix
    ./config/programs/bash.nix
    ./config/programs/bat.nix
    ./config/programs/bottom.nix
    ./config/programs/bun.nix
    ./config/programs/direnv.nix
    ./config/programs/eza.nix
    ./config/programs/fastfetch.nix
    ./config/programs/fd.nix
    ./config/programs/fish.nix
    ./config/programs/fzf.nix
    # ./config/programs/ghostty.nix
    ./config/programs/git/git.nix
    ./config/programs/github-cli.nix
    ./config/programs/jq.nix
    ./config/programs/kitty.nix
    ./config/programs/lazygit.nix
    ./config/programs/nixvim.nix
    ./config/programs/ripgrep.nix
    ./config/programs/starship.nix
    ./config/programs/thefuck.nix
    ./config/programs/tmux.nix
    ./config/programs/zoxide.nix
    # ./config/programs/zellij.nix
    ./config/programs/zsh.nix
  ];

  home.sessionVariables = { };

  programs.home-manager.enable = true;
}
